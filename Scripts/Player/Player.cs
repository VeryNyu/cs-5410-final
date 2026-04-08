using Godot;

public partial class Player : CharacterBody2D
{
    public AnimatedSprite2D Sprite { get; private set; }
    public PlayerStateMachine StateMachine { get; private set; }

    [Export] public float Speed { get; set; } = 200.0f;
    [Export] public float JumpVelocity { get; set; } = -300.0f;
    public float Gravity { get; private set; } = ProjectSettings.GetSetting("physics/2d/default_gravity").AsSingle();
    public bool CanDoubleJump { get; set; } = true;
    [Export] public float WallSlideSpeed { get; set; } = 50.0f;
    [Export] public Vector2 WallJumpVelocity { get; set; } = new Vector2(250.0f, -300.0f);

    public override void _Ready()
    {
        Sprite = GetNode<AnimatedSprite2D>("AnimatedSprite2D");
        StateMachine = GetNode<PlayerStateMachine>("StateMachine");
        StateMachine.Init(this);

        Hitbox playerHitbox = GetNode<Hitbox>("PlayerHitbox");
        playerHitbox.AreaEntered += OnPlayerHitboxAreaEntered;

        Hurtbox playerHurtbox = GetNode<Hurtbox>("PlayerHurtbox");
        playerHurtbox.DamageTaken += OnDamageTaken;
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
        }

        StateMachine.PhysicsUpdate(delta);
        MoveAndSlide();
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
        CallDeferred(MethodName.ReloadLevel);
    }

    private void ReloadLevel()
    {
        GetTree().ReloadCurrentScene();
    }
}