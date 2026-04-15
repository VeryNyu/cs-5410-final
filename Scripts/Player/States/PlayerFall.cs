using Godot;

public partial class PlayerFall : PlayerState
{
    private bool _isHitSignalConnected = false;

    public override void Enter()
    {
        if (PlayerNode.IsKnockedBack)
        {
            PlayerNode.Sprite.Play("hit");
            PlayerNode.Sprite.AnimationFinished += OnAnimationFinished;
            _isHitSignalConnected = true;
        }
        else
        {
            PlayerNode.Sprite.Play("fall");
        }
    }

    public override void Exit()
    {
        if (_isHitSignalConnected)
        {
            // Safely unhook the signal when leaving the state
            PlayerNode.Sprite.AnimationFinished -= OnAnimationFinished;
            _isHitSignalConnected = false;
        }
    }

    private void OnAnimationFinished()
    {
        // When the hit animation ends, turn off the knockback lock
        if (PlayerNode.Sprite.Animation == "hit")
        {
            PlayerNode.IsKnockedBack = false;

            // If we are still airborne, visually switch back to falling
            if (!PlayerNode.IsOnFloor())
            {
                PlayerNode.Sprite.Play("fall");
            }
        }
    }

    public override void PhysicsUpdate(double delta)
    {
        Vector2 velocity = PlayerNode.Velocity;

        // Apply gravity
        velocity.Y += PlayerNode.Gravity * (float)delta;

        if (PlayerNode.IsKnockedBack)
        {
            PlayerNode.Velocity = velocity;
            if (velocity.Y >= 0 && PlayerNode.IsOnFloor())
            {
                PlayerNode.IsKnockedBack = false;
                StateMachine.ChangeState("Idle");
            }
            return; 
        }

        if (Input.IsActionJustPressed("move_jump"))
        {
            if (PlayerNode.CoyoteTimer > 0)
            {
                PlayerNode.CoyoteTimer = 0;
                StateMachine.ChangeState("Jump");
                return;
            }
            else if (PlayerNode.CanDoubleJump && PlayerNode.CurrentPowerup == PowerupType.Frog)
            {
                StateMachine.ChangeState("DoubleJump");
                return;
            }
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