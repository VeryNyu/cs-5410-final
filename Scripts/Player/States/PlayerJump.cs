using Godot;

public partial class PlayerJump : PlayerState
{
    public override void Enter()
    {
        PlayerNode.Sprite.Play("jump");

        // Apply jump velocity immediately when entering the state
        Vector2 velocity = PlayerNode.Velocity;
        velocity.Y = PlayerNode.JumpVelocity;
        PlayerNode.Velocity = velocity;
    }

    public override void PhysicsUpdate(double delta)
    {
        Vector2 velocity = PlayerNode.Velocity;

        // Apply gravity
        velocity.Y += PlayerNode.Gravity * (float)delta;

        // if (Input.IsActionJustPressed("move_jump") && PlayerNode.CanDoubleJump)
        // {
        //     StateMachine.ChangeState("DoubleJump");
        //     return;
        // }

        // Horizontal air movement
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

        // Transition to Fall state when we start moving downward (Y > 0)
        if (PlayerNode.Velocity.Y >= 0)
        {
            StateMachine.ChangeState("Fall");
        }
    }
}