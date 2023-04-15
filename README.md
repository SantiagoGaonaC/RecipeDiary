# Recipe's API

This repository contains the implementation of the Recipe's Diary API.

## Development

1. Install Docker (In windows Install **Docker Desktop**)
2. Clone this repository (If credentials required contact Repository responsible **Santiago Gaona**)

```shell
git clone https://dev.azure.com/RecipeDiary/Recipe%20Diary/_git/Recipe%20Diary
```

3. Move inside the cloned repository

```shell
cd "Recipe Diary"
```

4. Start the server

```
docker compose -f ./dev.docker-compose.yaml up -d
```

> If you want to stop the server

```
docker compose -f ./dev.docker-compose.yaml down --remove-orphans --rmi all -v
```

## Production

1. Install Docker (In windows Install **Docker Desktop**)
2. Clone this repository (If credentials required contact Repository responsible **Santiago Gaona**)

```shell
git clone https://dev.azure.com/RecipeDiary/Recipe%20Diary/_git/Recipe%20Diary
```

3. Move inside the cloned repository

```shell
cd "Recipe Diary"
```

4. Update the credentials in the `mongo-initdb.d/mongo-init.js`

5. Create a valid `.env` . For example in the root of this repository:

```
# For the compose
MONGO_INITDB_ROOT_USERNAME=root
MONGO_INITDB_ROOT_PASSWORD=UPDATE_THIS_PASSWORD
MONGO_INITDB_DATABASE=RecipeDiary
# For the API
SPOONACULAR_API_KEY=0ec1ba1856d84957804796d5cb1ef800
JWT_SECRET=UPDATE_THIS_SECRET
CONNECTION_DB=mongodb://recipeadmin:UPDATE_THIS_PASSWORD@mongo/RecipeDiary?retryWrites=true&w=majority
IP=0.0.0.0
PORT=4000
```

5. Start the server

```
docker compose --env-file .env up -d
```

6. Routes SV
```
sudo su
root@recipediary:/opt/backend/Recipe%20Diary#
```