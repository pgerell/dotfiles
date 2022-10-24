function __complete_test_cases --description "Complete test cases" --argument-names comp
    set --local pushdPerformed
    if test -e CMakeCache.txt
        # Get directory containing the test cases
        set --local localpath (grep "TEST_ROOT_DIR" CMakeCache.txt | dos2unix | cut --delimiter = --fields 2)

        # Make sure the path is a WSL path
        set --local colon (string sub --start 2 --length 1 "$localpath")
        if test "$colon" = ":"
            set localpath (wslpath -u "$localpath")
        end
        if test "$localpath" != ""
            pushd $localpath
            set pushdPerformed 1
        end
    end

    if not set --query comp[1]
        set comp (commandline -ct)
    end

    # HACK: We call into the file completions by using a non-existent command.
    # If we used e.g. `ls`, we'd run the risk of completing its options or another kind of argument.
    # But since we default to file completions, if something doesn't have another completion...

    # Get the directories
    set --local dirs (complete --do-complete "nonexistentcommandooheehoohaahaahdingdongwallawallabingbang $comp" | string match --regex '.*/$')
    if set --query dirs[1]
        printf "%s\tDirectory\n" $dirs
    end

    # Get the test cases
    set --local dirs (complete --do-complete "nonexistentcommandooheehoohaahaahdingdongwallawallabingbang $comp" | string match --regex '.*\.ntf$')
    if set --query dirs[1]
        printf "%s\tTest\n" $dirs
    end

    if test "$pushdPerformed" = "1"
        popd
    end
end
