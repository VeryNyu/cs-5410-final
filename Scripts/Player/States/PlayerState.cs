using Godot;

public partial class PlayerState : Node
{
    public Player PlayerNode { get; set; }
    public PlayerStateMachine StateMachine { get; set; }

    public virtual void Enter() {}
    public virtual void Exit() {}
    public virtual void Update(double delta) {}
    public virtual void PhysicsUpdate(double delta) {}
}