# Recipe Diary API

---

# ***Register,Login,Logout,ID/Profile***

## Register

## (POST /api/register)

The password is saved on the server in encrypted form

```json
{
  "username": "usuarioprueba",
  "password": "contraseña123",
  "name": "Prueba",
  "lastName": "Pérez"
}
```

Response successfully:

```json
{
    "message": "El usuario se ha registrado con éxito"
}
```

If the user is already registered

```json
{
    "message": "El usuario ya existe"
}
```

If an error occurs when registering the user

```json
{
    "message": "Ha ocurrido un error al registrar el usuario"
}
```

## Login

## (POST /api/login)

The above record is taken as an example

```json
{
  "username": "usuarioprueba",
  "password": "contraseña123"
}
```

Response successfully:

```json
{
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NDMxYjYyMzhjMDIzOTE1YzQ0YzJmMzciLCJpYXQiOjE2ODEwODk2OTZ9.Lrw-W0lPPxbBXbeCPmYJzZXtW2mAV5nmt6HTZ5UBFxY"
}
```

If an error occurs when login the user:

```json
{
    "token": "El usuario no existe"
}
```

```json
{
    "token": "El usuario o la contraseña son incorrectos"
}
```

## Logout

## (POST /api/logout)

The token/Headers of Authorization must be passed to you

Example:

```json
Authorization = Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NDQ0YTRjMzg1MDI2YjA5MWIwY2U1YjQiLCJpYXQiOjE2ODIyMjAyNzAsImV4cCI6MTY4MjI2MzQ3MH0.txoDCxnL1uQ97BxbKfbCA-2L3IeLh6ww078R3g3bFQQ
```

Response successfully:

```json
{
    "message": "Sesión cerrada exitosamente"
}
```

## ID-Profile

## (GET /api/profile)

The token/Headers of Authorization must be passed to you

Example:

```json
Authorization = Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NDQ0YTRjMzg1MDI2YjA5MWIwY2U1YjQiLCJpYXQiOjE2ODIyMjAyNzAsImV4cCI6MTY4MjI2MzQ3MH0.txoDCxnL1uQ97BxbKfbCA-2L3IeLh6ww078R3g3bFQQResponse successfully:
```

Response successfully:

```json
{
    "name": "Juan",
    "lastName": "Pérez"
}
```

---

# ***Social Media***

The social media routes that you will find will be used to insert a food publication, see the social media of everyone or someone specific, follow and unfollow a person and search for a user.

## Insert publication (POST /api/socmed/post)

```json5
{
  "title": "Mi nuevo post",
  "content": "Este es mi nuevo post. ¡Espero que les guste!"
}
```

##### Response

```json
{
    "userId": "6430f21516ad9948b653afa8",
    "title": "Mi nuevo post",
    "content": "Este es mi nuevo post. ¡Espero que les guste!",
    "_id": "6433641a19d3773c3177da66",
    "createdAt": "2023-04-10T01:19:22.903Z",
    "__v": 0
}
```

## View Social publications

## (GET /api/socmed/posts)

Need auth token

```json
[
    {
        "_id": "643a0a9fcf3eb632d4e2de45",
        "userId": "643a094ecf3eb632d4e2de41",
        "title": "Mi nuevo post",
        "content": "Este es mi nuevo post. ¡Espero que les guste!",
        "createdAt": "2023-04-15T02:23:27.181Z",
        "__v": 0
    }
]
```

## Follow

## (POST /api/socmed/follow)

```json
{
    "username": "usuarioprueba"
}
```

Find user is correct-> follow - response:

```json
{
    "message": "Ahora sigues a usuarioprueba"
}
```

Find user is incorrect

```json
{
    "error": "Usuario no encontrado"
}
```

## UnFollow

## (POST /api/socmed/unfollow)

```json
{
    "username": "usuarioprueba"
}
```

Find user is correct-> UnFollow - response:

```json
{
    "message": "Dejaste de seguir a usuarioprueba"
}
```

## See only who follows

## (GET /api/socmed/posts-following)

The search is performed thanks to the token of the logged in user

```json
[
    {
        "_id": "6444a50485026b091b0ce5c0",
        "userId": "6444a4c385026b091b0ce5b4",
        "title": "Mi nuevo post Dos post Santiago",
        "content": "Este es mi nuevo post. ¡Espero que les guste!",
        "createdAt": "2023-04-23T03:24:52.516Z",
        "__v": 0
    },
    {
        "_id": "6444a50a85026b091b0ce5c3",
        "userId": "6444a4c385026b091b0ce5b4",
        "title": "Mi nuevo post uno post Santiago",
        "content": "Este es mi nuevo post. ¡Espero que les guste!",
        "createdAt": "2023-04-23T03:24:58.382Z",
        "__v": 0
    }
]
```

## Search User

## (GET /api/users/search)

Here it is not possible to insert in lower case and without accent, because the api returns the user matches with respect to the one that was sent in the get

*The key searchTerm must be passed to it, in this case it is being used:*

```javascript
searchTerm = perez
```

Response:

```json
{
    "success": true,
    "data": [
        {
            "_id": "6444a4c385026b091b0ce5b4",
            "username": "santiagogaona",
            "name": "Santiago",
            "lastName": "Pérez",
            "following": [],
            "__v": 4
        },
        {
            "_id": "6444a4d285026b091b0ce5b7",
            "username": "usuarioprueba",
            "name": "Prueba",
            "lastName": "Pérez",
            "following": [
                {
                    "userId": "6444a4c385026b091b0ce5b4",
                    "username": "santiagogaona",
                    "_id": "6444a65c85026b091b0ce5f9"
                }
            ],
            "__v": 1
        }
    ]
}
```

# See who i follow

## (GET (200) /api/socmed/following)

You only need to pass the token/authorization and returns the people the user follows

```json
[
    {
        "userId": "6444a4c385026b091b0ce5b4",
        "username": "santiagogaona",
        "_id": "6444a65c85026b091b0ce5f9"
    }
]
```

# Delete my post in social media

You only need to pass the token/authorization and the id post in the social media

## (DEL (json) /api/socmed/post/:postId)

```json
{
    "message": "Publicación eliminada correctamente"
}
```

# View my post in social media

You only need to pass the token/authorization and returns the all post of person

## (GET (json) /api/socmed/my-posts)

```json
[
    {
        "_id": "6448b25d61473696ce1a08d3",
        "userId": "6444a4d285026b091b0ce5b7",
        "title": "Mi nuevo post uno post Santiago",
        "content": "Este es mi nuevo post. ¡Espero que les guste!",
        "createdAt": "2023-04-26T05:10:53.981Z",
        "__v": 0
    }
]
```

---

# ***Food***

## Ingredients

## (GET /api/suggestions)

You need to insert the ingredients for example:

```json
ingredients = carrots,tomatoes
```
