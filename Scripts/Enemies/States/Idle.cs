using Godot;

public partial class Idle : State
{
    public override void Enter()
    {
        Enemy.Sprite.Play("run");
    }

    public override void PhysicsUpdate(double delta)
    {
        if (Enemy.IsOnFloor())
        {
            RayCast2D wallChecker = Enemy.GetNode<RayCast2D>("WallRayCast");
            RayCast2D ledgeChecker = Enemy.GetNode<RayCast2D>("LedgeRayCast");

            bool hitWall = wallChecker.IsColliding() || Enemy.IsOnWall();
            bool hitLedge = !ledgeChecker.IsColliding();
            bool isStuck = Mathf.Abs(Enemy.GetRealVelocity().X) < 5.0f;

            // We added Enemy.IsOnWall() here to catch small objects!
            if (hitWall || hitLedge || isStuck)
            {
                Enemy.UpdateFacingDirection(Enemy.FacingDirection * -1);
            }

            Vector2 velocity = Enemy.Velocity;
            velocity.X = Enemy.FacingDirection * Enemy.MoveSpeed;
            Enemy.Velocity = velocity;
        }
    }
}