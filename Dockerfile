# Run latest version of Apache Spark 2.0.1 (Slave) in a RHEL7 container
FROM registry.access.redhat.com/rhel7/rhel
MAINTAINER Ganesh R, gradhakr@nilanet.com

# Upgrade the system
RUN yum -y upgrade
RUN yum -y install wget tar gunzip

# Download OpenJDK 8
RUN yum -y install java-1.8.0-openjdk-devel

# Set the Java & Spark Home env variables
ENV JAVA_HOME /usr/lib/jvm/java-openjdk 
ENV SPARK_DIR /Spark

# Download Apache Spark 2.0.1 (approx. 179mb)
RUN wget --no-cookies --no-check-certificate "http://d3kbcqa49mib13.cloudfront.net/spark-2.0.1-bin-hadoop2.7.tgz" -O /tmp/spark.tgz

# Switch to Spark directory 
WORKDIR ${SPARK_DIR}

# Unzip the file into current working directory
RUN tar -xzf /tmp/spark.tgz

# Set Spark env variables
ENV SPARK_VERSION 2.0.1
ENV SPARK_PACKAGE spark-${SPARK_VERSION}-bin-hadoop2.7
ENV SPARK_HOME ${SPARK_DIR}/${SPARK_PACKAGE}

# Set java bin directory in PATH
ENV PATH ${JAVA_HOME}/bin:${PATH}

# Change perms for spark directory
RUN chmod -R 777 ${SPARK_HOME}

# Switch to Spark Home directory 
WORKDIR ${SPARK_HOME}

# Start the Apache Spark slave process.
CMD ["/bin/sh","-c","bin/spark-class org.apache.spark.deploy.worker.Worker ${SPARK_MASTER_SERVICE_HOST}:${SPARK_MASTER_SERVICE_PORT}"]
