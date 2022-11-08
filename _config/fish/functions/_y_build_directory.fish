function _y_build_directory --description 'Searches for build directories. Replace the current token with the selected file path.'

    function _y_read_cmake_home --argument-names cmake_file
        /usr/bin/rg -N 'CMAKE_HOME_DIRECTORY:INTERNAL=(.*)' -or '$1' $cmake_file
    end

    function _y_color_green --argument-names git_root
        while read -l line
            set cmake_home (_y_read_cmake_home "$line")
            set color normal
            if y_is_subdirectory "$git_root" "$cmake_home"
                set color green
            end
            echo (set_color $color)$line(set_color normal)
        end
    end

    set fd_opts --base-directory=$HOME/build CMakeCache.txt --absolute-path

    set fzf_arguments --ansi
    set token (commandline --current-token)

    # expand any variables or leading tilde (~) in the token
    set expanded_token (eval echo -- $token)
    # unescape token because it's already quoted so backslashes will mess up the path
    set unescaped_exp_token (string unescape -- $expanded_token)

    set git_root_wsl qwerty12345
    set git_root (git rev-parse --show-toplevel 2> /dev/null)
    and set git_root_wsl (y_wslpath "$git_root")

    set --prepend fzf_arguments --query="$unescaped_exp_token" --preview='_y_preview_build_directory {}'
    set file_path_selected (/usr/bin/fdfind $fd_opts 2>/dev/null | _y_color_green $git_root_wsl | sed 's/\/CMakeCache.txt//g' | _fzf_wrapper $fzf_arguments)
    and commandline --current-token --replace -- (string escape -- $file_path_selected)

    commandline --function repaint
end
