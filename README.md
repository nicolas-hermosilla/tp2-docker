## Mise en pratique - Docker Application Express JS

### 1. Compléter le Dockerfile afin de builder correctement l’application contenu dans src/

```
# Dockerfile

FROM node:12-alpine3.9
ENV NODE_ENV=production

WORKDIR /app
COPY src/ ./src/
COPY package.json .

RUN npm install --production

CMD ["node", "src/index.js"]
```



### a. Une option de npm vous permet de n’installer que ce qui est nécessaire. Quelle est cette option ? Quelle bonne pratique Docker permet t-elle de respecter ?

Pour installer seulement ce qui est nécéssaire : 

```
RUN npm install --production
```

Utiliser cette commande permet d'éviter d'installer des fichiers inutiles dans le conteneur et peut donc aussi améliorer les perfomances.

### 2. A l’aide de la commande docker build, créer l’image ma_super_app

```
docker build . --tag ma_super_app
[+] Building 11.9s (7/7) FINISHED

docker images
REPOSITORY                 TAG       IMAGE ID       CREATED          SIZE
ma_super_app               latest    8c7515d07f3a   16 minutes ago   88.5MB
```


### 3. Compléter le fichier docker-compose.yml afin d’éxécuter ma_super_app avec sa base de données./!\ Utiliser correctement les variables d’environnement afin de configurer la base de données et l’application /!\

```
# docker-compose.yml

version: '3.9'
services:
  node:
    image: ma_super_app
    container_name: node-app
    ports:
      - 3000:3000
    environment:
      DATABASE_HOST: db 
      DATABASE_PORT: 3306
      DATABASE_USERNAME: user1
      DATABASE_PASSWORD: P@ssw0rd
      DATABASE_NAME: test
    depends_on:
      - db


  db:
    image: mysql:5.7
    container_name: mysqldb
    restart: always
    ports:
      - 3306:3306
    environment:
      MYSQL_USER: user1
      MYSQL_ROOT_PASSWORD: P@ssw0rd
      MYSQL_PASSWORD: P@ssw0rd
      MYSQL_DATABASE: test
```

#### Vérifier l'éxécution des deux conteneurs
```
docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS                               NAMES
a21b582d88cc   ma_super_app   "docker-entrypoint.s…"   6 seconds ago   Up 4 seconds   0.0.0.0:3000->3000/tcp              node-app
e349e19b7358   mysql:5.7      "docker-entrypoint.s…"   7 seconds ago   Up 6 seconds   0.0.0.0:3306->3306/tcp, 33060/tcp   mysqldb
```

#### Voir les logs du conteneur

```
docker logs -f node-app
Running on port 3000
```

#### Vérifier sur le navigateur web
![](https://i.imgur.com/8UMMFrc.png)