# mkp: Make a project
#
# Usage: mkp PROJECT_NAME or
#        mkp GIT_REPOSITORY or
#        mkp BITBUCKET_REPOSITORY
#
# Create a new project directory in ~/Dropbox/Projects and create a symlink to
# that directory in ~/Projects.
#
# If the command line argument ends in '.git', the new project is created by
# cloning the provided git repository.
#
# If the command line argument contains 'bitbucket.org', the new project is
# created by cloning the provided mercurial repository (yes, bitbucket also
# hosts some git repository, but this function does not care).

mkp () {
    dropbox=~/Dropbox/Projects
    projects=~/Projects
    if (( $# == 1 )); then
        if [[ -a $dropbox/$1 || -a $projects/$1 ]]; then
            print source or destination directory exists, aborting
        else
            # Determine if a project should be created from github...
            arg=$1
            if [[ ${arg##*\.} = 'git' ]]; then
                # Get basename of repo
                arg=${${arg##*/}%\.*}
                git clone $1 $dropbox/$arg
            # ... or bitbucket
            elif [[ ${arg#*$bitbucket.org} != $arg ]]; then
                # Get basename of repo
                arg=$arg:t
                hg clone $1 $dropbox/$arg
            else
                mkdir $dropbox/$arg
            fi
            ln -s $dropbox/$arg $projects/$arg && cd $dropbox/$arg
            unset arg
        fi
    else
        print usage: mkp PROJECT_NAME
    fi
    unset dropbox
    unset projects
}
