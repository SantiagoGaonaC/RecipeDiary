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
        title: Text('Add new post'),
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
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Input a title',
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please add a title for your post';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _bodyController,
              decoration: InputDecoration(
                hintText: 'Input a body',
              ),
              maxLines: null,
              keyboardType: TextInputType.multiline,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please add some content to your post';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Color(0xff6A5BF2)),
                    onPressed: _submitForm,
                    child: Text(
                      'Post',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState?.validate() == true) {
      // Here you can send the post data to an API or store it locally
      final title = _titleController.text;
      final content = _bodyController.text;

      final url = Uri.parse(
          'http://recipediary.bucaramanga.upb.edu.co:4000/api/socmed/post');
      String? token = await MySharedPreferences.getToken();
      print(token);
      final headers = {
        'Authorization': 'Bearer ${token}',
        'Content-Type': 'application/json'
      };
      final body = json.encode({
        "title": title,
        "content": content,
      });

      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        print('Success publishing new post');
        print('Title: $title\nBody: $content');
        Navigator.pop(context, true);
      } else {
        print('Failed to fetch: not code 200');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('There was an error submitting the post.'),
          ),
        );
        print('Title: $title\nBody: $content');
        print(response.statusCode);
        print(response.body.toString());
        throw Exception('There was an error submitting the post');
      }
    }
  }
}
