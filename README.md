# jump_or_open

#### Introduction
For mac/linux: base on shell(bash or zsh)
    "jump to" or "open" or "del" with the specified line number or "choice list number" 
    with keyword in the current ~/.marks file.

#### Installation

download mp.sh, then "source mp.sh"

#### Quick-Start
 It can "cd" to certain folder, enter "jm ." to add an entry into .marks file,
 and then use j, jo to "jump to" or "open" the related folder.

#### Usage
    Usage:
    "jump to" with "j" or "open with finder/explorer" with "jo" to the specified line number 
    or "choice list number" with keyword in the current ~/.marks file.
    "mark" current path into ~/.marks file with "jm".
    j, jo, jd, jm, show marks file list with line number
    j -h, jo -h, jd -h, jm -h, show help
    j /[SOME_PATH], jo /[SOME_PATH], "jump to" or "open" /SOME_PATH
    j [LINENUM], jo [LINENUM], jd [LINENUM], "jump to" or "open" 
      or "del" the LINENUM matched path in ~/.marks file
    j [KYEWORD], jo [KEYWORD], jd [KEYWORD], grep -i KEYWORD ~/.marks, 
      list all matched record, show the "choice list number" in first column.
      You can input "choice list number" at first column to "jump to" or "open" the specified path.
      If just match one path, "jump to" or "open" or "del" it directly.
    j -, jump to previous folder
    jd . , delete current path in ~/.marks file
    jm . , mark current path append into ~/.marks file
    jm /[SOME_PATH], add the path to ~/.marks file
    jo . , open current path "." 