using Godot;

public partial class PlayerWallJump : PlayerState
{
    public override void Enter()
    {
        if (PlayerNode.CanDoubleJump)
        {
            PlayerNode.Sprite.Play("jump");
        }
        else
        {
            PlayerNode.Sprite.Play("double_jump");
        }

        Vector2 velocity = PlayerNode.Velocity;
        float wallDirection = PlayerNode.GetWallNormal().X;

        velocity.X = wallDirection * PlayerNode.WallJumpVelocity.X;
        velocity.Y = PlayerNode.WallJumpVelocity.Y;
        PlayerNode.Velocity = velocity;

        PlayerNode.Sprite.FlipH = wallDirection < 0;
    }

    public override void PhysicsUpdate(double delta)
    {
        Vector2 velocity = PlayerNode.Velocity;

        velocity.Y += PlayerNode.Gravity * (float)delta;

        if (Input.IsActionJustPressed("move_jump"))
        {
            if (PlayerNode.CanDoubleJump && PlayerNode.CurrentPowerup == PowerupType.Frog)
            {
                StateMachine.ChangeState("DoubleJump");
                return;
            }
        }

        float direction = Input.GetAxis("move_left", "move_right");
        if (direction != 0)
        {
            velocity.X = Mathf.MoveToward(velocity.X, direction * PlayerNode.Speed, PlayerNode.Speed * (float)delta * 5f);
            PlayerNode.Sprite.FlipH = direction < 0;
        }

        PlayerNode.Velocity = velocity;

        if (PlayerNode.Velocity.Y >= 0)
        {
            StateMachine.ChangeState("Fall");
        }
    }
}