using Godot;

public partial class State : Node
{
    public BaseEnemy Enemy { get; set; }

    public virtual void Enter() {}
    public virtual void Exit() {}
    public virtual void Update(double delta) {}
    public virtual void PhysicsUpdate(double delta) {}
}