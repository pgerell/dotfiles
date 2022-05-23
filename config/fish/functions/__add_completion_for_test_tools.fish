function __add_completion_for_test_tools --description='Add completion for test tools scripts' --argument-names scriptname
    complete -c $scriptname -s A -l all-files        -d 'Always generate all extra debug files'
    complete -c $scriptname -s C -l color            -d 'Use color in test text output'
    complete -c $scriptname -r -s E -l exec          -d 'Set system command to execute after each test (see detailed help for info)'
    complete -c $scriptname -s F -l failed           -d 'Run the tests that failed last run'
    complete -c $scriptname -s h -l help             -d 'Print this information (with arg: help for given command)'
    complete -c $scriptname -r -s j -l jobs          -d 'Specifies the number of jobs (test cases) to run simultaneously. Default is 1.'
    complete -c $scriptname -s L -l run-list         -d 'List all directives available in run section'
    complete -c $scriptname -s N -l no-scroll        -d "Don't scroll test cases that went OK, reuse the same output line"
    complete -c $scriptname -s l -l list             -d 'List all directives available in test files'
    complete -c $scriptname -r -s o -l option        -d 'Add compiler flags globally for all tests'
    complete -c $scriptname -s p -l pstb             -d 'Run tests on ASIC PS test bench using target-debugger'
    complete -c $scriptname -s P -l pbtb             -d 'Run tests on ASIC PB test bench using target-debugger'
    complete -c $scriptname -s q -l quiet            -d 'Be less verbose'
    complete -c $scriptname -s s -l skipped          -d 'Run skipped test cases also'
    complete -c $scriptname -s S -l list-skips       -d 'Output summary of reasons why testcases were skipped'
    complete -c $scriptname -r -s T -l title         -d 'Run only tests whose title contains a match for the supplied regex'
    complete -c $scriptname -k -s v -l verbose       -d 'Be more verbose'
    complete -c $scriptname -s W -l wide             -d 'Increase terminal width by 20 characters for printouts. Default is 80'
    #complete -c $scriptname -s x -l xml              -d 'Generate XML output for test results (jUnit format)'
    complete -c $scriptname -s y -l no-sim           -d 'Don\'t run debugger/simulator. Still verify that Sim tests compile correctly'
    complete -c $scriptname -f -a "(__complete_test_cases)"
end
