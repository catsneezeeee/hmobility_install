#!/usr/bin/env bash
set -e

echo "=========================================="
echo "🚀 H-Mobility 전체 개발환경 설치 시작"
echo "    (ROS 2 → Terminator → Arduino → VS Code)"
echo "=========================================="

##########################################
# 1. ROS 2 Humble 설치
##########################################
CHOOSE_ROS_DISTRO=humble
INSTALL_PACKAGE=desktop

echo "🛠️ [1/4] ROS 2 $CHOOSE_ROS_DISTRO 설치 중..."
sudo apt update
sudo apt install -y expect curl gnupg2 lsb-release

sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" | \
  sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

sudo apt update
sudo apt install -y ros-$CHOOSE_ROS_DISTRO-$INSTALL_PACKAGE
sudo apt install -y python3-argcomplete python3-colcon-common-extensions

if [ "$(lsb_release -cs)" = "bionic" ]; then
    sudo apt install -y python-rosdep python3-vcstool
else
    sudo apt install -y python3-rosdep python3-vcstool
fi

[ -e /etc/ros/rosdep/sources.list.d/20-default.list ] || sudo rosdep init
rosdep update || echo "⚠️ rosdep update 실패: 무시하고 설치 계속 진행"

# 환경변수 적용
if [ -f "/opt/ros/$CHOOSE_ROS_DISTRO/setup.bash" ]; then
    source /opt/ros/$CHOOSE_ROS_DISTRO/setup.bash
else
    echo "⚠️ setup.bash 없음: 환경변수 설정 생략"
fi

grep -F "source /opt/ros/$CHOOSE_ROS_DISTRO/setup.bash" ~/.bashrc || \
  echo "source /opt/ros/$CHOOSE_ROS_DISTRO/setup.bash" >> ~/.bashrc
grep -F "source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash" ~/.bashrc || \
  echo "source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash" >> ~/.bashrc

source /opt/ros/$CHOOSE_ROS_DISTRO/setup.bash

# 설치 확인용 talker 노드 자동 테스트
# expect << EOF
# set timeout -1
# set line_count 0
# spawn ros2 run demo_nodes_cpp talker
# expect {
#     -re "Publishing:.*" {
#         incr line_count
#         if { \$line_count == 3 } {
#             send -- "\003"
#             expect eof
#             exit
#         }
#         exp_continue
#     }
# }
# EOF

##########################################
# 2. Terminator 설치
##########################################
echo "🧱 [2/4] Terminator 설치 중..."
sudo apt install -y terminator
echo "✅ Terminator 설치 완료 (명령어: terminator)"

##########################################
# 3. Arduino IDE 설치
##########################################
echo "🔌 [3/4] Arduino IDE 설치 중..."
sudo apt install -y fonts-nanum fonts-nanum-coding fonts-noto-cjk language-pack-ko
wget https://downloads.arduino.cc/arduino-1.8.19-linux64.tar.xz
tar -xf arduino-1.8.19-linux64.tar.xz
sudo mv arduino-1.8.19 /opt/
cd /opt/arduino-1.8.19
sudo ./install.sh
mkdir -p ~/.arduino15
touch ~/.arduino15/preferences.txt
if ! grep -q "editor.font" ~/.arduino15/preferences.txt; then
  echo "editor.font=D2Coding,plain,14" >> ~/.arduino15/preferences.txt
fi
sudo update-locale LANG=ko_KR.UTF-8
export LANG=ko_KR.UTF-8
export LC_ALL=ko_KR.UTF-8
echo "✅ Arduino 설치 완료 (메뉴에서 'Arduino IDE' 검색)"

##########################################
# 4. Visual Studio Code 설치
##########################################
echo "💻 [4/4] VS Code 설치 중..."
sudo apt install -y wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
rm microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install -y code
echo "✅ VS Code 설치 완료 (명령어: code)"

##########################################
# 마무리
##########################################
echo ""
echo "🎉 전체 설치 완료!"
echo "🚀 설치된 항목:"
echo "  - ROS 2 $CHOOSE_ROS_DISTRO"
echo "  - Terminator"
echo "  - Arduino IDE"
echo "  - Visual Studio Code"
echo ""
echo "📝 터미널 재시작 후 'ros2', 'code', 'arduino', 'terminator' 등 실행 가능"
