## Section-2-Getting Started with OpenTofu

#### Connect to EC2 instance

```shell
ssh -i <private_key>.pem ubuntu@<public_ip>
```

#### OpenTofu Installation on Ubuntu

```shell
sudo snap install --classic opentofu
tofu --version
```

#### AWS CLI Installation on Ubuntu

```shell
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip
unzip awscliv2.zip
sudo ./aws/install
aws --version
```

#### To configure AWS with OpenTofu

```shell
aws configure
```







