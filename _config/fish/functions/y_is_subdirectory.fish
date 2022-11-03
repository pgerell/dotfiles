function y_is_subdirectory --description 'Test if second argument is a sub directory of the first argument' --argument dir sub_dir
    string match -q "$dir/*" "$sub_dir/"
end
