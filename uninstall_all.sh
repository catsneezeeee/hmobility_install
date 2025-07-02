#!/bin/bash

echo "=========================================="
echo "🧹 H-Mobility 개발환경 전체 삭제 시작"
echo "    (ROS 2 + Terminator + Arduino + VS Code)"
echo "=========================================="

##########################################
# 1. ROS 2 Humble 제거
##########################################
echo "❌ [1/4] ROS 2 Humble 제거 중..."

sudo apt remove -y ~nros-humble-*
sudo apt autoremove -y
sudo rm -f /etc/apt/sources.list.d/ros2.list
sudo rm -f /usr/share/keyrings/ros-archive-keyring.gpg

# .bashrc 설정 제거
sed -i '/source \/opt\/ros\/humble\/setup.bash/d' ~/.bashrc
sed -i '/source \/usr\/share\/colcon_argcomplete\/hook\/colcon-argcomplete.bash/d' ~/.bashrc

echo "✅ ROS 2 삭제 완료"

##########################################
# 2. Terminator 제거
##########################################
echo "❌ [2/4] Terminator 제거 중..."
sudo apt remove -y terminator
sudo apt autoremove -y
echo "✅ Terminator 삭제 완료"

##########################################
# 3. Arduino IDE 제거
##########################################
echo "❌ [3/4] Arduino IDE 제거 중..."

sudo rm -rf /opt/arduino-1.8.19
rm -rf ~/.arduino15
rm -f ~/Downloads/arduino-1.8.19-linux64.tar.xz

echo "✅ Arduino 삭제 완료"

##########################################
# 4. Visual Studio Code 제거
##########################################
echo "❌ [4/4] VS Code 제거 중..."

sudo apt remove -y code
sudo apt autoremove -y
sudo rm -f /etc/apt/sources.list.d/vscode.list
sudo rm -f /etc/apt/trusted.gpg.d/microsoft.gpg
sudo rm -f /usr/share/keyrings/packages.microsoft.gpg

echo "✅ VS Code 삭제 완료"

##########################################
# 마무리
##########################################
echo ""
echo "🎯 모든 항목이 삭제되었습니다."
echo "📦 필요 시 언제든지 설치 스크립트로 다시 설치할 수 있습니다."
