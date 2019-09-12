#!/bin/bash
   
#Release Date: June 6, 2019

#0- Setup .bashrc and copy rosbuild_ws and catkin_ws into home folder
cd ~/

#1- Setup your sources.list : Setup your computer to accept software from packages.ros.org.
echo "-------- [Step-1] Setup your sources.list --------"
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
echo Done
sleep 2


#2- Set up your keys:
echo "-------- [Step-2] Set up your keys --------"
sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
sleep 2
echo Done
#Make sure your Debian package index is up-to-date:
sudo apt update
sleep 2
 
#3- Install required packages:
echo "-------- [Step-3] Install required packages --------"

echo "-------- Waiting for dpkg to be free --------"
c=$(ps aux | grep -i apt | wc -l)

spin[0]="-"
spin[1]="\\"
spin[2]="|"
spin[3]="/"

while [[ $c -gt 1 ]]; do
  for i in "${spin[@]}"; do
        echo -ne "\b$i"
        sleep 0.1
  done	
  c=$(ps aux | grep -i apt | wc -l)
done


echo "-------- Ready to install required packages --------"

yes Y | sudo apt-get install ros-melodic-desktop-full ros-melodic-hector-gazebo ros-melodic-openni-camera ros-melodic-roslisp python-rosinstall python-rdflib mercurial git openjdk-11-jdk libcgal-dev libpcl-dev libpstreams-dev libgraphviz-dev python-shapely python-networkx python-nltk python-pip libsnappy-dev ros-melodic-catkin python-catkin-tools libusb-dev libspnav-dev libbluetooth-dev libcwiid-dev ros-melodic-rviz-visual-tools build-essential cmake doxygen libqt4-dev libqt4-opengl-dev libqglviewer-dev-qt4 ros-melodic-moveit 

sudo rosdep init
rosdep update

chmod a+x ~/.bashrc
PS1='$ '
source ~/.bashrc

#4- Install LEVElDB
echo "-------- [Step-4] Install LEVElDB --------"
mkdir -p /tmp/leveldb && cd /tmp/leveldb
wget https://github.com/google/leveldb/archive/v1.14.tar.gz
tar -xzf v1.14.tar.gz
cd leveldb-1.14/
make -j4
sudo cp -R include/leveldb /usr/local/include  
sudo mv libleveldb.* /usr/local/lib
sudo ldconfig


#5- Building libfranka
echo "-------- [Step-5] Building libfranka for Panda robot --------"
cd ~/
sudo apt install build-essential cmake libpoco-dev libeigen3-dev
git clone --recursive https://github.com/frankaemika/libfranka
cd libfranka && mkdir build && cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
cmake --build .
#sleep 2

#6- Make all catkin_ws packages
echo "-------- [Step-6] Make all catkin_ws packages --------"

cd ~/catkin_ws 
source /opt/ros/melodic/setup.bash
export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:`pwd`
echo $ROS_PACKAGE_PATH
rosdep install --from-paths src --ignore-src --rosdistro melodic -y --skip-keys libfranka
catkin_make -DCMAKE_BUILD_TYPE=Release -DFranka_DIR:PATH=/home/cognitiverobotics/libfranka/build

#sleep 2

#7- Make all rosbuild_ws packages
echo "-------- [Step-7] Make all rosbuild_ws packages --------"
cd ~/rosbuild_ws
export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:`pwd`
echo $ROS_PACKAGE_PATH

rosmake * --threads=1

sleep 2
cd imperial_3d_object_tracking
make clean && rm -r build && rm -r bin && rm -r lib
make -j4
sleep 2
cd ~/


#!/bin/bash
   
#Release Date: June 6, 2019

#0- Setup .bashrc and copy rosbuild_ws and catkin_ws into home folder
cd ~/

#1- Setup your sources.list : Setup your computer to accept software from packages.ros.org.
echo "-------- [Step-1] Setup your sources.list --------"
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
echo Done
sleep 2


#2- Set up your keys:
echo "-------- [Step-2] Set up your keys --------"
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
sleep 2
echo Done
#Make sure your Debian package index is up-to-date:
sudo apt update
sleep 2
 
#3- Install required packages:
echo "-------- [Step-3] Install required packages --------"

echo "-------- Waiting for dpkg to be free --------"
c=$(ps aux | grep -i apt | wc -l)

spin[0]="-"
spin[1]="\\"
spin[2]="|"
spin[3]="/"

while [[ $c -gt 1 ]]; do
  for i in "${spin[@]}"; do
        echo -ne "\b$i"
        sleep 0.1
  done	
  c=$(ps aux | grep -i apt | wc -l)
done


echo "-------- Ready to install required packages --------"

yes Y | sudo apt-get install ros-melodic-desktop-full ros-melodic-hector-gazebo ros-melodic-openni-camera ros-melodic-roslisp python-rosinstall python-rdflib mercurial git openjdk-11-jdk libcgal-dev libpcl-dev libpstreams-dev libgraphviz-dev python-shapely python-networkx python-nltk python-pip libsnappy-dev ros-melodic-catkin python-catkin-tools libusb-dev libspnav-dev libbluetooth-dev libcwiid-dev ros-melodic-rviz-visual-tools build-essential cmake doxygen libqt4-dev libqt4-opengl-dev libqglviewer-dev-qt4 ros-melodic-moveit 

sudo rosdep init
rosdep update

chmod a+x ~/.bashrc
PS1='$ '
source ~/.bashrc

#4- Install LEVElDB
echo "-------- [Step-4] Install LEVElDB --------"
mkdir -p /tmp/leveldb && cd /tmp/leveldb
wget https://github.com/google/leveldb/archive/v1.14.tar.gz
tar -xzf v1.14.tar.gz
cd leveldb-1.14/
make -j4
sudo cp -R include/leveldb /usr/local/include  
sudo mv libleveldb.* /usr/local/lib
sudo ldconfig


#5- Building libfranka
echo "-------- [Step-5] Building libfranka for Panda robot --------"
cd ~/
sudo apt install build-essential cmake libpoco-dev libeigen3-dev
git clone --recursive https://github.com/frankaemika/libfranka
cd libfranka && mkdir build && cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
cmake --build .
#sleep 2

#6- Make all catkin_ws packages
echo "-------- [Step-6] Make all catkin_ws packages --------"

cd ~/catkin_ws 
source /opt/ros/melodic/setup.bash
export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:`pwd`
echo $ROS_PACKAGE_PATH
rosdep install --from-paths src --ignore-src --rosdistro melodic -y --skip-keys libfranka
catkin_make -DCMAKE_BUILD_TYPE=Release -DFranka_DIR:PATH=/home/cognitiverobotics/libfranka/build

#sleep 2

#7- Make all rosbuild_ws packages
echo "-------- [Step-7] Make all rosbuild_ws packages --------"
cd ~/rosbuild_ws
export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:`pwd`
echo $ROS_PACKAGE_PATH

rosmake * 

#8- Make all student_ws packages
echo "-------- [Step-7] Make all student_ws packages --------"

cd ~/student_ws
export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:`pwd`
echo $ROS_PACKAGE_PATH

rosmake * 

cd ~/rosbuild_ws

sleep 2
cd imperial_3d_object_tracking
make clean && rm -r build && rm -r bin && rm -r lib
make -j4
sleep 2


cd ~/

