using Godot;

public partial class BehaviorManager : Node
{
    [Export]
    public string InitialStateName;

    private State _currentState;

    public void Init(BaseEnemy enemy)
    {
        foreach (Node child in GetChildren())
        {
            if (child is State state)
            {
                state.Enemy = enemy;
            }
        }

        if (InitialStateName != null)
        {
            _currentState = GetNode<State>(InitialStateName);
            _currentState.Enter();
        }
    }

    public void PhysicsUpdate(double delta)
    {
        _currentState?.PhysicsUpdate(delta);
    }

    public void ChangeState(string newStateName)
    {
        State newState = GetNodeOrNull<State>(newStateName);
        if (newState != null && newState != _currentState)
        {
            _currentState?.Exit();
            _currentState = newState;
            _currentState.Enter();
        }
    }
}