using Godot;

public partial class PlayerRun : PlayerState
{
    public override void Enter()
    {
        PlayerNode.Sprite.Play("run");
    }

    public override void PhysicsUpdate(double delta)
    {
        Vector2 velocity = PlayerNode.Velocity;

        // Apply gravity
        if (!PlayerNode.IsOnFloor())
        {
            StateMachine.ChangeState("Fall");
            return;
        }

        // Check for jump
        if (Input.IsActionJustPressed("move_jump"))
        {
            StateMachine.ChangeState("Jump");
            PlayerNode.CoyoteTimer = 0;
            return;
        }

        // Check for movement
        float direction = Input.GetAxis("move_left", "move_right");

        if (direction == 0)
        {
            StateMachine.ChangeState("Idle");
            return;
        }

        // Flip the sprite based on direction
        if (direction > 0)
        {
            PlayerNode.Sprite.FlipH = false;
        }
        else if (direction < 0)
        {
            PlayerNode.Sprite.FlipH = true;
        }

        velocity.X = direction * PlayerNode.Speed;
        PlayerNode.Velocity = velocity;
    }
}