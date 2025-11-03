function auto_venv --on-variable PWD --description "Automatically activate the current virtual environment"
    set -l venv_name (basename $PWD | tr . -)

    if test -d $HOME/.cache/virtualenvs/$venv_name
	source $HOME/.cache/virtualenvs/$venv_name/bin/activate.fish
    end
end
