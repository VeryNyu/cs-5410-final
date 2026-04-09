using Godot;

public partial class Player : CharacterBody2D
{
    [Signal]
    public delegate void DiedEventHandler();

    public AnimatedSprite2D Sprite { get; private set; }
    public PlayerStateMachine StateMachine { get; private set; }

    public int CurrentHealth { get; set; } = 2;
    private bool _isInvincible = false;
    private double _invincibilityTimer = 0.0;
    [Export] public float InvincibilityDuration { get; set; } = 2.0f; // 2 seconds of protection
    public bool IsKnockedBack { get; set; } = false;

    [Export] public float Speed { get; set; } = 200.0f;
    [Export] public float JumpVelocity { get; set; } = -300.0f;
    public float Gravity { get; private set; } = ProjectSettings.GetSetting("physics/2d/default_gravity").AsSingle();

    public bool CanDoubleJump { get; set; } = true;
    public double CoyoteTimer { get; set; } = 0.0;
    [Export] public float CoyoteTime { get; set; } = 0.1f;

    [Export] public float WallSlideSpeed { get; set; } = 50.0f;
    [Export] public Vector2 WallJumpVelocity { get; set; } = new Vector2(250.0f, -300.0f);
    public RayCast2D GroundCheck { get; private set; }

    public override void _Ready()
    {
        Sprite = GetNode<AnimatedSprite2D>("AnimatedSprite2D");
        StateMachine = GetNode<PlayerStateMachine>("StateMachine");
        StateMachine.Init(this);

        Hitbox playerHitbox = GetNode<Hitbox>("PlayerHitbox");
        playerHitbox.AreaEntered += OnPlayerHitboxAreaEntered;

        Hurtbox playerHurtbox = GetNode<Hurtbox>("PlayerHurtbox");
        playerHurtbox.DamageTaken += OnDamageTaken;
        GroundCheck = GetNode<RayCast2D>("GroundCheck");


        // TEMP
        Died += TempOnDied;
    }

    private async void TempOnDied()
    {
        // 1. Stop all movement and state machine logic immediately
        SetPhysicsProcess(false);
        SetProcess(false);

        // 2. Safely disable the damage zones so the dying enemy cannot hurt the player
        GetNode<Area2D>("PlayerHitbox").SetDeferred("monitorable", false);
        GetNode<Area2D>("PlayerHitbox").SetDeferred("monitoring", false);
        GetNode<Area2D>("PlayerHurtbox").SetDeferred("monitorable", false);
        GetNode<Area2D>("PlayerHurtbox").SetDeferred("monitoring", false);

        GetNode<CollisionShape2D>("CollisionShape2D").SetDeferred("disabled", true);

        // 3. Play the death animation (change "hit" to match your exact animation name)
        Sprite.Play("died"); 

        // 4. Wait for the AnimatedSprite2D to finish playing this specific animation
        await ToSignal(Sprite, AnimatedSprite2D.SignalName.AnimationFinished);

        GD.Print("Player died signal emitted! Reloading scene temporarily from Player.cs...");
        GetTree().ReloadCurrentScene();
    }

    public override void _Process(double delta)
    {
        if (_isInvincible)
        {
            _invincibilityTimer -= delta;

            // Flash effect: switch between red and normal every 0.1 seconds
            if (Mathf.PosMod(_invincibilityTimer, 0.2) < 0.1)
            {
                Sprite.Modulate = new Color(1, 0, 0, 0.5f); // Red and semi-transparent
            }
            else
            {
                Sprite.Modulate = new Color(1, 1, 1, 1); // Normal color
            }

            // When the timer hits 0, turn off invincibility and ensure color is normal
            if (_invincibilityTimer <= 0)
            {
                _isInvincible = false;
                Sprite.Modulate = new Color(1, 1, 1, 1);

                // Check for overlapping areas and take damage if an enemy Hitbox is found
                RefreshHurtbox();
            }
        }

        StateMachine.Update(delta);
    }

    private async void RefreshHurtbox()
    {
        Area2D hurtbox = GetNode<Area2D>("PlayerHurtbox");
        
        // Turn it off safely
        hurtbox.SetDeferred("monitoring", false);
        hurtbox.SetDeferred("monitorable", false);
        
        // Wait exactly one physics frame for the engine to update
        await ToSignal(GetTree(), SceneTree.SignalName.PhysicsFrame);
        
        // Turn it back on. This forces Godot to check for collisions from scratch!
        hurtbox.SetDeferred("monitoring", true);
        hurtbox.SetDeferred("monitorable", true);
    }

    public override void _PhysicsProcess(double delta)
    {
        if (IsOnFloor())
        {
            CanDoubleJump = true;
            CoyoteTimer = CoyoteTime;
        }
        else
        {
            CoyoteTimer -= delta;
        }

        StateMachine.PhysicsUpdate(delta);
        MoveAndSlide();
    }

    public bool CanWallSlide()
    {
        if (!IsOnWall()) return false;
        
        if (Velocity.Y < 0) return false;

        if (GroundCheck.IsColliding()) return false;

        // Checks all physical contacts to ensure we are touching a real wall, not an enemy
        for (int i = 0; i < GetSlideCollisionCount(); i++)
        {
            var collider = GetSlideCollision(i).GetCollider();
            if (collider is BaseEnemy)
            {
                return false;
            }
        }
        return true;
    }

    private void OnPlayerHitboxAreaEntered(Area2D area)
    {
        // Check if the thing we touched is a Hurtbox and belongs to an enemy
        if (area is Hurtbox hurtbox && hurtbox.Owner != this)
        {
            // Give the player their double jump back as a reward for the stomp!
            CanDoubleJump = true;
            
            // Force the state machine back into the Jump state. 
            // This automatically applies the jump velocity and animation!
            StateMachine.ChangeState("Jump");
        }
    }

    private void OnDamageTaken(int damage)
    {
        // Ignore damage if we are currently flashing/invincible
        if (_isInvincible) return;

        CurrentHealth -= damage;

        if (CurrentHealth <= 0)
        {
            // Out of health, die normally
            CallDeferred(MethodName.EmitDied);
        }
        else
        {
            // Survived the hit! Start flashing red.
            StartInvincibility();
            IsKnockedBack = true;

            // --- KNOCKBACK LOGIC ---
            Vector2 knockback = Velocity;
            
            // Sprite.FlipH is true if facing left. If facing left, bounce right (positive X).
            // If facing right, bounce left (negative X).
            knockback.X = Sprite.FlipH ? 150f : -150f; 
            knockback.Y = -100f; // Pop up into the air
            
            Velocity = knockback;
            StateMachine.ChangeState("Fall");
        }
    }

    private void StartInvincibility()
    {
        _isInvincible = true;
        _invincibilityTimer = InvincibilityDuration;
    }

    private void EmitDied()
    {
        EmitSignal(SignalName.Died);
    }
}