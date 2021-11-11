# Projects
Set-Location c:\
mkdir dev
Set-Location c:\dev
mkdir repos

# ssh key
ssh-keygen -t ed25519 -a 200 -C "dk@davidkunzler.de" -f $HOME/.ssh/id_ed25519 -N '""'
