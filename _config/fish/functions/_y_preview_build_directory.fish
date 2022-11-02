function _y_preview_build_directory
    set file_path $argv/CMakeCache.txt
    rg --color=always 'CMAKE_CXX_COMPILER:|CMAKE_C_COMPILER:|CMAKE_BUILD_TYPE:|CMAKE_HOME_DIRECTORY:|SANITIZER:' "$file_path"
end
