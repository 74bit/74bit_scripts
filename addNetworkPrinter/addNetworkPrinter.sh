#!/bin/bash

# Printer Display Name
printerName="Canon_C5235"

# Path to Printer Driver
# Example
# printerDriver="/Library/Printers/PPDs/Contents/Resources/CNMCIRAC5235S2.ppd.gz"
printerDriver="/Library/Printers/PPDs/your-driver-here"

# Contains protocol and IP/hostname
# Example
# printerAddress="lpd://192.168.1.2"
printerAddress="lpd://0.0.0.0"

if [ ! -f "$printerDriver" ]; then
  printf "Driver not found!"
else 
  lpadmin -p $printerName -E -v $printerAddress -P "$printerDriver"
fi
exit 0
