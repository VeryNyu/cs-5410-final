using Godot;

public partial class JumpingIdle : State
{
    [Export] public float JumpSpeed { get; set; } = 220.0f;
    [Export] public float JumpCooldown { get; set; } = 1.2f;

    [Export] public string GroundAnimation { get; set; } = "idle";
    [Export] public string JumpAnimation { get; set; } = "jump";
    [Export] public string FallAnimation { get; set; } = "fall";

    private float _cooldownRemaining;

    public override void Enter()
    {
        _cooldownRemaining = 0.0f;
        PlayAnimIfExists(GroundAnimation);
    }

    public override void PhysicsUpdate(double delta)
    {
        float dt = (float)delta;
        _cooldownRemaining -= dt;

        if (!Enemy.IsOnFloor())
        {
            Vector2 v = Enemy.Velocity;
            if (v.Y < -10.0f)
                PlayAnimIfExists(JumpAnimation);
            else
                PlayAnimIfExists(FallAnimation);
            return;
        }

        RayCast2D wallChecker = Enemy.GetNode<RayCast2D>("WallRayCast");
        RayCast2D ledgeChecker = Enemy.GetNode<RayCast2D>("LedgeRayCast");

        bool hitWall = wallChecker.IsColliding() || Enemy.IsOnWall();
        bool hitLedge = !ledgeChecker.IsColliding();

        if (hitWall || hitLedge)
            Enemy.UpdateFacingDirection(Enemy.FacingDirection * -1);

        Vector2 velocity = Enemy.Velocity;
        velocity.X = 0.0f;

        if (_cooldownRemaining <= 0.0f)
        {
            velocity.Y = -JumpSpeed;

            Vector2 originalLedgePos = ledgeChecker.Position;
            ledgeChecker.Position = new Vector2(Enemy.FacingDirection * Enemy.MoveSpeed * 0.5f, originalLedgePos.Y);
            ledgeChecker.ForceRaycastUpdate();

            hitLedge = !ledgeChecker.IsColliding();

            ledgeChecker.Position = originalLedgePos;

            if (hitLedge)
            {
                velocity.X = 0;
                Enemy.UpdateFacingDirection(Enemy.FacingDirection * -1);
            }
            else
            {
                velocity.X = Enemy.FacingDirection * Enemy.MoveSpeed;
            }

            _cooldownRemaining = JumpCooldown;
            PlayAnimIfExists(JumpAnimation);
        }
        else
        {
            PlayAnimIfExists(GroundAnimation);
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
