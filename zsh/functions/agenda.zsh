agenda () {
    if (( $# > 0 )); then
        if (( $# == 1)); then
            agendafile=$1
            increment="+7d"
        else 
            agendafile=$2
            case $1 in
                (d*)
                    increment="+1d"
                    ;;
                (m*)
                    increment="+1m"
                    ;;
                (y*)
                    increment="+1y"
                    ;;
                (*)
                    increment="+7d"
                    ;;
            esac
        fi
        now=`date "+%Y-%m-%d %H:%M"`
        nextweek=`date -v $increment "+%Y-%m-%d %H:%M"`
        awk -v now=$now -v nextweek=$nextweek '$0 >= now && $0 <= nextweek' $agendafile | sort
    else
        echo "usage: agenda [dwmy] AGENDAFILE"
    fi
    unset increment
    unset agendafile
    unset now
    unset nextweek
}
