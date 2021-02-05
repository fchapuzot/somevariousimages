# This command has to used within a kubernetes pod on the image of Dockerfile
# The pod has to be created with a ServiceAccount of have a rolebinding to pods creation, update, delete
# TOKEN : content of file /run/secrets/kubernetes.io/serviceaccount/token
# NAMESPACE : content of file /run/secrets/kubernetes.io/serviceaccount/namespace
# KUBERNETES_SERVICE_HOST and KUBERNETES_SERVICE_PORT are automaticly set in container

curl -k \
    -X POST \
    -d @- \
    -H "Authorization: Bearer $TOKEN" \
    -H 'Accept: application/json' \
    -H 'Content-Type: application/json' \
    https://$KUBERNETES_SERVICE_HOST:$KUBERNETES_SERVICE_PORT/api/v1/namespaces/$NAMESPACE/pods <<'EOF'
{
   "kind": "Pod",
  "apiVersion": "v1",
  "metadata": {
    "name": "hello-openshift",
    "creationTimestamp": null,
    "labels": {
      "name": "hello-openshift"
    }
  },
  "spec": {
    "containers": [
      {
        "name": "hello-openshift",
        "image": "httpd:latest",
        "ports": [
          {
            "containerPort": 8080,
            "protocol": "TCP"
          }
        ],
        "resources": {},
        "volumeMounts": [
          {
            "name":"tmp",
            "mountPath":"/tmp"
          }
        ],
        "terminationMessagePath": "/dev/termination-log",
        "imagePullPolicy": "IfNotPresent",
        "securityContext": {
          "capabilities": {},
          "privileged": false
        }
      }
    ],
    "volumes": [
      {
        "name":"tmp",
        "emptyDir": {}
      }
    ],
    "restartPolicy": "Always",
    "dnsPolicy": "ClusterFirst",
    "serviceAccount": ""
  },
  "status": {}
}
EOF