using Godot;

public partial class JumpingChase : State
{
    [Export] public float JumpSpeed { get; set; } = 280.0f;
    [Export] public float JumpCooldown { get; set; } = 0.55f;
    [Export] public float AirControl { get; set; } = 420.0f;

    [Export] public string GroundAnimation { get; set; } = "idle";
    [Export] public string JumpAnimation { get; set; } = "jump";
    [Export] public string FallAnimation { get; set; } = "fall";

    private float _cooldownRemaining;

    public override void Enter()
    {
        _cooldownRemaining = 0.0f;
        Enemy.Sprite.SpeedScale = 2.0f;
        PlayAnimIfExists(GroundAnimation);
    }

    public override void Exit()
    {
        Enemy.Sprite.SpeedScale = 1.0f;
    }

    public override void PhysicsUpdate(double delta)
    {
        if (Enemy.PlayerTarget == null)
            return;

        float dt = (float)delta;
        Vector2 toPlayer = Enemy.PlayerTarget.GlobalPosition - Enemy.GlobalPosition;
        Vector2 direction = toPlayer.LengthSquared() < 0.0001f
            ? new Vector2(Enemy.FacingDirection, 0.0f)
            : toPlayer.Normalized();
        int faceDir = direction.X < 0 ? -1 : 1;
        Enemy.UpdateFacingDirection(faceDir);

        RayCast2D wallChecker = Enemy.GetNode<RayCast2D>("WallRayCast");
        bool hitWall = wallChecker.IsColliding()
            && wallChecker.GetCollider() is Node wc
            && !wc.IsInGroup("Player");

        Vector2 velocity = Enemy.Velocity;
        _cooldownRemaining -= dt;

        if (Enemy.IsOnFloor())
        {
            velocity.X = 0.0f;

            if (hitWall)
            {
                PlayAnimIfExists(GroundAnimation);
            }
            else if (_cooldownRemaining <= 0.0f)
            {
                velocity.Y = -JumpSpeed;
                velocity.X = faceDir * Enemy.ChaseSpeed;
                _cooldownRemaining = JumpCooldown;
                PlayAnimIfExists(JumpAnimation);
            }
            else
            {
                PlayAnimIfExists(GroundAnimation);
            }
        }
        else
        {
            float targetX = faceDir * Enemy.ChaseSpeed*1.167f;
            velocity.X = Mathf.MoveToward(velocity.X, targetX, AirControl * dt);

            if (velocity.Y < -10.0f)
                PlayAnimIfExists(JumpAnimation);
            else
                PlayAnimIfExists(FallAnimation);
        }

        Enemy.Velocity = velocity;
    }

    private void PlayAnimIfExists(string animName)
    {
        if (Enemy.Sprite.SpriteFrames == null || string.IsNullOrEmpty(animName))
            return;
        if (!Enemy.Sprite.SpriteFrames.HasAnimation(animName))
            return;
        var anim = new StringName(animName);
        if (Enemy.Sprite.Animation != anim)
            Enemy.Sprite.Play(animName);
    }
}
