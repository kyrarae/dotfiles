function fp -d "A simple file picker that pipes the selected file(s) to $EDITOR"
    set -l sel (fzf -m --preview="bat --color=always {}")
    if test "$sel" != ""
	$EDITOR $sel
    end
end
