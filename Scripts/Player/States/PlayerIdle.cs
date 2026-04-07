using Godot;

public partial class PlayerIdle : PlayerState
{
    public override void Enter()
    {
        PlayerNode.Sprite.Play("idle");
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
            return;
        }

        // Check for movement
        float direction = Input.GetAxis("move_left", "move_right");
        if (direction != 0)
        {
            StateMachine.ChangeState("Run");
            return;
        }

        // Decelerate to 0
        velocity.X = Mathf.MoveToward(velocity.X, 0, PlayerNode.Speed);
        PlayerNode.Velocity = velocity;
    }
}