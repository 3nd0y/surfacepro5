#!/bin/bash

# Pastikan dijalankan sebagai root/sudo
if [ "$EUID" -ne 0 ]; then 
  echo "Harap jalankan script ini dengan sudo"
  exit
fi

echo "Install IPTS recover to accomodate bugs Surface Pro malfunction touch after wake up"
./scripts/ipts-recover.sh
echo "Install IPTS recover done"
