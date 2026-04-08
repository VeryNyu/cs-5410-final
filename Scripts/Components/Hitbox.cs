using Godot;

public partial class Hitbox : Area2D
{
    [Export] public int Damage { get; set; } = 1;

    public override void _Ready()
    {
        // Listen for when another Area2D enters this Hitbox
        AreaEntered += OnAreaEntered;
    }

    private void OnAreaEntered(Area2D area)
    {
        // Check if the thing we touched is a Hurtbox
        if (area is Hurtbox hurtbox)
        {
            // Prevent hitting ourselves! 
            // Only deal damage if the hurtbox belongs to a different character.
            if (hurtbox.Owner != this.Owner)
            {
                hurtbox.TakeDamage(Damage);
            }
        }
    }
}