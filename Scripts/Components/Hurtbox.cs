using Godot;

public partial class Hurtbox : Area2D
{
    // This creates a custom signal we can hook up in the Godot editor
    [Signal]
    public delegate void DamageTakenEventHandler(int damage);

    public void TakeDamage(int damage)
    {
        // When the Hitbox calls this, emit the signal to alert the Player/Enemy
        EmitSignal(SignalName.DamageTaken, damage);
    }
}