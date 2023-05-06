import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/recipe.dart';
import 'package:frontend/rec.dart';
import 'package:frontend/recipeFull.dart';
import 'package:frontend/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class listRecipes extends StatefulWidget {
  Future<List<recipe>>? ListRecipe;
  listRecipes({required this.ListRecipe});
  @override
  _listRecipes createState() => _listRecipes(ListRecipe: ListRecipe);
}

class _listRecipes extends State<listRecipes> {
  Future<List<recipe>>? ListRecipe;
  _listRecipes({required this.ListRecipe});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lista de recetas'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff6A5BF2), Color(0xff5AAC69)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
        ),
        body: FutureBuilder(
          future: ListRecipe,
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var recipe = snapshot.data![index];
                  return CajaRecipe(ListRecipe: recipe);
                },
              );
            } else {
              print(snapshot.error);
              return Text("${snapshot.error}");
            }
          },
        ));
  }
}

class CajaRecipe extends StatelessWidget {
  recipe ListRecipe;

  CajaRecipe({required this.ListRecipe});

  Future<List<rec>> getRecipefull() async {
    String? token = await MySharedPreferences.getToken();

    final url = Uri.parse(
        'http://recipediary.bucaramanga.upb.edu.co:4000/api/info?ids=${ListRecipe.sId.toString()}');
    final headers = {'Authorization': 'Bearer ${token}'};

    final response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final respuestaJSON = json.decode(response.body);
      return rec.fromJsonList(respuestaJSON);
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          List<rec> ListRecipe = await getRecipefull();

          print(ListRecipe);
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Recipefull(recta: ListRecipe[0]),
            ),
          );
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Image.network("${ListRecipe.sImagen}",
                          width: 300, height: 100),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(ListRecipe.sTitulo),
                      Text(ListRecipe.sId.toString()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  _launchURL() async {
    final url = ListRecipe.sImagen;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
