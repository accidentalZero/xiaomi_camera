#!/usr/bin/bash

sudo_username="$(who am i | awk '{print $1}')"




sudo dnf install samba
sudo systemctl enable smb --now




# Создаем пользователя samba
username="xiaomi"
pass="xiaomi"

sudo useradd $username
echo "+ Пользователь $username успешно добавлен в систему!"
echo $username:$pass | sudo chpasswd
echo "+ Пользователю $username задан пароль!"
echo -e "$pass\n$pass" | smbpasswd -a -s $username

share_path="/home/$sudo_username/xiaomi"
mkdir $share_path
sudo chown -R $username:$username $share_path
sudo chmod -R 777 $share_path

echo "
[global]
	workgroup = WORKGROUP
	netbios name = $(hostname)
	client max protocol = NT1
	client min protocol = NT1
	server min protocol = NT1
	#ntlm auth = ntlmv1-permitted


[xiaomi]
	comment = Samba Camera Recorder
	path = $share_path
	public = no
	writable = yes
	guest ok = no
	valid users = admin, $username
	create mask = 0777
	directory mask = 0777
	force create mode = 0777
	force directory mode = 0777
	inherit owner = yes"| sudo tee /etc/samba/smb.conf >/dev/null

# Замена в write list user на xiaomi помогла...

sudo systemctl restart smb
