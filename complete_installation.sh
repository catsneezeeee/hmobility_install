#!/bin/bash

echo "==========================="
echo "🚀 H-Mobility 개발환경 설치 시작"
echo "==========================="

echo ""
echo "🔧 1. Terminator 설치 중..."
bash terminator.sh

echo ""
echo "🛠️ 2. Arduino IDE 설치 중..."
bash arduino.sh

echo ""
echo "💻 3. Visual Studio Code 설치 중..."
bash code.sh

echo ""
echo "🎉 전체 설치 완료!"
echo "✅ Terminator, Arduino IDE, VS Code가 모두 설치되었습니다."
echo "📌 각 프로그램을 메뉴에서 검색하거나 다음 명령어로 실행할 수 있습니다:"
echo "- terminator"
echo "- arduino"
echo "- code"