function fish_title
    [ -n "$argv[1]" ] && set maybecmd " - $argv[1]" || set maybecmd ""
    echo $USER @ (hostname): (prompt_pwd) $maybecmd

    #switch "$TERM"
    #    case 'screen*'
    #      if set -q SSH_CLIENT
    #        set maybehost (hostname)
    #      else
    #        set maybehost ""
    #      end
    #      # inside the function fish_title(), we need to
    #      # force stdout to reach the terminal
    #      # (status current-command) gives only the command name
    #      echo -ne "\\ek"$maybehost(status current-command)"\\e\\" > /dev/tty
    #end
end
