# Recipe's API

This repository contains the implementation of the Recipe's Diary API.

## Setup

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