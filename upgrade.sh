#/bin/bash
echo 'start.'
if [ ! -d 'vim.git' ]; then
    unzip vim.git.zip > /dev/null;
fi

# 恢复.git文件夹到各种git项目中
if [ -d 'vim.git' ]; then
    find vim.git -name '.git' | while read i; 
    do
        a=${i#*/};
        dist=${a%.*};
        if [ -d $dist ]; then
            mv -uf $i $dist;
        fi
    done;

    if [ $? -ne 0 ]; then
        rm -rf vim.git/*
    fi
fi

# 执行git pull拉取更新
find bundle/ -name '.git'|while read i; do
    if [ -d $i ]; then
        cd ${i%/*};
        echo "$PWD => git pull";
        git pull;
        cd -
    fi

    dist="vim.git/${i%.*}"
    if [ ! -d $dist ]; then
        mkdir -m 0755 -p $dist
    fi

    mv -f -u $i $dist
done;

# 重新打包各git项目.git目录回vim.git.gip
state=$?
if [ $state -eq 0 ]; then
    echo 'repackaging...'
    zip -r vim.git.zip vim.git > /dev/null;
    rm -rf vim.git;
    echo 'end.'
fi
