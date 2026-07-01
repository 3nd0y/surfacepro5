#!/bin/bash

# Script untuk mencari error saat boot Linux
# Gunakan hak akses root atau sudo saat menjalankan script ini

echo "Mencari log error pada proses boot..."
echo "======================================="

# Mencari error dari log systemd (journalctl)
echo "--- Error Booting dari systemd ---"
journalctl -b -p err..emerg

echo "======================================="

# Mencari error pada kernel (dmesg)
echo "--- Error Booting dari Kernel (dmesg) ---"
dmesg -l err,warn,crit,alert,emerg
