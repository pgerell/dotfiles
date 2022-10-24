for f in dotfiles/_*; do ln -s -f $f $(echo $(basename $f) | sed 's/_/./g'); done
