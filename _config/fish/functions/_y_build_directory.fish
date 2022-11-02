function _y_build_directory --description 'Searches for build directories. Replace the current token with the selected file path.'
    # --string-cwd-prefix prevents fd >= 8.3.0 from prepending ./ to relative paths
    set fd_opts --base-directory=$HOME/build CMakeCache.txt --absolute-path

    set fzf_arguments --ansi
    set token (commandline --current-token)
    # expand any variables or leading tilde (~) in the token
    set expanded_token (eval echo -- $token)
    # unescape token because it's already quoted so backslashes will mess up the path
    set unescaped_exp_token (string unescape -- $expanded_token)

    set --prepend fzf_arguments --query="$unescaped_exp_token" --preview='_y_preview_build_directory {}'
    set file_path_selected (/usr/bin/fdfind $fd_opts 2>/dev/null | sed 's/\/CMakeCache.txt//g' | _fzf_wrapper $fzf_arguments)

    if test $status -eq 0
        commandline --current-token --replace -- (string escape -- $file_path_selected)
    end

    commandline --function repaint
end
