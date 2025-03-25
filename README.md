# Ansible Playbook for Managing Disks of Hadoop Cluster

## 파티션 및 디스크 매핑

Hadoop Worker 노드는 Disk가 많이 구성되어 있어서 일괄 처리를 위해서 기 구성되어 있는 파티션 정보를 추출합니다.

다음의 스크립트를 통해 생성되는 Yaml 파일은 기존에 구성되어 있는 파티션을 삭제하거나 생성하는 용도로 사용할 수 있습니다.

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

디스크 및 파티션 매핑을 다음과 같이 적용합니다.

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
