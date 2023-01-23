# K8s
In this project I deployed a Kubernetes cluster with kubeadm and Third VM for Jenkins CI/CD Server.  
The Cluster contain 2 Nodes
  1. Master  - 192.168.56.104
  2. Worker1 - 192.168.56.105

Jenkins Pipeline:
 include 3 stages
  1. Build-   Build with docker the image of my web application.
  2. Push-    Push the built image to my DockerHub Repository (yossibenga/web-app:latest).
  3. Deploy-  Run the deploy.sh script.
  
Deploy.sh:
 include 3 functions
  1. docker_run- Make ssh connection to Master node and run the web-app container.
  2. copy_to_remote_machine- Make scp connection to Master node and send the Helm-yossi-ingress folder.
  3. run_helm- First uninstall and delete older helm and namespace that I gonna use.
               Second install and create helm and namespace "mission".

Check for deployment of namespace and ruuning pods:

![image](https://user-images.githubusercontent.com/82327346/214044974-d19eed9b-b363-444b-917a-5d2c72fb2d40.png)


For display the website enter in the browser htttp:// then the Worker1 IP & the Load Balancer PORT 30010  
http://192.168.56.105:30010
