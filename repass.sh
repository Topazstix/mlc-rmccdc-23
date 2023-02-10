#!/bin/bash
grep -wE '(\/bin\/sh|bash|ash|zsh|fish)' /etc/passwd | cut -d ':' -f 1 > userlist.txt

for i in `more userlist.txt `;do
    echo -e "new_password\nnew_password" | passwd $i
done