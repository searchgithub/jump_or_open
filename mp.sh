export markfile=$HOME/.marks

j_usage()
{
    echo 'Usage:
    "jump to" with "j" or "open with finder/explorer" with "jo" to the specified line number or "choice list number" with keyword in the current ~/.marks file.
    "mark" current path into ~/.marks file with "jm".
    j, jo, jd, jm, show marks file list with line number
    j -h, jo -h, jd -h, jm -h, show help
    j /[SOME_PATH], jo /[SOME_PATH], "jump to" or "open" /SOME_PATH
    j [LINENUM], jo [LINENUM], "jump to" or "open" the LINENUM matched path in ~/.marks file
    j [KYEWORD], jo [KEYWORD], grep -i KEYWORD ~/.marks, list all matched record, show the "choice list number" in first column.
      You can input "choice list number" at first column to "jump to" or "open" the specified path.
      If just match one path, "jump to" or "open" it directly.
    j -, jump to previous folder
    jd [LINENUM], del related item in ~/.marks file
    jd . , delete current path in ~/.marks file
    jm . , mark current path append into ~/.marks file
    jm /[SOME_PATH], add the path to ~/.marks file
    jo . , open current path "." '
}

j_common ()
{
    if [ -z "$ACT_TYPE" ];then
        ACT_TYPE="jump"
    fi

    DE_BUG_FLAG=0
    if [ $DE_BUG_FLAG -eq 1 ]; then
        set -x
    fi

    if [ -z "$1" ]; then
        if [ -f "$markfile" ]; then
            awk '{print NR":"$0}' ${markfile}
        else
            echo "no marks file";
        fi;
    elif [ "$1" = "-h" ]; then
        j_usage
    elif [ "$1" = "-" ] && [ "$ACT_TYPE" = "jump" ]; then
        cd -
    elif [ "$1" = "." ] && [ "$ACT_TYPE" = "open" ]; then
        opendir "./"
    elif [ "$1" = "." ] && [ "$ACT_TYPE" = "del" ]; then
        tmpdir=`pwd`
        echo "del the item in ~/.marks! $tmpdir";
        grep -v "^$tmpdir$" $markfile > $markfile.tmp;
        mv $markfile.tmp $markfile;
    elif [ -d "$1" ]; then
        tmpdir=$1
        if [ "$ACT_TYPE" = "jump" ];then
            cd "$tmpdir"
        elif [ "$ACT_TYPE" = "open" ];then
            opendir "$tmpdir"
        elif [ "$ACT_TYPE" = "del" ];then
            echo "del the item in ~/.marks! $tmpdir";
            grep -v "^$tmpdir$" $markfile > $markfile.tmp;
            mv $markfile.tmp $markfile;
        fi
    else
        if [ -z "`echo $1 | sed -n '/^[0-9][0-9]*$/p'`" ]; then
            cnt=$(grep -ic -- "$1" $markfile);
            if [ $cnt -eq 1 ]; then
                tmpdir=$(grep -i -- "$1" $markfile);
                if [ -d "$tmpdir" ] 2> /dev/null; then
                    if [ "$ACT_TYPE" = "jump" ];then
                        cd "$tmpdir"
                    elif [ "$ACT_TYPE" = "open" ];then
                        opendir "$tmpdir"
                    elif [ "$ACT_TYPE" = "del" ];then
                        echo "del the item in ~/.marks! $tmpdir";
                        grep -v "^$tmpdir$" $markfile > $markfile.tmp;
                        mv $markfile.tmp $markfile;
                    fi
                else
                    if [ "x$tmpdir" = "x" ]; then
                        echo "select dir is null";
                    else
                        echo "del the item in ~/.marks! $tmpdir";
                        grep -v -- "^$tmpdir$" $markfile > $markfile.tmp;
                        mv $markfile.tmp $markfile;
                    fi;
                fi;
            elif [ $cnt -gt 1 ];then
                grep -in -- "$1" $markfile | nl;
                echo -e "input number:";
                read number;
                tmpdir="$(grep -i -- "$1" $markfile|awk -vnumber=$number 'NR==number')";
                grep -n "$tmpdir$" $markfile;
                if [ "x$tmpdir" = "x" ]; then
                    echo "select dir is null";
                else
                    if [ -d "$tmpdir" ] 2> /dev/null; then
                        if [ "$ACT_TYPE" = "jump" ];then
                            cd "$tmpdir"
                        elif [ "$ACT_TYPE" = "open" ];then
                            opendir "$tmpdir"
                        elif [ "$ACT_TYPE" = "del" ];then
                            echo "del the item in ~/.marks! $tmpdir";
                            grep -v "^$tmpdir$" $markfile > $markfile.tmp;
                            mv $markfile.tmp $markfile;
                        fi
                    else
                        echo "del the item in ~/.marks! $tmpdir";
                        grep -v "^$tmpdir$" $markfile > $markfile.tmp;
                        mv $markfile.tmp $markfile;
                    fi;
                fi;
            fi;
        else
            if [ ! -z "$1" ] && [ $1 -le $( cat ${markfile}|wc -l|tr -d '\r\n') ]; then
                tmpdir="$( awk -vrn=$1 'NR==rn' $markfile)";
                if [ "x$tmpdir" = "x" ]; then
                    echo "select dir is null";
                else
                    if [ -d "$tmpdir" ] 2> /dev/null; then
                        if [ "$ACT_TYPE" = "jump" ];then
                            cd "$tmpdir"
                        elif [ "$ACT_TYPE" = "open" ];then
                            opendir "$tmpdir"
                        elif [ "$ACT_TYPE" = "del" ];then
                            echo "del the item in ~/.marks! $tmpdir";
                            grep -v "^$tmpdir$" $markfile > $markfile.tmp;
                            mv $markfile.tmp $markfile;
                        fi
                    else
                        echo "del the item in ~/.marks! $tmpdir";
                        grep -v "^$tmpdir$" $markfile > $markfile.tmp;
                        mv $markfile.tmp $markfile;
                    fi;
                fi;
            else
                echo "no match item";
            fi;
        fi;
    fi
    if [ $DE_BUG_FLAG ];then
        set +x
    fi
}

opendir()
{
output=$1
if [[ -d "${output}" ]]; then
        case ${OSTYPE} in
            linux*)
                xdg-open "${output}"
                ;;
            darwin*)
                open "${output}"
                ;;
            cygwin)
                cygstart "" $(cygpath -w -a ${output})
                ;;
            *)
                echo "Unknown operating system: ${OSTYPE}" 1>&2
                ;;
        esac
fi
}

j(){
    ACT_TYPE="jump" && j_common $*
}

jo()
{
  ACT_TYPE="open" && j_common $*
}

jd(){
    ACT_TYPE="del" && j_common $*
}

jm ()
{
    if [ "$1" = "-h" ]; then
        j_usage
    elif [ -z "$1" ];then
        if [ -f "$markfile" ]; then
            awk '{print NR":"$0}' ${markfile}
        else
            echo "no marks file";
        fi;
    else
        if [ "$1" = "." ];then
            tmpdir=$(pwd)
        elif [ -d "$1" ]; then
            tmpdir=$1
        fi
        if [ "x$tmpdir" != "x" ] && [ -d "$tmpdir" ];then
            grep -w -- "^${tmpdir}$" $markfile > /dev/null 2>&1;
            if [ $? -ne 0 ]; then
                echo "${tmpdir}" >> ${markfile};
            else
                echo "mark exists!";
            fi
        else
            echo "input not match action!"
        fi
    fi
}
