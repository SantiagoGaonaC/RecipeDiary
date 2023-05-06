import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:frontend/rec.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class Recipefull extends StatefulWidget {
  rec recta;
  Recipefull({required this.recta});
  @override
  _Recipefull createState() => _Recipefull(recta: recta);
}

class _Recipefull extends State<Recipefull> {
  rec recta;
  _Recipefull({required this.recta});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  rec? sart;
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
        title: Text('Receta'),
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
      body: ListView(
        children: [
          SizedBox(height: 16.0),
          Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(recta.sTitulo,
                style: TextStyle(fontSize: 25.0, color: Colors.black)),
          ),
          SizedBox(height: 15.0),
          Hero(
              tag: recta.sImagen,
              child: Image.network(recta.sImagen,
                  height: 150.0, width: 100.0, fit: BoxFit.contain)),
          SizedBox(height: 20.0),
          HtmlWidget(
            recta.sSumary,
          ),
          SizedBox(height: 20.0),
          Center(
            child: Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text("Ingredientes",
                  style: TextStyle(fontSize: 25.0, color: Colors.black)),
            ),
          ),
          SizedBox(height: 20.0),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 50.0,
              child: Text(recta.ingredientes,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 16.0,
                  )),
            ),
          ),
          SizedBox(height: 20.0),
          Center(
            child: Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text("Instrucciones",
                  style: TextStyle(fontSize: 25.0, color: Colors.black)),
            ),
          ),
          SizedBox(height: 20.0),
          HtmlWidget(
            recta.sIntru,
          ),
          SizedBox(height: 20.0),
          Center(
            child: Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text("Pasos",
                  style: TextStyle(fontSize: 25.0, color: Colors.black)),
            ),
          ),
          SizedBox(height: 20.0),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 50.0,
              child: Text(recta.sPasos,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 16.0,
                  )),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.favorite),
      ),
    );
  }
}
