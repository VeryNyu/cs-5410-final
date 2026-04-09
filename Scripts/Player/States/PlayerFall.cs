using Godot;

public partial class PlayerFall : PlayerState
{
    public override void Enter()
    {
        if (PlayerNode.Sprite.Animation != "double_jump")
        {
            PlayerNode.Sprite.Play("fall");
        }
    }

    public override void PhysicsUpdate(double delta)
    {
        Vector2 velocity = PlayerNode.Velocity;

        // Apply gravity
        velocity.Y += PlayerNode.Gravity * (float)delta;

        if (Input.IsActionJustPressed("move_jump"))
        {
            if (PlayerNode.CoyoteTimer > 0)
            {
                PlayerNode.CoyoteTimer = 0;
                StateMachine.ChangeState("Jump");
                return;
            }
            // else if (PlayerNode.CanDoubleJump)
            // {
            //     StateMachine.ChangeState("DoubleJump");
            //     return;
            // }
        }

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

        if (PlayerNode.CanWallSlide())
        {
            float wallDirection = PlayerNode.GetWallNormal().X < 0 ? 1 : -1;
            if (direction == wallDirection)
            {
                StateMachine.ChangeState("WallSlide");
                return;
            }
        }

        PlayerNode.Velocity = velocity;

        // Check if we hit the ground
        if (PlayerNode.IsOnFloor())
        {
            if (direction != 0)
            {
                StateMachine.ChangeState("Run");
            }
            else
            {
                StateMachine.ChangeState("Idle");
            }
        }
    }
}