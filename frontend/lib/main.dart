import 'package:flutter/material.dart';

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

  void _login() {
    if (_loginFormKey.currentState!.validate()) {
      // Perform login actions
      print('Email: ${_emailLoginController.text}');
      print('Contraseña: ${_passwordLoginController.text}');
    }
  }

  void _signup() {
    if (_signupFormKey.currentState!.validate()) {
      // Perform sign-up actions
      print('Name: ${_nameSignupController.text}');
      print('Last Name: ${_lastNameSignupController.text}');
      print('Email: ${_emailSignupController.text}');
      print('Contraseña: ${_passwordSignupController.text}');
    }

    void _forgotPassword() {}
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
                    TextButton(
                      onPressed: () => {},
                      child: Text(
                        'Restaurar contraseña',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => {},
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
                    onPressed: () => {},
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
