#!/bin/bash
source <(grep = config.ini)
export SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

r710(){
  case $1 in
    start-server)
      echo "Starting Server..."
      ipmitool -I lanplus -H $IPMI_IP -U $IPMI_USER -P $IPMI_PASSWORD power on
      sleep 5s
      dell-r710-fanSpeed $2
      ;;
    stop-server)
      ipmitool -I lanplus -H $IPMI_IP -U $IPMI_USER -P $IPMI_PASSWORD power off
      ;;
    set-fans)
      dell-r710-fanSpeed $2
      ;;
    reset-fans)
      ipmitool -I lanplus -H $IPMI_IP -U $IPMI_USER -P $IPMI_PASSWORD raw 0x30 0x30 0x01 0x01
      ;;
    get-temp)
      ipmitool -I lanplus -H $IPMI_IP -U $IPMI_USER -P $IPMI_PASSWORD sensor reading 'Ambient Temp'
      ;;
    get-fans)
      ipmitool -I lanplus -H $IPMI_IP -U $IPMI_USER -P $IPMI_PASSWORD sensor reading 'FAN 1 RPM' 'FAN 2 RPM' 'FAN 3 RPM' 'FAN 4 RPM' 'FAN 5 RPM'
      ;;
  esac
}

dell-r710-fanSpeed() {
    echo "Enabling manual fan speed..."
    ipmitool -I lanplus -H $IPMI_IP -U $IPMI_USER -P $IPMI_PASSWORD raw 0x30 0x30 0x01 0x00
    echo "Setting to $1 %"
    ipmitool -I lanplus -H $IPMI_IP -U $IPMI_USER -P $IPMI_PASSWORD raw 0x30 0x30 0x02 0xff $1
}

source r710-autocomplete.sh