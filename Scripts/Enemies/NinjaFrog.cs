using Godot;

public partial class NinjaFrog : BaseEnemy
{
    protected override void Think(double delta)
    {
        // If he sees you, he chases you. If he doesn't, he patrols. Simple and clean!
        if (PlayerTarget != null)
        {
            BehaviorManager.ChangeState("JumpingChase");
        }
        else
        {
            BehaviorManager.ChangeState("JumpingIdle");
        }
    }
}