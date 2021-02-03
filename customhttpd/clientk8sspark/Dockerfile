FROM fchapuzot/customhttpd:2.4

RUN apk update && apk add curl git gzip wget openjdk8 && apk upgrade

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.15.1/bin/linux/amd64/kubectl
RUN wget -O /usr/local/spark-3.0.1-bin-hadoop2.7.tgz http://archive.apache.org/dist/spark/spark-3.0.1/spark-3.0.1-bin-hadoop2.7.tgz
RUN chmod u+x kubectl && mv kubectl /bin/kubectl
RUN cd /usr/local && tar -xzvf spark-3.0.1-bin-hadoop2.7.tgz