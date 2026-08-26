function ta
    set session $(tmux list-sessions | cut -d ':' -f 1 | fzf --height 90% --reverse)
    if test -n "$session"
        tmux attach-session -t $session
    end
    commandline --function repaint
end
