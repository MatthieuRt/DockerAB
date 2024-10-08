# Utiliser une image de base Ubuntu
FROM ubuntu:20.04

# Définir le mainteneur
LABEL maintainer="your_email@example.com"

# Prévenir les invites de configuration interactives
ENV DEBIAN_FRONTEND=noninteractive

# Définir le fuseau horaire
ENV TZ=Etc/UTC

# Mettre à jour le système et installer des dépendances
RUN apt-get update && apt-get install -y \
    openjdk-11-jdk \
    wget \
    curl \
    unzip \
    python3 \
    python3-pip \
    && apt-get clean

    
# Installer PySpark via pip
RUN pip3 install pyspark

# Définir la variable d'environnement JAVA_HOME
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Télécharger et installer Spark
ENV SPARK_VERSION=3.5.1
RUN wget https://dlcdn.apache.org/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop3.tgz \
    && tar -xvzf spark-${SPARK_VERSION}-bin-hadoop3.tgz \
    && mv spark-${SPARK_VERSION}-bin-hadoop3 /opt/spark \
    && rm spark-${SPARK_VERSION}-bin-hadoop3.tgz

# Définir les variables d'environnement pour Spark
ENV SPARK_HOME=/opt/spark
ENV PATH=$SPARK_HOME/bin:$PATH

# Définir le répertoire de travail
WORKDIR /opt/spark

# Installer Pandas avec pip
RUN pip3 install --no-cache-dir pandas openpyxl

# Copier les fichiers de configuration Spark (si nécessaire)
# COPY config/spark-defaults.conf $SPARK_HOME/conf/
# COPY config/spark-env.sh $SPARK_HOME/conf/

# Définir le point d'entrée
CMD ["/opt/spark/bin/spark-shell"]

