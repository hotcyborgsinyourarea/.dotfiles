```bash
alias dotf='git --git-dir="$HOME/.dotfiles" --work-tree="$HOME"'
echo ".dotfiles" >> .gitignore
git clone --bare git@github.com:cronsorcery/.dotfiles.git $HOME/.dotfiles
mkdir -p /tmp/dotfiles-backup
dotf checkout 2>&1 | grep -E '\s+\.' | awk '{print $1}' | xargs -I'{}' mv '{}' /tmp/dotfiles-backup/
dotf checkout
dotf config --local status.showUntrackedFiles no
```
