using Godot;
using System.Collections.Generic;

public partial class PlayerStateMachine : Node
{
    [Export] public NodePath InitialState;
    private PlayerState currentState;
    private Dictionary<string, PlayerState> states = new Dictionary<string, PlayerState>();

    public void Init(Player player)
    {
        foreach (Node child in GetChildren())
        {
            if (child is PlayerState state)
            {
                states[child.Name] = state;
                state.PlayerNode = player;
                state.StateMachine = this;
            }
        }
        
        if (InitialState != null)
        {
            currentState = GetNode<PlayerState>(InitialState);
            currentState.Enter();
        }
    }

    public void ChangeState(string stateName)
    {
        if (!states.ContainsKey(stateName)) return;
        
        currentState?.Exit();
        currentState = states[stateName];
        currentState?.Enter();
    }

    public void Update(double delta)
    {
        currentState?.Update(delta);
    }

    public void PhysicsUpdate(double delta)
    {
        currentState?.PhysicsUpdate(delta);
    }
}