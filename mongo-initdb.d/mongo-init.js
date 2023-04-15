db.createUser(
    {
        user: "recipeadmin",
        pwd: "recipeadmin",
        roles: [
            {
                role: "readWrite",
                db: "RecipeDiary"
            }
        ]
    }
);