# Microsoft Defender for Endpoint Onboarding Scripts

This repository contains onboarding scripts for Microsoft Defender for Endpoint (MDE) on Linux systems, specifically for Ubuntu-based and RHEL-based distributions. These scripts simplify the process of setting up a proof of concept (POC) on 5 to 10 VMs.

## Download the Onboarding Package

To get started with the onboarding scripts, you'll first need to download the onboarding package from the Microsoft 365 Defender portal. Here's how:

1. Visit the Microsoft 365 Defender portal and sign in with your credentials.
2. Go to Settings > Endpoints > Device management > Onboarding.
3. In the first drop-down menu, select **Linux Server** as the operating system.
4. In the second drop-down menu, select **Local Script** as the deployment method.
5. Click **Download onboarding package** and save the file as `WindowsDefenderATPOnboardingPackage.zip`.

Once you have downloaded the onboarding package, follow the instructions provided in this repository to complete the onboarding process for your specific Linux distribution.

## Running the Onboarding Scripts

To run the onboarding scripts for your specific Linux distribution, follow the steps below:

1. Download the onboarding package as described in the previous section, and make sure you have the `WindowsDefenderATPOnboardingPackage.zip` file.

2. Clone this repository or download the scripts directly from the repo:

   ```bash
   git clone https://github.com/your-repo-link/mde-onboarding-scripts.git

Navigate to the cloned repository or the folder where you downloaded the scripts:

cd mde-onboarding-scripts

Choose the appropriate script for your Linux distribution. There are separate scripts for Ubuntu-based systems and RHEL-based systems.

Make the script executable

chmod +x script_name.sh

Replace script_name.sh with the name of the script you want to run, for example, mde_onboarding_ubuntu.sh or mde_onboarding_rhel.sh.

Run the script as root or with sudo privileges:

Replace script_name.sh with the name of the script you want to run, for example, mde_onboarding_ubuntu.sh or mde_onboarding_rhel.sh.

Follow the instructions provided by the script. It will guide you through the onboarding process and configure Microsoft Defender for Endpoint on your Linux system.

For more detailed information and guidance, visit this repository and refer to the instructions provided for your specific Linux distribution.