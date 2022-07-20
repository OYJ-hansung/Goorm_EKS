# 1. kubectl 바이너리 설치
```bash
1. 다음 명령으로 최신 릴리스를 다운로드
curl -LO https://dl.k8s.io/release/v1.22.0/bin/linux/amd64/kubectl

2. kubectl 설치
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

3 kubectl 버전 확인
kubectl version --client --output=yaml      
```

# 2. AWS CLI Install & Configure
```bash
1. aws cli 설치
sudo apt update && sudo apt install awscli

2 aws configure
AWS Access Key ID [None]: # AWS Access Key ID
AWS Secret Access Key [None]: # AWS Secret Access Key
Default region name [None]: # ap-northeast-2
Default output format [None]: # Enter

3. kube configure
aws eks --region ap-northeast-2 update-kubeconfig --name GoormEKSCluster

4. 노드 조회
kubectl get nodes
```

