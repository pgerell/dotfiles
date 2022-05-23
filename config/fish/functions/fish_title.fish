# Defined in /tmp/fish.nLvzk8/fish_title.fish @ line 2
function fish_title
    # emacs is basically the only term that can't handle it.
    if not set -q INSIDE_EMACS
	set curcmd (status current-command)
	if [ "$curcmd" = "fish" ]
            echo (prompt_pwd)
        else
            echo $curcmd (prompt_pwd)
        end
    end
end
