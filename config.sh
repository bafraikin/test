#docker
sudo apt-get update -y

sudo apt-get install -y\
	ca-certificates \
	curl \
	gnupg \
	lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
	"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
	$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y

sudo apt-get install -y docker-ce docker-ce-cli containerd.io

#k3d
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash



#kubectl
sudo apt-get update && sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update -y
sudo apt-get install -y kubectl

alias 'k'='kubectl'
#create cluster with redirection port
k3d create cluster -p "8888:30080"
#create namespace argocd & dev with wil-playground in namespace dev
kubectl apply -f .
#install argocd 
#https://argo-cd.readthedocs.io/en/stable/getting_started/
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

