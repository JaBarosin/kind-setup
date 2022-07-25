# kind-setup

Setup script to get up and running with K8s. Installs kubectl, kind, and Docker.

Tested with ubuntu 18.04 and 20.04.

### Steps

1. Download script to target device
```bash
curl "https://raw.githubusercontent.com/JaBarosin/kind-setup/main/kind-setup.sh" -o "kind-setup.sh"
```
2. Run script using a user account with sudo access

```sh
chmod +x ./kind-setup.sh
sudo ./kind-setup.sh
```

3. Confirm Docker is installed and running
```sh
systemctl status docker
```
Start docker `systemctl start docker` if needed

4. Confirm kubectl and kind are installed and accessible
```sh
kubectl version && echo -e " \n" && kind version
```

5. Create kind cluster
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
kind create cluster --name kind-demo --config kind.config.yaml
```

6. Confirm cluster access
```sh
kubectl cluster-info
kubectl config view
```
