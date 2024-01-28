#!/bin/zsh

# Constants
TEMP_THRESHOLD=60  # Temperature threshold in degrees Celsius
SLEEP_DURATION=60  # Sleep duration in seconds

# Function to increase fan speed
increase_fan_speed() {
    # Example: ipmitool raw command to increase fan speed
    # Replace with your actual ipmitool command to increase the fan speed
    ipmitool raw 0x30 0x30 0x02 0xff 0x32
}

# Function to decrease fan speed
decrease_fan_speed() {
    # Example: ipmitool raw command to decrease fan speed
    # Replace with your actual ipmitool command to decrease the fan speed
    ipmitool raw 0x30 0x30 0x02 0xff 0x1A
}

# Main loop
while true; do
    # Get CPU temperature (replace with your method of getting CPU temp)
    # Adjust the parsing commands as needed for your specific output format
    CPU_TEMP=$(sensors | grep 'Core 0' | awk '{print $3}' | sed 's/+//' | sed 's/°C//' | sort -nr | head -1)

    # Check if temperature exceeds threshold
    if (( CPU_TEMP > TEMP_THRESHOLD )); then
        increase_fan_speed
    else
        decrease_fan_speed
    fi

    sleep $SLEEP_DURATION
done
