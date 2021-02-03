# This command has to used within a kubernetes pod on the image of Dockerfile

# TOKEN : content of file /run/secrets/kubernetes.io/serviceaccount/token
# NAMESPACE : content of file /run/secrets/kubernetes.io/serviceaccount/namespace
# SERVICEACCOUNT : serviceaccount of Kubernetes namespace where the image of Docker file has been deployed
# This ServiceAccount needs to have a rolebinding to pods, services, configmaps creation, update, delete
# KUBERNETES_SERVICE_HOST and KUBERNETES_SERVICE_PORT are automaticly set in container

./spark-submit --master k8s://https://$KUBERNETES_SERVICE_HOST:$KUBERNETES_SERVICE_PORT \
 --deploy-mode cluster \
 --name JavaSpark3Job \
 --conf spark.kubernetes.authenticate.submission.caCertFile=/run/secrets/kubernetes.io/serviceaccount/ca.crt \
--conf spark.kubernetes.authenticate.submission.oauthToken=$TOKEN \
 --conf spark.kubernetes.container.image=fchapuzot/spark:3.0.1 \
 --conf spark.kubernetes.namespace=$NAMESPACE \
 --conf spark.executor.instances=5 \
 --conf spark.kubernetes.authenticate.driver.serviceAccountName=$SERVICEACCOUNT \
 --conf spark.kubernetes.driver.label.job_id=24c16b5b-ab85-49a0-90bb-ef8cb3ea323b \
 --conf spark.kubernetes.submission.waitAppCompletion=false \
 --conf spark.hadoop.dfs.client.use.datanode.hostname=true \
 --conf spark.kubernetes.container.image.pullPolicy=IfNotPresent \
 --conf spark.kubernetes.executor.deleteOnTermination=true \
 --conf spark.kubernetes.submission.connectionTimeout=10000 \
 --conf spark.kubernetes.submission.requestTimeout=10000 \
 --conf spark.kubernetes.driver.connectionTimeout=10000 \
 --conf spark.kubernetes.driver.requestTimeout=10000 \
 --class org.apache.spark.examples.SparkPi local:/opt/spark/examples/jars/spark-examples_2.12-3.0.1.jar \