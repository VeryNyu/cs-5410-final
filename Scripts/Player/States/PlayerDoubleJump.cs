using Godot;

public partial class PlayerDoubleJump : PlayerState
{
    public override void Enter()
    {
        PlayerNode.Sprite.Play("double_jump");
        PlayerNode.CanDoubleJump = false;

        Vector2 velocity = PlayerNode.Velocity;
        velocity.Y = PlayerNode.JumpVelocity;
        PlayerNode.Velocity = velocity;
    }

    public override void PhysicsUpdate(double delta)
    {
        Vector2 velocity = PlayerNode.Velocity;

        velocity.Y += PlayerNode.Gravity * (float)delta;

        float direction = Input.GetAxis("move_left", "move_right");
        if (direction != 0)
        {
            PlayerNode.Sprite.FlipH = direction < 0;
            velocity.X = direction * PlayerNode.Speed;
        }
        else
        {
            velocity.X = Mathf.MoveToward(velocity.X, 0, PlayerNode.Speed);
        }

        PlayerNode.Velocity = velocity;

        if (PlayerNode.Velocity.Y >= 0)
        {
            StateMachine.ChangeState("Fall");
        }
    }
}