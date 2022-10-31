if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Set in PATH to avoid cluttering fish_variables with expanded user name
fish_add_path --path $HOME/dotfiles/bin
set -x FZF_DEFAULT_COMMAND "$HOME/dotfiles/bin/fd --type f"
set -x nvm_data "$HOME/.local/share/nvm"
