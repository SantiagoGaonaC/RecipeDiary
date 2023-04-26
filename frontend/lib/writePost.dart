import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'shared_preferences.dart';
import 'profile.dart';
import "main.dart";

class ComposePostPage extends StatefulWidget {
  @override
  _ComposePostPageState createState() => _ComposePostPageState();
}

class _ComposePostPageState extends State<ComposePostPage> {
  final _formKey = GlobalKey<FormState>();
  String? _title = '';
  String? _body = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Publicar nuevo post'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Digite un título',
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Por favor digite un título';
                }
                return null;
              },
              onSaved: (value) {
                _title = value;
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Digite el contenido',
              ),
              maxLines: null,
              keyboardType: TextInputType.multiline,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Por favor digite el contenido';
                }
                return null;
              },
              onSaved: (value) {
                _body = value;
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Post'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() == true) {
      _formKey.currentState?.save();
      // Here you can send the post data to an API or store it locally
      print('Title: $_title\nBody: $_body');
      Navigator.pop(context);
    }
  }
}
