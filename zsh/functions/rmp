# Remove a project and its symlink.
rmp () {
    dropbox=~/Dropbox/Projects
    projects=~/Projects
    if (( $# == 1 )); then
        if [[ -a $dropbox/$1 && -a $projects/$1 ]]; then
            rm -rf $dropbox/$1 $projects/$1
        else
            echo source or destination directory does not exist, aborting
        fi
    else
        echo usage: rmp PROJECT_NAME
    fi
    unset dropbox
    unset projects
}
