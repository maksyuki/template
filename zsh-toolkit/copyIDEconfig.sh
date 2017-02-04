#!/usr/bin/zsh
set -o errexit

gitpath="/home/maksyuki/Documents/github/template"
gitpath_vim_linux="/home/maksyuki/Documents/github/template/vim/linux"

echo "The target path is $gitpath"
echo "The target path is $gitpath_vim_linux"
echo "..."

if [[ ! -x $gitpath ]]; then
    echo "no such path or the path is permission denied"; exit 1
elif [[ ! -x $gitpath_vim_linux ]]; then
    echo "no such path or the path is permission denied"; exit 1
fi

if ! cp -Rf ~/.atom $gitpath; then
    echo "copy .atom failed"; exit 1
else
    echo "copy .atom finished"
fi

if ! cp -Rf ~/.oh-my-zsh $gitpath; then
    echo "copy .oh-my-zsh failed"; exit 1
else
    echo "copy .oh-my-zsh finished"
fi

if ! cp -Rf ~/.config/QtProject $gitpath; then
    echo "copy QtProject failed"; exit 1
else
    echo "copy QtProject finished"
fi

if ! cp ~/.tmux.conf $gitpath; then
    echo "copy .tmux.conf failed"; exit 1
else
    echo "copy .tmux.conf finished"
fi

if ! cp /etc/vim/vimrc $gitpath_vim_linux; then
    echo "copy vimrc failed"; exit 1
else
    echo "copy vimrc finished"
fi

if ! cp /usr/share/vim/vim74/colors/monokai.vim $gitpath_vim_linux; then
    echo "copy monokai color theme failed"; exit 1
else
    echo "copy monokai color theme finished"
fi

echo "..."
echo "All done"
