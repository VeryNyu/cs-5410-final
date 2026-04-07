using Godot;

public partial class Player : CharacterBody2D
{
    public AnimatedSprite2D Sprite { get; private set; }
    public PlayerStateMachine StateMachine { get; private set; }

    [Export] public float Speed { get; set; } = 200.0f;
    [Export] public float JumpVelocity { get; set; } = -300.0f;
    public float Gravity { get; private set; } = ProjectSettings.GetSetting("physics/2d/default_gravity").AsSingle();
    public bool CanDoubleJump { get; set; } = true;

    public override void _Ready()
    {
        Sprite = GetNode<AnimatedSprite2D>("AnimatedSprite2D");
        StateMachine = GetNode<PlayerStateMachine>("StateMachine");
        StateMachine.Init(this);
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
}