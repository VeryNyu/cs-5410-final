using Godot;

public partial class Chase : State
{

    public override void Enter()
    {
        Enemy.Sprite.Play("run");
        Enemy.Sprite.SpeedScale = 2.0f;
    }

    public override void Exit()
    {
        Enemy.Sprite.SpeedScale = 1.0f;
    }

    public override void PhysicsUpdate(double delta)
    {
        if (Enemy.PlayerTarget != null)
        {
            Vector2 direction = (Enemy.PlayerTarget.GlobalPosition - Enemy.GlobalPosition).Normalized();

            // Tell the Base Enemy to face the player (-1 for left, 1 for right)
            int faceDir = direction.X < 0 ? -1 : 1;
            Enemy.UpdateFacingDirection(faceDir);

            RayCast2D ledgeChecker = Enemy.GetNode<RayCast2D>("LedgeRayCast");
            RayCast2D wallChecker = Enemy.GetNode<RayCast2D>("WallRayCast");
            bool hitLedge = !ledgeChecker.IsColliding();
            bool hitWall = wallChecker.IsColliding() && wallChecker.GetCollider() is Node collider && !collider.IsInGroup("Player");
            bool isStuck = Mathf.Abs(Enemy.GetRealVelocity().X) < 5.0f;

            Vector2 velocity = Enemy.Velocity;
            if (hitLedge || hitWall)
            {
                velocity.X = 0;
                Enemy.Sprite.Play("idle");
            } else
            {
                velocity.X = faceDir * Enemy.ChaseSpeed;
                if (isStuck)
                {
                    Enemy.Sprite.Play("idle");
                } else {
                    Enemy.Sprite.Play("run");
                }
            }
            Enemy.Velocity = velocity;
        }
    }
}