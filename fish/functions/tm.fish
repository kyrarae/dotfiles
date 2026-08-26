function tm
    set session_name (basename (pwd))
    if tmux has-session -t $session_name
        echo "Tmux session '$session_name' already exists."
        tmux attach-session -t $session_name
    else
        tmux new-session -s $session_name
    end
end
