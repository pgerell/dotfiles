function _y_preview_build_directory
    set file_path $argv/CMakeCache.txt
    if y_is_subdirectory /mnt/ "$file_path"
        set rg rg.exe
    else
        set rg /usr/bin/rg
    end
    $rg --color=always 'CMAKE_CXX_COMPILER:|CMAKE_C_COMPILER:|CMAKE_BUILD_TYPE:|CMAKE_HOME_DIRECTORY:|SANITIZER:' "$file_path"
end
