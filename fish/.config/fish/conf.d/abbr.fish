abbr c clear
abbr cx "chmod +x"

abbr l "eza --group --header --group-directories-first --long --git --all --binary --all --icons"
abbr ls eza

abbr s "sesh connect \"\$(sesh list -i | gum filter --limit 1 --fuzzy --no-sort --placeholder 'Pick a sesh' --prompt='󱐋 ')\""
abbr sl eza

abbr ta "tmux a"
abbr tat "tmux attach -t"

abbr x "chmod +x (ls | gum filter --limit 1 --header 'chmod +x')"

abbr za "zoxide add"
abbr zad "ls -d */ | xargs -I {} zoxide add {}"
abbr ze "zoxide edit"
