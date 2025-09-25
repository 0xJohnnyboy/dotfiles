# Dotfiles

## Restore
1. Clone the repo
```
git clone --bare git@github.com:0xJohnnyboy/dotfiles.git $HOME/.dotfiles
```

3. Define the alias (temporarily, it's already in the .zshrc)
```
alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

5. Checkout
```
dot checkout
```

6. Hide untracked files
```
dot config --local status.showUntrackedFiles no
```

[Inspired by](https://github.com/kalkayan/dotfiles)
