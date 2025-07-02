#!/bin/bash

# -------------------------------
# 아두이노 IDE 1.8.19 설치 + 한글 깨짐 방지 통합 스크립트
# -------------------------------

echo "🛠️ [1/6] 시스템 및 폰트 업데이트 중..."
sudo apt update
sudo apt install -y fonts-noto-cjk fonts-nanum fonts-d2coding language-pack-ko

echo "🌐 [2/6] 아두이노 IDE 다운로드 중..."
wget https://downloads.arduino.cc/arduino-1.8.19-linux64.tar.xz

echo "📦 [3/6] 압축 해제 및 이동 중..."
tar -xf arduino-1.8.19-linux64.tar.xz
sudo mv arduino-1.8.19 /opt/
cd /opt/arduino-1.8.19

echo "⚙️ [4/6] 아두이노 설치 실행 중..."
sudo ./install.sh

echo "📁 [5/6] 기본 설정 폴더 생성 및 한글 폰트 적용..."
mkdir -p ~/.arduino15
touch ~/.arduino15/preferences.txt

# 기존에 editor.font 설정이 없을 경우만 추가
if ! grep -q "editor.font" ~/.arduino15/preferences.txt; then
    echo "editor.font=D2Coding,plain,14" >> ~/.arduino15/preferences.txt
    echo ">> 폰트 설정 추가됨: D2Coding, 14pt"
else
    echo ">> 기존에 폰트 설정이 존재함, 변경하지 않음"
fi

echo "🌍 [6/6] 한글 로케일 설정 중..."
sudo update-locale LANG=ko_KR.UTF-8
export LANG=ko_KR.UTF-8
export LC_ALL=ko_KR.UTF-8

echo "✅ 아두이노 설치 완료!"
echo "📝 한글 주석이 깨지지 않도록 폰트 및 로케일 설정을 완료했습니다."
echo "💡 메뉴에서 'Arduino IDE'를 찾아 실행해보세요!"
