import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'shared_preferences.dart';
import 'main.dart';

void main() => runApp(MyApp());

void _logout(BuildContext context) async {
  String? token = await MySharedPreferences.getToken();
  print(token);
  final url = Uri.parse('http://recipediary.bucaramanga.upb.edu.co/api/logout');
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
    await MySharedPreferences.clearToken();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MyHomePage(title: 'Recipe Diary'),
      ),
    );
  } else {
    // De lo contrario, throw exception
    // Mostrar snackbar con mensaje de error
    print("Error en cerrar la sesión");
    await MySharedPreferences.clearToken();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MyHomePage(title: 'Recipe Diary'),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe Diary',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: SearchBarWidget(),
      ),
    );
  }
}

class SearchBarWidget extends StatefulWidget {
  SearchBarWidget({Key? key}) : super(key: key);

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> usernames = [];
  List<dynamic> names = [];
  List<dynamic> lastNames = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _searchUser(BuildContext context) async {
    String? token = await MySharedPreferences.getToken();
    String userValue = _searchController.text;
    if (token != null) {
      final url = Uri.parse(
          'http://recipediary.bucaramanga.upb.edu.co/api/users/search?searchTerm=${userValue}');
      final headers = {'Authorization': 'Bearer ${token}'};

      final response = await http.get(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then navigate to the verified page
        final data = jsonDecode(response.body);
        final filteredUsers = data['data'];
        setState(() {
          usernames = filteredUsers.isNotEmpty
              ? filteredUsers.map((user) => user['username']).toList()
              : [];
          names = filteredUsers.isNotEmpty
              ? filteredUsers.map((user) => user['name']).toList()
              : [];
          lastNames = filteredUsers.isNotEmpty
              ? filteredUsers.map((user) => user['lastName']).toList()
              : [];
          print('Search completed successfully');
          print(filteredUsers);
          print('Usernames ${usernames}');
          print('Names ${names}');
          print('Last names ${lastNames}');
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Error, compruebe el término de búsqueda o vuelva a iniciar sesión.'),
          ),
        );
        print(token);
        print('Error searching');
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(title: 'Recipe Diary'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('Recipe Diary'),
            expandedHeight: 50,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff6A5BF2),
                      Color(0xff5AAC69),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.exit_to_app),
                padding: EdgeInsets.only(right: 15),
                onPressed: () => _logout(context),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: 20.0),
                  Text(
                    'BUSCADOR DE USUARIOS',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Digite un nombre o usuario',
                            suffixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.0),
                      SizedBox(
                        width: 90.0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xff6A5BF2),
                            textStyle: TextStyle(fontSize: 16),
                          ),
                          onPressed: () {
                            // Handle search button click here
                            print('Search button clicked');
                            _searchUser(context);
                          },
                          child: Text('Buscar'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (usernames.isNotEmpty)
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text('${names[index]} ${lastNames[index]}'),
                        subtitle: Text('@${usernames[index]}'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: SizedBox(
                        width: 90,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xff5AAC69),
                            textStyle: TextStyle(fontSize: 16),
                          ),
                          onPressed: () {
                            // Handle follow button click here
                            print(
                                'Follow button clicked for ${usernames[index]}');
                          },
                          child: Text('Seguir'),
                        ),
                      ),
                    ),
                  ],
                ),
                childCount: usernames.length,
              ),
            ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
