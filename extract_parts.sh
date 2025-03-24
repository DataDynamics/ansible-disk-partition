#!/bin/bash

# df -h의 결과에서 "/dev/xvd"로 시작하는 장치의 매핑 정보를 출력하는 스크립트
echo "---"
echo "disks:"
df -h | awk '/^\/dev\/xvd/ {print $1, $NF}' | while read device mountpoint
do
echo "  - device: $device"
echo "    mount: $mountpoint"
done
