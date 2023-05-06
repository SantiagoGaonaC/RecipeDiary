import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/profile.dart';
import 'package:frontend/recipe.dart';
import 'package:frontend/shared_preferences.dart';
import 'package:frontend/writePost.dart';
import 'package:http/http.dart' as http;

import 'listRecipes.dart';
import 'main.dart';

class ItemsList extends StatelessWidget {
  bool _isTapped = false;
  String strIngredientes = "";
  final myController = TextEditingController();
  Future<String> getStrIngre() async {
    final ing = strIngredientes;
    return ing;
  }

  Future<List<recipe>> getListRecipes() async {
    String? token = await MySharedPreferences.getToken();
    String strIngredientes = await getStrIngre();
    print(token);
    final url = Uri.parse(
        'http://recipediary.bucaramanga.upb.edu.co:4000/api/suggestions?ingredients=${strIngredientes}');
    final headers = {'Authorization': 'Bearer ${token}'};

    final response = await http.get(
      url,
      headers: headers,
    );
    print(response.body);
    if (response.statusCode == 200) {
      final respuestaJSON = json.decode(response.body);
      print("!asdasdasd");
      print(respuestaJSON);
      final recipesFinal = recipe.fromJsonList(respuestaJSON);
      return recipesFinal;
    }
    print("!asdasdaswwwwwwd");
    return <recipe>[];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCFAF8),
      body: ListView(
        children: <Widget>[
          TextField(
            controller: myController,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
              enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                      width: 1, color: Colors.black, style: BorderStyle.solid)),
              hintStyle: TextStyle(color: Colors.black),
              hintText: "Ingredient list",
              prefixIcon: Padding(
                padding: EdgeInsets.all(10),
              ),
            ),
          ),
          SizedBox(height: 15.0),
          Container(
              padding: const EdgeInsets.all(8.0),
              width: MediaQuery.of(context).size.width - 30.0,
              height: MediaQuery.of(context).size.height - 280.0,
              child: GridView.count(
                crossAxisCount: 3,
                primary: false,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 15.0,
                childAspectRatio: 0.9,
                children: <Widget>[
                  _buildCard(
                      'Tomato',
                      'https://spoonacular.com/cdn/ingredients_100x100/tomato.png',
                      context),
                  _buildCard(
                      'Egg',
                      'https://spoonacular.com/cdn/ingredients_100x100/egg.png',
                      context),
                  _buildCard(
                      'Flour',
                      'https://spoonacular.com/cdn/ingredients_100x100/flour.png',
                      context),
                  _buildCard(
                      'Rice',
                      'https://spoonacular.com/cdn/ingredients_100x100/uncooked-white-rice.png',
                      context),
                  _buildCard(
                      'Chickpeas',
                      'https://spoonacular.com/cdn/ingredients_100x100/chickpeas.jpg',
                      context),
                  _buildCard(
                      'Garlic',
                      'https://spoonacular.com/cdn/ingredients_100x100/garlic.jpg',
                      context),
                  _buildCard(
                      'Honey',
                      'https://spoonacular.com/cdn/ingredients_100x100/honey.jpg',
                      context),
                  _buildCard(
                      'Olives',
                      'https://spoonacular.com/cdn/ingredients_100x100/olives-stuffed.jpg',
                      context),
                  _buildCard(
                      'Meat',
                      'https://spoonacular.com/cdn/ingredients_100x100/duck-breast.png',
                      context),
                  _buildCard(
                      'Chicken',
                      'https://spoonacular.com/cdn/ingredients_100x100/chicken-breasts.png',
                      context),
                  _buildCard(
                      'ham',
                      'https://spoonacular.com/cdn/ingredients_100x100/ham-whole.jpg',
                      context),
                  _buildCard(
                      'Lettuce',
                      'https://spoonacular.com/cdn/ingredients_100x100/iceberg-lettuce.jpg',
                      context),
                  _buildCard(
                      'Tuna',
                      'https://spoonacular.com/cdn/ingredients_100x100/anchovies.jpg',
                      context),
                  _buildCard(
                      'Carrot',
                      'https://spoonacular.com/cdn/ingredients_100x100/sliced-carrot.png',
                      context),
                  _buildCard(
                      'cob',
                      'https://spoonacular.com/cdn/ingredients_100x100/corn-on-the-cob.jpg',
                      context),
                ],
              )),
          const SizedBox(height: 20.0),
          SizedBox(
            width: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 200,
                height: 40,
                child: ElevatedButton(
                  onPressed: () async {
                    //String? d = await getListRecipes(context);
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            listRecipes(ListRecipe: getListRecipes()),
                      ),
                    );
                  },
                  child: Text(
                    'Add ingredients',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff5AAC69),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String name, String imgPath, context) {
    return Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
        child: InkWell(
            onTap: () {
              if (!strIngredientes.contains(name)) {
                strIngredientes = "$strIngredientes$name,";
              } else {
                strIngredientes = strIngredientes.replaceAll("$name,", "");
              }
              myController.text = strIngredientes;
              _isTapped = !_isTapped;
            },
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                          //color: _isTapped ? Colors.blue : Colors.grey.withOpacity(0.2) color: _isTapped
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3.0,
                          blurRadius: 5.0)
                    ],
                    color: Colors.white),
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.all(5.0),
                  ),
                  Hero(
                      tag: imgPath,
                      child: Container(
                        height: 85.0,
                        width: 85.0,
                        child: Image.network(imgPath),
                      )),
                  SizedBox(height: 7.0),
                  Text(name,
                      style:
                          TextStyle(color: Color(0xFF575E67), fontSize: 14.0)),
                ]))));
  }
}
