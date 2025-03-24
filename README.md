# Ansible을 이용한 Disk Partition 관리

## 파티션 및 디스크 매핑

```shell
$ cat extract_parts.sh
#!/bin/bash

# df -h의 결과에서 "/dev/xvd"로 시작하는 장치의 매핑 정보를 출력하는 스크립트
echo "---"
echo "disks:"
df -h | awk '/^\/dev\/xvd/ {print $1, $NF}' | while read device mountpoint
do
echo "  - device: $device"
echo "    mount: $mountpoint"
done

$ sh extract_parts.sh > mapping.yml
```

## 매핑 정보 할당

```yaml
$ vi create_parts.yml
---
- hosts: localhost
  become: true

  vars_files:
    - mapping.yml

... 생략

```

## Ansible Playbook 실행

```shell
$ ansible-playbook -i inventory.ini  create_parts.yml
```
