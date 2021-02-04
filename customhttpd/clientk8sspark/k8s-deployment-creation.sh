# This command has to used within a kubernetes pod on the image of Dockerfile
# The pod has to be created with a ServiceAccount of have a rolebinding to deployments creation, update, delete
# TOKEN : content of file /run/secrets/kubernetes.io/serviceaccount/token
# NAMESPACE : content of file /run/secrets/kubernetes.io/serviceaccount/namespace
# KUBERNETES_SERVICE_HOST and KUBERNETES_SERVICE_PORT are automaticly set in container

curl -k \
      --request POST \
      -d @- \
      -H "Authorization: Bearer $TOKEN" \
      -H 'Accept: application/json' \
      -H 'Content-Type: application/json' \
      https://$KUBERNETES_SERVICE_HOST:$KUBERNETES_SERVICE_PORT/apis/apps/v1/namespaces/nsspark/deployments <<'EOF'
  {
     "metadata":{
        "name":"apachedeployment01--1203040886",
        "namespace": "nsspark"
     },
     "apiVersion":"apps/v1",
     "kind":"Deployment",
     "spec":{
        "template":{
           "metadata":{
              "labels":{
                 "app":"apachedeployment01--1203040886"
              }
           },
           "spec":{
              "containers":[
                 {
                    "imagePullPolicy":"Always",
                    "image":"httpd:latest",
                    "name":"apache01--464145008",
                    "ports":[
                       {
                          "name":"http-endpoint",
                          "containerPort":80
                       }
                    ]
                 }
              ]
           }
        },
        "replicas":1,
        "selector":{
           "matchLabels":{
              "app":"apachedeployment01--1203040886"
           }
        }
     }
  }
EOF