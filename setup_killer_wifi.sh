##
## file     :    setup_killer_wifi.sh
## author   :    Chakshu Gupta
## date     :    29/12/2019
## version  :    1.0
##

#Update the system
sudo apt update
# Check if git is installed
git --version 2>&1 >/dev/null
GIT_IS_INSTALLED=$?
PATH="./"

if [ $GIT_IS_AVAILABLE==0 ]
then
	echo "installed"
else
	sudo apt install git
fi

echo "This setup requires cloning git repositories"

# Download lwlwifi-firmware.git repository
git clone "git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git"
#b=$!
#wait $b && echo "Cloned lwlwifi-firmware.git repository" || echo "Unable to clone the repository!"
cd linux-firmware
sudo cp iwlwifi-* /lib/firmware/
cd ..

# Create the backported lwlwifi Driver for current setup
git clone "https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/backport-iwlwifi.git"
cd backport-iwlwifi
sudo make defconfig-iwlwifi-public
sudo make -j4
sudo make install


# Command to force the machine to use the Driver from boot
update-initramfs -u

echo "Rebooting the system now......"
sleep 0.05m

#Reboot the system
sudo reboot
