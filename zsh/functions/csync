csync () {
    COURSESDIR="$HOME/Dropbox/Courses"
    EXCLUDES="$HOME/Dropbox/Courses/nya-mecanique/.rsync_excludes"
    USBDIR="/Volumes/KINGSTON2GB/"
    if (( $# == 2)); then
        destdir="$2"
    else
        destdir=$USBDIR
    fi
    if (( $# >= 1 )); then
        case $1 in
            (cea)
                cdir="$COURSESDIR/cea-astro"
                ;;
            (nya)
                cdir="$COURSESDIR/nya-mecanique"
                ;;
            (nyc)
                cdir="$COURSESDIR/nyc-ondes"
                ;;
            (all)
                cdir=($COURSESDIR/*)
                ;;
            (*)
                echo "usage: csync COURSE
        where COURSE is nya, nyc, cea or all"
                exit
                ;;
        esac
        for adir in $cdir; do
            rsync -rtv --delete --exclude-from "$EXCLUDES" "$adir" "$destdir"
        done
    else
        echo "usage: csync COURSE [DESTDIR]
        where COURSE is nya, nyc, cea or all"
    fi
    unset cdir
    unset destdir
    unset EXCLUDES
    unset USBDIR
    unset COURSESDIR
}
