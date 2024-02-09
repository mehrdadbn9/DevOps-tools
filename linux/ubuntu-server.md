# ubutnu server 22.04
Keyboard, Video, and Mouse (KVM)
Uninterruptible Power Supply (UPS)
make falsh bootable at linux: "https://www.balena.io/etcher/
Lightweight Directory Access Protocol, or LDAP



```bash
sudo useradd -d /home/mehrdad -m mehrdad  # -d option, I’m clarifying that I would like a home directory created for this user, and following that, I called out /home/jdoe as the user’s home directory. The -m flag tells the system that I would like the home directory to be created during the process
ls -l /home 
adduser --->immediately
sudo userdel dscully
```

##like to use the following command to show more easily when the password was last
changed:
```bash

sudo passwd -S <username> 
ls -la /etc/skel #you can include default configuration files for any application your company uses
sudo gpasswd -d <username> <grouptoremove>
sudo gpasswd -a <username> <group> #append
To lock an account, use the -l option:
sudo passwd -l <username>
And to unlock it, use the -u option:
sudo passwd -u <username>
sudo chage -l <username>

```
## Setting a password policy-->Pluggable Authentication Module (PAM)
```bash
sudo apt install libpam-cracklib
sudo nano /etc/pam.d/common-password
Another field worth mentioning within the /etc/pam.d/common-password file is the section that reads
difok=3. This configuration mandates that at least three characters have to be different before the
password is considered acceptable
sudo usermod -aG sudo <username>
charlie
 ALL=(ALL:ALL) /sbin/reboot,/sbin/shutdown
 charlie
 ubuntu=(ALL:ALL) /usr/bin/apt
 charlie
 ubuntu=(dscully:admins) ALL
 chmod o-r budget.txt
chmod 770 -R mydir
```
770: Both User and Group have full access (read, write, and execute). Other has nothing.
-----------------
# Managing Software Packages
##
```bash
snap find <keyword>
which nmap
sudo snap refresh <package> #package will be updated to the newest version available
apt search <search term>
apt-cache show libapache2-mod-php
```
## Adding additional repositories
```bash
 an extension of .list
are read from the /etc/apt/sources.list.d/ directory
sudo apt-add-repository ppa:username/myawesomesoftware-1.0
dpkg --get-selections > packages.list
sudo dpkg --set-selections < packages.list
cat /etc/os-release
```
##
```bash
grep Port /etc/ssh/sshd_config

```
##
```bash
grep Network /var/log/syslog
```
------------
One trick that I love (which also works well with vim) is pressing t and then z while holding Ctrl when
you have nano open
You can bring the nano window back by executing fg

## vim
```bash
:! ls -l /var/log
:sp /path/to/file
```
##
```bash

```
##
```bash

```
##
```bash

```
##
```bash

```
##
```bash

```
##
```bash

```
##
```bash

```
##
```bash

```
##
```bash

```
##
```bash

```
##
```bash

```
