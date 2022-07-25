# kind-setup

Setup script to get up and running with K8s. Installs kubectl, kind, and Docker.

Tested with ubuntu 18.04 and 20.04.

### Steps

1. **Update and install curl.**
```sh
sudo apt update -y
```
```
sudo apt install open-vm-tools -y && sudo apt update && sudo apt upgrade -y && sudo apt install curl -y
```

2. **Download script to target device.**
```bash
curl "https://raw.githubusercontent.com/JaBarosin/kind-setup/main/kind-setup.sh" -o "kind-setup.sh"
```

3. **Run script using a user account with sudo access.**
```sh
chmod +x ./kind-setup.sh && sudo ./kind-setup.sh
```

4. **Confirm Docker is installed and running.**
```sh
systemctl status docker
```
Start docker `systemctl start docker` if needed.
```sh
docker version
```
If unable to run docker, add user to docker group `sudo usermod -aG docker $USER` (where $USER is user account) and refresh the session `su - $USER`.

5. **Confirm kubectl and kind are installed and accessible** by running `kubectl version` and `kind version`

6. **Create kind cluster.**
```sh
cat > kind-config.yaml <<EOF
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: worker
- role: worker
EOF
```

```sh
kind create cluster --name kind-demo --config kind-config.yaml
```

7. **Confirm cluster access.**
```sh
kubectl cluster-info && kubectl get no -o wide
```
