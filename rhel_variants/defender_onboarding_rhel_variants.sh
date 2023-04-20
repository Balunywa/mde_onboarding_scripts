#!/bin/bash

# Install yum-utils if it isn't installed yet
sudo yum install -y yum-utils

# Identify distribution and version
distro=$(grep -Eo '^ID=\w+' /etc/os-release | cut -d= -f2)
version=$(grep -Eo '^VERSION_ID="\S+"' /etc/os-release | cut -d= -f2 | tr -d '"')

# Identify the appropriate package
case "$distro" in
    rhel|centos|oracle)
        if [[ "${version%.*}" -eq 8 ]]; then
            repo_url="https://packages.microsoft.com/config/rhel/8/prod.repo"
        else
            repo_url="https://packages.microsoft.com/config/rhel/7.2/prod.repo"
        fi
        ;;
    amazon)
        repo_url="https://packages.microsoft.com/config/rhel/7.2/prod.repo"
        ;;
    fedora)
        if [[ "${version%.*}" -eq 33 ]]; then
            repo_url="https://packages.microsoft.com/config/fedora/33/prod.repo"
        else
            repo_url="https://packages.microsoft.com/config/fedora/34/prod.repo"
        fi
        ;;
    *)
        echo "Unsupported distribution"
        exit 1
        ;;
esac

# Add the repository
sudo yum-config-manager --add-repo="${repo_url}"

# Install the Microsoft GPG public key
sudo rpm --import http://packages.microsoft.com/keys/microsoft.asc

# Install curl if it isn't installed yet
sudo yum install -y curl

# Install the mdatp package
sudo yum install -y mdatp

# Extract the onboarding package
unzip -o WindowsDefenderATPOnboardingPackage.zip

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
curl -o /tmp/eicar.com.txt https://www.eicar.org/download/eicar.com.txt

# List all detected threats
mdatp threat list