#!/usr/bin/env bash

if [[ `uname` == 'Linux' ]]; then
  current_charge=$(cat /proc/acpi/battery/BAT1/state | grep 'remaining capacity' | awk '{print $3}')
  total_charge=$(cat /proc/acpi/battery/BAT1/info | grep 'last full capacity' | awk '{print $4}')
else
  battery_info=`ioreg -rc AppleSmartBattery`
  current_charge=$(echo $battery_info | grep -o '"CurrentCapacity" = [0-9]\+' | awk '{print $3}')
  total_charge=$(echo $battery_info | grep -o '"MaxCapacity" = [0-9]\+' | awk '{print $3}')
fi

charged_slots=$(echo "(($current_charge/$total_charge)*10)+1" | bc -l | cut -d '.' -f 1)
if [[ $charged_slots -gt 10 ]]; then
  charged_slots=10
fi

if [[ $charged_slots -le 2 ]]; then
    echo -n '#[fg=#811205,bold]'
elif [[ $charged_slots -le 5 ]]; then
    echo -n '#[fg=#cbe309,bold]'
else
    echo -n '#[fg=#044712,bold]'
fi

echo -n 'Battery: ['
for i in `seq 1 $charged_slots`; do echo -n "="; done

if [[ $charged_slots -lt 10 ]]; then
  for i in `seq 1 $(echo "10-$charged_slots" | bc)`; do echo -n " "; done
fi
echo -n ']'
echo -n '#[default]'
