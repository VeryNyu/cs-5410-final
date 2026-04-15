using Godot;

public partial class PinkGuy : BaseEnemy
{
    public PinkGuy()
    {
        ScoreValue = 50;
    }

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

    protected override void OnDeath()
    {
        base.OnDeath();

        Godot.Collections.Array<Node> players = GetTree().GetNodesInGroup("Player");
        if (players.Count > 0 && players[0] is Player player) {
            player.CurrentHealth = Mathf.Min(player.CurrentHealth + 0.2f, 2.0f);
        }
    }
}