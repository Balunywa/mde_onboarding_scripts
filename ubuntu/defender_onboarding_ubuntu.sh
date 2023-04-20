#!/bin/bash

# Install curl if it isn't installed yet
sudo apt-get install -y curl

# Install python3 if not  installed yet
sudo apt-get install python3

# Install libplist-utils if it isn't installed yet
sudo apt-get install -y libplist-utils

# Identify distribution and version
distro=$(grep -Eo '^ID=\w+' /etc/os-release | cut -d= -f2)
version=$(grep -Eo '^VERSION_ID="\S+"' /etc/os-release | cut -d= -f2 | tr -d '"')

# In the following command, replace [distro] and [version] with the information you've identified
channel="prod"
curl -o microsoft.list "https://packages.microsoft.com/config/${distro}/${version}/${channel}.list"

# Install the repository configuration
sudo mv ./microsoft.list "/etc/apt/sources.list.d/microsoft-${channel}.list"

# Install the gpg package if not already installed
sudo apt-get install -y gpg || sudo apt-get install -y gnupg

# Install the Microsoft GPG public key
curl -sSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null

# Install the HTTPS driver if not already installed
sudo apt-get install -y apt-transport-https

# Update the repository metadata
sudo apt-get update

# Install mdatp
sudo apt-get install -y mdatp

# Extract the onboarding package
sudo WindowsDefenderATPOnboardingPackage.zip

# Run the onboarding script
if command -v python3 &> /dev/null; then
    sudo python3 MicrosoftDefenderATPOnboardingLinuxServer.py
else
    sudo python MicrosoftDefenderATPOnboardingLinuxServer.py
fi

# Verify that the device is now associated with your organization and reports a valid organization identifier
mdatp health --field org_id

# Check the health status of the product
mdatp health --field healthy

# Update the antimalware definitions (if needed)
mdatp health --field definitions_status

# Ensure that real-time protection is enabled
real_time_protection=$(mdatp health --field real_time_protection_enabled)
if [ "$real_time_protection" != "1" ]; then
    mdatp config real-time-protection --value enabled
fi

# Download EICAR test file
sudo curl -o /tmp/eicar.com.txt https://www.eicar.org/download/eicar.com.txt

# List all detected threats
sudo mdatp threat list
