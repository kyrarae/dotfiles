function virtualenv --argument-names 'python_version' --description 'Create a virtual environment with the same name as current directory'
    set -l python_bin

    if not test -n "$python_version"
	# Use the default python version set by mise
	set python_bin (which python)
    else
	set python_bin ($HOME/.local/share/mise/installs/python/$python_version/bin/python)
    end

    set -l venv_name (basename $PWD | tr . -)

    if not test -e $python_bin
	echo "Python versino `$python_version` is not installed."
	return 1
    end

    echo "Creating virtualenv `$venv_name`"
    $python_bin -m venv $HOME/.cache/virtualenvs/$venv_name
    source $HOME/.cache/virtualenvs/$venv_name/bin/activate.fish
end
