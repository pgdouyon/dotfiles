#!/usr/bin/env bash

if [[ $(uname) == 'Linux' ]]; then
  current_charge=$(grep 'remaining capacity' /proc/acpi/battery/BAT1/state | awk '{print $3}')
  total_charge=$(grep 'last full capacity' /proc/acpi/battery/BAT1/info | awk '{print $4}')
else
  battery_info=$(ioreg -rc AppleSmartBattery)
  current_charge=$(echo "$battery_info" | grep -o '"CurrentCapacity" = [0-9]\+' | awk '{print $3}')
  total_charge=$(echo "$battery_info" | grep -o '"MaxCapacity" = [0-9]\+' | awk '{print $3}')
fi

charged_slots=$(( (current_charge * 10)/total_charge + 1 ))
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

empty_slots=$(( 10 - charged_slots ))
for (( i=0; i < charged_slots; i++ )); do echo -n "="; done
for (( i=0; i < empty_slots; i++ )); do echo -n " "; done

echo -n ']'
echo -n '#[default]'
