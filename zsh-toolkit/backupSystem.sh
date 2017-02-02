#!/usr/bin/zsh
set -o errexit

datename=$(date +%Y%m%d)
arch=$(uname -n)
arch=$arch"_"$(uname -m)
all="backup_"$arch"_"$datename
#echo $all
backpath="/"

echo "Are you sure to backup system into $all.tgz? [Y/n]"
read is_sure

#can not have opinion after -f
if [[ $is_sure = [Yy] ]]; then
    sudo su
    cd /
    echo "Do you want to start backup right now? [Y/n]"
    read is_start
    if [[ $is_start = [Yy] ]]; then
        tar -pczvf $all.tgz --exclude=/proc --exclude=/lost+found --exclude=/$all.tgz --exclude=/mnt --exclude=/sys --exclude=/media $backpath
        exit
    elif [[ $is_start = [Nn] ]]; then
        exit
        echo
        echo "Cancel backup task"
        echo "..."
        echo "All done"; exit 1
    else
        exit
        echo "..."
        echo "Invalid input"; exit 1
    fi
elif [[ $is_sure = [Nn] ]]; then
    echo
    echo "Cancel backup task"
    echo "..."
    echo "All done"; exit 1
else
    echo
    echo "..."
    echo "Invalid input"; exit 1
fi

echo "..."
echo "All done"
