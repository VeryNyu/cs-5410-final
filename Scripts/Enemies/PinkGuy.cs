using Godot;

public partial class PinkGuy : BaseEnemy
{
    protected override void Think(double delta)
    {
        if (PlayerTarget != null)
        {
            BehaviorManager.ChangeState("Chase");
        }
        else
        {
            BehaviorManager.ChangeState("Idle");
        }
    }
}