#!/bin/bash
 
# Terminator 설치 스크립트
 
echo "✅ 패키지 목록을 업데이트합니다..."

sudo apt update
 
echo "✅ Terminator를 설치합니다..."

sudo apt install -y terminator
 
# 설치 확인용 명령어 알림

echo "✅ 설치 완료! 아래 명령어로 실행해보세요:"

echo ""

echo "terminator"

echo ""

echo "또는 애플리케이션 메뉴에서 'terminator'를 검색해 실행할 수 있습니다."
