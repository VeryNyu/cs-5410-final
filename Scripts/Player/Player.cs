using Godot;

public partial class Player : CharacterBody2D
{
    [Signal]
    public delegate void DiedEventHandler();

    public AnimatedSprite2D Sprite { get; private set; }
    public PlayerStateMachine StateMachine { get; private set; }

    [Export] public float Speed { get; set; } = 200.0f;
    [Export] public float JumpVelocity { get; set; } = -300.0f;
    public float Gravity { get; private set; } = ProjectSettings.GetSetting("physics/2d/default_gravity").AsSingle();
    public bool CanDoubleJump { get; set; } = true;
    [Export] public float WallSlideSpeed { get; set; } = 50.0f;
    [Export] public Vector2 WallJumpVelocity { get; set; } = new Vector2(250.0f, -300.0f);
    public double CoyoteTimer { get; set; } = 0.0;
    [Export] public float CoyoteTime { get; set; } = 0.1f;
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
    }

    public override void _Process(double delta)
    {
        StateMachine.Update(delta);
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
        CallDeferred(MethodName.EmitDied);
    }

    private void EmitDied()
    {
        EmitSignal(SignalName.Died);
    }
}