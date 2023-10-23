FROM mongo:latest
WORKDIR /
#ENTRYPOINT "./docker/mongo/mongo-db-setup.sh"
#RUN chmod 755 mongo-db-setup.sh
#CMD ["executable", "./docker/mongo/mongo-db-setup.sh"]
#CMD ["bash", "./docker/mongo/mongo-db-setup.sh"]
ENV MONGO_INITDB_ROOT_USERNAME admin-user
ENV MONGO_INITDB_ROOT_PASSWORD admin-password
ENV MONGO_INITDB_DATABASE admin

ADD ./docker/mongo/mongo-init.js /docker-entrypoint-initdb.d/
