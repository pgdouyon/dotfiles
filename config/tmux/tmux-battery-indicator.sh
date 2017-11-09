#!/usr/bin/env bash

if [[ $(uname) == 'Linux' ]]; then
  current_charge=$(grep 'remaining capacity' /proc/acpi/battery/BAT1/state | awk '{print $3}')
  total_charge=$(grep 'last full capacity' /proc/acpi/battery/BAT1/info | awk '{print $4}')
else
  battery_info=$(ioreg -rc AppleSmartBattery)
  current_charge=$(echo "$battery_info" | grep -o '"CurrentCapacity" = [0-9]\+' | awk '{print $3}')
  total_charge=$(echo "$battery_info" | grep -o '"MaxCapacity" = [0-9]\+' | awk '{print $3}')
fi

charged_slots=$(( ((current_charge * 100) + (total_charge * 5))/(total_charge * 10) ))
if (( charged_slots > 10 )); then
  charged_slots=10
fi

if (( charged_slots <= 2 )); then
    echo -n '#[fg=colour52]'
elif (( charged_slots <= 5 )); then
    echo -n '#[fg=colour142]'
else
    echo -n '#[fg=colour35]'
fi

echo -n 'Battery: ['

case $charged_slots in
    0) echo -n "            ";;
    1) echo -n "=>          ";;
    2) echo -n "==>         ";;
    3) echo -n "===        ";;
    4) echo -n "===>>=     ";;
    5) echo -n "===>=>     ";;
    6) echo -n "======    ";;
    7) echo -n "======>>= ";;
    8) echo -n "======>=> ";;
    9) echo -n "=========";;
    *) echo -n "=========";;
esac

echo -n ']'
echo -n '#[default]'
