using Godot;

public partial class PlayerWallSlide : PlayerState
{
    private double detachTimer = 0.0;
    private float detachTimeLimit = 0.1f;

    public override void Enter()
    {
        PlayerNode.Sprite.Play("wall_jump");
        detachTimer = detachTimeLimit;
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

        if (!PlayerNode.CanWallSlide())
        {
            StateMachine.ChangeState("Fall");
            return;
        }

        float direction = Input.GetAxis("move_left", "move_right");
        float wallDirection = PlayerNode.GetWallNormal().X < 0 ? 1 : -1;

        if (direction != wallDirection)
        {
            detachTimer -= delta;
            if (detachTimer <= 0)
            {
                StateMachine.ChangeState("Fall");
            }
        }
        else
        {
            detachTimer = detachTimeLimit;
        }
    }
}