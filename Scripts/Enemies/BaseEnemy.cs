using Godot;

public partial class BaseEnemy : CharacterBody2D
{
    [Export] public float MoveSpeed { get; set; } = 50.0f;
    [Export] public float ChaseSpeed { get; set; } = 100.0f;

    public BehaviorManager BehaviorManager { get; private set; }
    public AnimatedSprite2D Sprite { get; private set; }

    public Node2D PlayerTarget { get; set; }

    private float _gravity = ProjectSettings.GetSetting("physics/2d/default_gravity").AsSingle();

    public override void _Ready()
    {
        BehaviorManager = GetNode<BehaviorManager>("BehaviorManager");
        Sprite = GetNode<AnimatedSprite2D>("AnimatedSprite2D");

        BehaviorManager.Init(this);

        // Make sure "Hurtbox" matches the exact name of the node in your Enemy scene
        Hurtbox enemyHurtbox = GetNode<Hurtbox>("EnemyHurtbox"); 
        enemyHurtbox.DamageTaken += OnDamageTaken;
    }

    public override void _PhysicsProcess(double delta)
    {
        Vector2 velocity = Velocity;

        if (!IsOnFloor())
        {
            velocity.Y += _gravity * (float)delta;
        }
        Velocity = velocity;

        Think(delta);
        BehaviorManager.PhysicsUpdate(delta);

        MoveAndSlide();
    }

    private void OnDamageTaken(int damage)
    {
        // Mario style: instant death!
        // Later we can replace this with a poof animation or sound effect
        CallDeferred(MethodName.QueueFree);
    }

    public int FacingDirection { get; private set; } = 1;

    public void UpdateFacingDirection(int direction)
    {
        // Convert any movement into a simple 1 (right) or -1 (left)
        int newDirection = direction < 0 ? -1 : 1;

        // If we are already facing that way, do nothing
        if (FacingDirection == newDirection) return;

        FacingDirection = newDirection;
        Sprite.FlipH = FacingDirection < 0;

        // Force Raycasts to point the correct way using Absolute Value
        RayCast2D wallChecker = GetNode<RayCast2D>("WallRayCast");
        RayCast2D ledgeChecker = GetNode<RayCast2D>("LedgeRayCast");

        Vector2 wallTarget = wallChecker.TargetPosition;
        wallTarget.X = Mathf.Abs(wallTarget.X) * FacingDirection;
        wallChecker.TargetPosition = wallTarget;

        Vector2 ledgePos = ledgeChecker.Position;
        ledgePos.X = Mathf.Abs(ledgePos.X) * FacingDirection;
        ledgeChecker.Position = ledgePos;
    }

    public void _on_player_detection_zone_body_entered(Node2D body)
    {
        if (body.IsInGroup("Player"))
        {
            PlayerTarget = body;
        }
    }

    public void _on_player_detection_zone_body_exited(Node2D body)
    {
        if (body.IsInGroup("Player"))
        {
            PlayerTarget = null;
        }
    }

    protected virtual void Think(double delta) 
    { 
        // Override this method to implement your enemy's thinking logic
    }
}