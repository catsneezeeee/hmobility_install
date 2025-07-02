#!/bin/bash
 
# VS Code 설치 스크립트
 
echo "✅ 패키지 목록을 업데이트합니다..."

sudo apt update
 
echo "✅ 필요한 패키지를 설치합니다..."

sudo apt install -y wget gpg
 
echo "✅ Microsoft GPG 키를 등록합니다..."

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg

sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/

rm microsoft.gpg
 
echo "✅ VS Code 저장소를 추가합니다..."

sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
 
echo "✅ 패키지 목록을 다시 업데이트합니다..."

sudo apt update
 
echo "✅ VS Code를 설치합니다..."

sudo apt install -y code
 
echo ""

echo "🎉 설치 완료! 다음 명령어로 VS Code를 실행할 수 있습니다:"

echo "code"

echo "또는 애플리케이션 메뉴에서 'Visual Studio Code' 검색"
