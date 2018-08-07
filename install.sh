#/bin/bash
dist=$1

if [ ! -n "$dist" ]; then
    echo 'usage : ./install.sh ~'
elif [ -d $dist ]; then
    ln -sf $PWD/.vimrc $dist
    if [ ! -d $dist/.vim ]; then
        ln -sf $PWD $dist
    fi
else
    echo 'not found dir! :'$dist
fi
