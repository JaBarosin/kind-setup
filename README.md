# kind-setup

Setup script to get up and running with K8s. Installs kubectl, kind, and Docker.

Tested with ubuntu 18.04 and 20.04.

### Steps

1. **Update and install vmtools + curl**
```sh
sudo apt update && sudo apt upgrade -y
```
If `Could not get lock` error occurs, check to see if Software Updater is already running in background and wait or kill proc listed in error.
```sh
sudo apt install curl -y
```

2. **Download script to target device.**
```bash
curl "https://raw.githubusercontent.com/JaBarosin/kind-setup/main/kind-setup-v2.sh" -o "kind-setup-v2.sh"
```

3. **Run script using a user account with sudo access.**
```sh
chmod +x ./kind-setup-v2.sh && sudo ./kind-setup-v2.sh
```

4. **Confirm Docker is installed and running.**
```sh
systemctl status docker
```
Start docker `systemctl start docker` if needed.
```sh
docker version
```
If unable to run docker, add user to docker group `sudo usermod -aG docker $USER` and refresh the session `su - $USER`.

5. **Confirm kubectl and kind are installed and accessible**
```sh
kubectl version
```
```sh
kind version
```

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
