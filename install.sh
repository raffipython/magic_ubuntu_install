#!/bin/bash -x

#################
# in root shell #
#################

## apt install vim # if you want to

#################
# PYTHON 3.6    #
#################
add-apt-repository ppa:jonathonf/python-3.6
apt-get update
apt-get install python3.6

# check
python3 -V # should be >= 3.6


#################
# ANDROID SDK   #
#################
apt install android-sdk


#################
# GIT           #
#################
apt install git


#################
# MAGISK        #
#################
mkdir ~/magisk
cd ~/magisk
git clone --recurse-submodules https://github.com/topjohnwu/Magisk.git
cd ~/magisk/Magisk/

export ANDROID_HOME="/usr/lib/android-sdk"
cp config.prop.sample config.prop
sed -i 's/version=/&1/g' config.prop
sed -i 's/versionCode=/&1/g' config.prop
sed -i 's/appVersion=/&1/g' config.prop
sed -i 's/appVersionCode=/&1/g' config.prop
apt install google-android-platform-24-installer
apt install android-sdk-helper
apt install default-jdk
cd ~/magisk
wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
unzip sdk-tools-linux-4333796.zip 
export PATH=$PATH:/root/magisk/tools/bin
# REPLACE LINE 31 DEFAULT_JVM with this, basically appending -XX stuff 
## DEFAULT_JVM_OPTS='"-Dcom.android.sdklib.toolsdir=$APP_HOME" -XX:+IgnoreUnrecognizedVMOptions --add-modules java.se.ee'

sdkmanager --licenses
# press y for all licenses

cp /root/magisk/tools/bin/* /usr/lib/android-sdk/tools/bin/
apt remove android-sdk
touch /root/.android/repositories.cfg
sdkmanager --no_https --update


#     build-tools;28.0.3 Android SDK Build-Tools 28.0.3
#     platforms;android-28 Android SDK Platform 28
sdkmanager --no_https "build-tools;28.0.3"
sdkmanager --no_https "platforms;android-28"


export JVM_OPTS='-XX:+IgnoreUnrecognizedVMOptions --add-modules java.se.ee'


~/magisk/tools/android update sdk --no-ui --all --filter "android-28"
~/magisk/tools/android update sdk --no-ui --all --filter "build-tools;28.0.3"

mv /usr/lib/android-sdk/tools/bin/sdkmanager /usr/lib/android-sdk/tools/bin/sdkmanager-old
ln -s /root/magisk/tools/bin/sdkmanager /usr/lib/android-sdk/tools/bin/sdkmanager
apt autoremove android-sdk
apt install android-sdk
cp /root/magisk/licenses/* /usr/lib/android-sdk/licenses/

cd /magisk/Magisk
./build.py -v all
