#!/bin/bash

# Pastikan dijalankan sebagai root/sudo
if [ "$EUID" -ne 0 ]; then 
  echo "Harap jalankan script ini dengan sudo"
  exit
fi

echo "Memulai setup reload IPTS..."

# 1. Membuat script eksekusi
cat << 'EOF' > /usr/local/bin/ipts-sleep
#!/bin/sh
case $1 in
  pre)
    systemctl stop iptsd
    modprobe -r ipts
    ;;
  post)
    modprobe ipts
    systemctl start iptsd
    ;;
esac
EOF

# 2. Memberikan izin eksekusi pada script
chmod +x /usr/local/bin/ipts-sleep

# 3. Membuat file unit systemd
cat << 'EOF' > /etc/systemd/system/ipts-resume.service
[Unit]
Description=Reload IPTS on sleep/resume
Before=sleep.target
StopWhenUnneeded=yes

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/usr/local/bin/ipts-sleep pre
ExecStop=/usr/local/bin/ipts-sleep post

[Install]
WantedBy=sleep.target
EOF

# 4. Reload daemon dan aktifkan service
systemctl daemon-reload
systemctl enable ipts-resume.service

echo "Selesai! Modul IPTS sekarang akan otomatis di-reload setiap Surface bangun dari tidur."
