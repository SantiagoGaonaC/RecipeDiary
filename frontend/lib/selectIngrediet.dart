import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'ItemsList.dart';
import 'main.dart';

void _logout(BuildContext context) async {
  String? token = await MySharedPreferences.getToken();
  print(token);
  final url =
      Uri.parse('http://recipediary.bucaramanga.upb.edu.co:4000/api/logout');
  final headers = {'Authorization': 'Bearer ${token}'};
  print(headers);

  final response = await http.post(
    url,
    headers: headers,
  );

  if (response.statusCode == 200) {
    // Si el servidor retornó 200 OK
    // Navigate to the login page
    print('Successfully logged out');
  } else {
    // De lo contrario, throw exception
    // Mostrar snackbar con mensaje de error
    print("Error en cerrar la sesión");
  }
  await MySharedPreferences.clearToken();
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => MyHomePage(title: 'Recipe Diary'),
    ),
  );
}

class selectIngrediet extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<selectIngrediet>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final ItemsList ingredientes = ItemsList();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 15, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: AppBar(
          title: Text('Pick your ingredients'),
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
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              height: 20000,
              child: TabBarView(controller: _tabController, children: [
                ingredientes,
              ]),
            ),
          ],
        ),
        bottomNavigationBar: CustomBottomNavigationBar(),
      ),
    );
  }
}
