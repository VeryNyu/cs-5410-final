using Godot;

public partial class NinjaFrog : BaseEnemy
{
    public NinjaFrog()
    {
        ScoreValue = 250;
    }

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

    protected override void OnDeath()
    {
        base.OnDeath();

        Godot.Collections.Array<Node> players = GetTree().GetNodesInGroup("Player");
        if (players.Count > 0 && players[0] is Player player) {
            player.CurrentHealth = 3.0f;
            player.ApplyPowerup(PowerupType.Frog);
        }
    }
}