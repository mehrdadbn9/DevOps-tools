#!/bin/bash
git_repo="https://github.com/user/repo.git"
backup_dir="/path/to/backups"
git clone --mirror "$git_repo" "$backup_dir/repo.git" ##--> get all tag and branches