using Godot;

public partial class PlayerWallSlide : PlayerState
{
    public override void Enter()
    {
        PlayerNode.Sprite.Play("wall_jump");
    }

    public override void PhysicsUpdate(double delta)
    {
        Vector2 velocity = PlayerNode.Velocity;

        velocity.Y = PlayerNode.WallSlideSpeed;
        PlayerNode.Velocity = velocity;

        if (Input.IsActionJustPressed("move_jump"))
        {
            StateMachine.ChangeState("WallJump");
            return;
        }

        if (PlayerNode.IsOnFloor())
        {
            StateMachine.ChangeState("Idle");
            return;
        }

        float direction = Input.GetAxis("move_left", "move_right");
        float wallDirection = PlayerNode.GetWallNormal().X < 0 ? 1 : -1;

        if (!PlayerNode.IsOnWall() || direction != wallDirection)
        {
            StateMachine.ChangeState("Fall");
        }
    }
}