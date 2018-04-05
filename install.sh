#/bin/bash
dist=$1

if [ ! -n "$dist" ]; then
    echo 'usage : ./install.sh ~'
elif [ -d $dist ]; then
    config=".vimrc"
    for i in $config; do
        ln -sf `pwd`/$i $dist
    done
    dist_vim="$dist/.vim"
    if [ ! -d $dist_vim ]; then
        ln -sf `pwd` $dist_vim
    fi
else
    echo 'not found dir! :'$dist
fi
