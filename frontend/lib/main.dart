import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe Diary',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Account Login'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _loginFormKey = GlobalKey<FormState>();
  final _signupFormKey = GlobalKey<FormState>();

  bool _passwordVisible = false;

  TextEditingController _emailLoginController = TextEditingController();
  TextEditingController _passwordLoginController = TextEditingController();
  TextEditingController _emailSignupController = TextEditingController();
  TextEditingController _passwordSignupController = TextEditingController();
  TextEditingController _nameSignupController = TextEditingController();
  TextEditingController _lastNameSignupController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _login() async {
    if (_loginFormKey.currentState!.validate()) {
      // Si ambos campos se han llenado, hacer el login
      print('Email: ${_emailLoginController.text}');
      print('Contraseña: ${_passwordLoginController.text}');

      final email = _emailLoginController.text;
      final password = _passwordLoginController.text;

      final url = Uri.parse('http://10.0.2.2:4000/api/login');
      final headers = {'Content-Type': 'application/json'};
      final body = json.encode({
        'username': email,
        'password': password,
      });

      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        // Si el servidor retornó 200 OK
        final jsonResponse = jsonDecode(response.body);
        MySharedPreferences.saveToken(jsonResponse["token"]);
        setState(() {
          if (MySharedPreferences.getToken() != "") {
            // Navigate to the homepage
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WelcomeScreen(),
              ),
            );
          }
        });
      } else {
        // De lo contrario, throw exception
        setState(() {
          // Mostrar snackbar con mensaje de error
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Credenciales de inicio de sesión incorrectas'),
            ),
          );
        });
      }
    }
  }

  void _signup() async {
    if (_signupFormKey.currentState!.validate()) {
      // Realizar el registro
      print('Name: ${_nameSignupController.text}');
      print('Last Name: ${_lastNameSignupController.text}');
      print('Email: ${_emailSignupController.text}');
      print('Contraseña: ${_passwordSignupController.text}');

      final name = _nameSignupController.text;
      final lastName = _lastNameSignupController.text;
      final email = _emailSignupController.text;
      final password = _passwordSignupController.text;

      final url = Uri.parse('http://10.0.2.2:4000/api/register');
      final headers = {'Content-Type': 'application/json'};
      final body = json.encode({
        'username': email,
        'password': password,
        'name': name,
        'lastName': lastName,
      });

      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        // Si el servidor retornó 200 OK
        setState(() {
          //Vaciar los campos de registro
          _nameSignupController.text = "";
          _lastNameSignupController.text = "";
          _emailSignupController.text = "";
          _passwordSignupController.text = "";
          //Mostrar un mensaje de registro exitoso
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('La cuenta se ha creado exitosamente.'),
              duration: Duration(seconds: 4),
              action: SnackBarAction(
                label: 'x',
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              ),
            ),
          );
        });
      } else {
        // De lo contrario, throw exception
        setState(() {
          // Mostrar snackbar con mensaje de error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Hubo un error creando el usuario. Inténtelo nuevamente.'),
              duration: Duration(seconds: 4),
              action: SnackBarAction(
                label: 'x',
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              ),
            ),
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150),
        child: Container(
          height: 150,
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
          child: TabBar(
            indicatorColor: Color(0xFF5AAC69),
            indicatorWeight: 2,
            controller: _tabController,
            tabs: [
              Tab(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Inicio',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Tab(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Registro',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Form(
            key: _loginFormKey,
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 80.0, horizontal: 40.0),
              children: [
                TextFormField(
                  controller: _emailLoginController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Ingrese su correo...',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor digite su email';
                    }
                    if (!value.contains('@')) {
                      return 'Por favor digite un email válido';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordLoginController,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    hintText: 'Ingrese su contraseña...',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  obscureText: !_passwordVisible,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor digite su contraseña';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _login,
                      child: Text(
                        'Ingresar',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF5AAC69),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60.0),
                        ),
                        minimumSize: Size(150, 45),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Form(
            key: _signupFormKey,
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 80.0, horizontal: 40.0),
              children: [
                TextFormField(
                  controller: _nameSignupController,
                  decoration: InputDecoration(
                    labelText: 'Nombre',
                    hintText: 'Ingrese su nombre...',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor digite su nombre';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _lastNameSignupController,
                  decoration: InputDecoration(
                    labelText: 'Apellido',
                    hintText: 'Ingrese su apellido...',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor digite su apellido';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _emailSignupController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Ingrese su correo...',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor digite su email';
                    }
                    if (!value.contains('@')) {
                      return 'Por favor digite un email válido';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordSignupController,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    hintText: 'Ingrese su contraseña...',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  obscureText: !_passwordVisible,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor digite su contraseña';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 90),
                  child: ElevatedButton(
                    onPressed: _signup,
                    child: Text(
                      'Registrar',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold, // set the font weight to bold
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF5AAC69),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60.0),
                      ),
                      minimumSize: Size(double.infinity, 50),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//vista 2

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido!'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildBigButton(context, Icons.restaurant_menu, 'Order Food'),
            SizedBox(width: 16),
            _buildBigButton(context, Icons.people, 'Join a Group'),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.kitchen),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.people),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBigButton(BuildContext context, IconData icon, String label) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
    );
  }
}
