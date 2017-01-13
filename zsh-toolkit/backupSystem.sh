#!/usr/bin/zsh
set -o errexit

datename=$(date +%Y%m%d)
arch=$(uname -n)
arch=$arch"_"$(uname -m)
all="backup_"$arch"_"$datename
#echo $all
backpath="/home/maksyuki/Desktop/maksyuki"

echo "Are you sure to backup system into $all.tgz? [Y/n]"
read is_sure

if [[ $is_sure = [Yy] ]]; then
    tar -cvpzf $all.tgz $backpath
elif [[ $is_sure = [Nn] ]]; then
    echo
    echo "..."
    echo "All done"; exit 1
else
    echo
    echo "..."
    echo "Invalid input"; exit 1
fi

echo "..."
echo "All done"
