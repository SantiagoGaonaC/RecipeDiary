import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class recipe {
  String sImagen;
  String sTitulo;
  List<String>? ingredientes;
  List<String>? pasos;
  int sId;

  factory recipe.fromJson(Map<String, dynamic> json) {
    return recipe(
      sImagen: json['image'] as String,
      sTitulo: json['title'] as String,
      sId: json['id'] as int,
    );
  }

  recipe({required this.sImagen, required this.sTitulo, required this.sId});

  static List<recipe> fromJsonList(List<dynamic> jsonList) {
    List<recipe> listaRecipes = [];
    if (jsonList != null) {
      for (var reciperf in jsonList) {
        final recipeFinal = recipe.fromJson(reciperf);
        listaRecipes.add(recipeFinal);
      }
    }
    return listaRecipes;
  }
}
