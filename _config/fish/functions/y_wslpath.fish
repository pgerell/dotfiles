function y_wslpath --description 'Output as wslpath' --argument path
    wslpath "$path" 2> /dev/null
    or echo "$path"
end
