#!/bin/bash
selected=$(cat ~/.config/bin/scripts/.tmux-cht-languages ~/.config/bin/scripts/.tmux-cht-commands | zf)

echo $selected

if [[ -z $selected ]]; then
    exit 0
fi

read -p "Enter Query: " query

if grep -qs "$selected" ~/.config/bin/scripts/.tmux-cht-languages; then
    query=`echo $query | tr ' ' '+'`
    tmux neww -n "cht:$selected" bash -c "echo \"curl cht.sh/$selected/$query/\" & curl cht.sh/$selected/$query & while [ : ]; do sleep 1; done"
else
    tmux neww "cht:$selected" bash -c "curl -s cht.sh/$selected~$query | less"
fi

