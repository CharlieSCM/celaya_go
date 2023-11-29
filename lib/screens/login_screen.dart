import 'package:auto_size_text/auto_size_text.dart';
import 'package:celaya_go/firebase/auth_with_google.dart';
import 'package:celaya_go/firebase/email_auth.dart';
import 'package:celaya_go/models/firebase_user.dart';
import 'package:celaya_go/screens/recuperacionPass.dart';
import 'package:flutter/material.dart';
import 'package:github_sign_in_plus/github_sign_in_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailAuth = new EmailAuth();
  bool isSessionSaved = false;
  bool _checking = false;
  final FirebaseUser _user = FirebaseUser();
  final AuthServiceGoogle _auth = AuthServiceGoogle();
  AccessToken? _accessToken;
  Map<String, dynamic>? _userData;

  @override
  void initState() {
    super.initState();
    checkSavedSession();
    _user.user = _auth.user;
  }

  ElevatedButton _loginFB() {
    return ElevatedButton.icon(
      icon: Icon(Icons.login),
      label: Text('Sign with Facebook'),
      onPressed: () async {
        final LoginResult result = await FacebookAuth.instance.login();
        if (result.status == LoginStatus.success) {
          _accessToken = result.accessToken;
          final userData = await FacebookAuth.instance.getUserData();
          _userData = _userData;
        } else {
          print(result.status);
          print(result.message);
        }
        setState(() {
          _checking = false;
          Navigator.pushNamed(context, '/dash');
        });
      },
    );
  }

  void checkSavedSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = await FacebookAuth.instance.accessToken;
    setState(() {
      _checking = false;
    });
    if (accessToken != null) {
      print(accessToken.toJson());
      final userData = await FacebookAuth.instance.getUserData();
      _accessToken = accessToken;
      setState(() {
        _userData = userData;
      });
    } else {
      _loginFB();
    }
    bool? sessionSaved = prefs.getBool('sessionSaved');
    if (sessionSaved != null && sessionSaved) {
      Navigator.pushReplacementNamed(context, '/dash');
    }
  }

  void saveSession(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('sessionSaved', value);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController txtConUser = TextEditingController();
    TextEditingController txtConPass = TextEditingController();

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 36, 45, 60),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20),
                Text(
                  'CELAYA_GO',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Anton',
                  ),
                ),
                SizedBox(height: 20),
                CircleAvatar(
                  radius: 80.0,
                  backgroundColor: Color.fromARGB(0, 226, 219, 219),
                  backgroundImage: AssetImage('assets/celaya_image2.jpg'),
                ),
                SizedBox(height: 20),
                Text(
                  'Iniciar sesion',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'DM Serif Display',
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  enableInteractiveSelection: false,
                  style: TextStyle(color: const Color.fromARGB(255, 10, 10, 10)),
                  decoration: InputDecoration(
                    hintText: 'Correo',
                    labelText: 'Correo',
                    fillColor: Color.fromARGB(255, 238, 230, 230),
                    filled: true,
                    suffixIcon: Icon(Icons.admin_panel_settings_outlined,
                        color: const Color.fromARGB(255, 34, 27, 27)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  controller: txtConUser,
                ),
                SizedBox(height: 20),
                TextField(
                  enableInteractiveSelection: false,
                  style: TextStyle(color: Color.fromARGB(255, 46, 45, 45)),
                  decoration: InputDecoration(
                    hintText: 'Contraseña',
                    labelText: 'Contraseña',
                    suffixIcon: Icon(Icons.password,
                        color: Color.fromARGB(255, 40, 40, 40)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Color.fromARGB(255, 238, 230, 230),
                  ),
                  controller: txtConPass,
                  obscureText: true,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ForgotPasswordPage();
                              },
                            ),
                          );
                        },
                        child: AutoSizeText(
                          '¿Olvidaste tu contraseña?',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/register'),
                  child: Text(
                    '¿No tienes una cuenta? Regístrate',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await _auth.signInGoogle();
                        setState(() {
                          _user.user = _auth.user;
                          Navigator.pushNamed(context, '/dash');
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(
                            255, 232, 76, 61),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.sports_esports),
                          SizedBox(width: 8),
                          Text('Sign in with Google'),
                        ],
                      ),
                    ),
                    SignInButton(
                      Buttons.gitHub,
                      text: 'Inicia Sesión con GitHub',
                      onPressed: () async {
                        _gitHubSignIn(context);
                      },
                    ),
                    SizedBox(height: 20),
                    FloatingActionButton.extended(
                      icon: Icon(Icons.login),
                      label: Text('Entrar'),
                      backgroundColor: Colors.purple,
                      onPressed: () async {
                        bool res = await emailAuth.validateUser(
                          emailUser: txtConUser.text,
                          pwdUser: txtConPass.text,
                        );
                        if (txtConUser != null && txtConPass != null) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  'Error \n - Error campos vacíos \n - Correo o Contraseña Incorrectos',
                                  style: TextStyle(fontSize: 16),
                                ),
                                icon: Icon(Icons.warning),
                                actions: [
                                  Align(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Aceptar'),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                        if (res) {
                          Navigator.pushNamed(context, '/dash');
                          saveSession(isSessionSaved);
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    _loginFB(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final GitHubSignIn gitHubSignIn = GitHubSignIn(
    clientId: 'ecb6060196d0df87f774',
    clientSecret: 'ea089057da1507402c3e272f6174c66ee89bfcd6',
    redirectUrl: 'https://appcelaya-bd745.firebaseapp.com/__/auth/handler',
    title: 'GitHub Connection',
    centerTitle: false,
  );

  void _gitHubSignIn(BuildContext context) async {
    var result = await gitHubSignIn.signIn(context);
    switch (result.status) {
      case GitHubSignInResultStatus.ok:
        Navigator.pushNamed(context, '/dash');
        break;

      case GitHubSignInResultStatus.cancelled:
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Un error ha ocurrido'),
              content: Text('Error de autenticación con GitHub'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            );
          },
        );
        break;
      case GitHubSignInResultStatus.failed:
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Un error ha ocurrido'),
              content: Text('Error de autenticación con GitHub'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            );
          },
        );
        break;
    }
  }
  _logoutFB() async{
    await FacebookAuth.instance.logOut();
    _accessToken = null;
    _userData = null;
    setState(() {
    });
  }
}


// hasta aqui jalaba
/*
import 'package:auto_size_text/auto_size_text.dart';
import 'package:celaya_go/firebase/auth_with_google.dart';
import 'package:celaya_go/firebase/email_auth.dart';
import 'package:celaya_go/models/firebase_user.dart';
import 'package:celaya_go/screens/recuperacionPass.dart';
import 'package:flutter/material.dart';
import 'package:github_sign_in_plus/github_sign_in_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailAuth = new EmailAuth();
  bool isSessionSaved = false;
  bool _checking = false;
  final FirebaseUser _user = FirebaseUser();
  final AuthServiceGoogle _auth = AuthServiceGoogle();
  AccessToken? _accessToken;
  Map<String, dynamic>? _userData;

  @override
  void initState() {
    super.initState();
    checkSavedSession();
    _user.user = _auth.user;
  }

  void checkSavedSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = await FacebookAuth.instance.accessToken;
    setState(() {
      _checking = false;
    });
    if(accessToken != null){
      print(accessToken.toJson());
      final userData = await FacebookAuth.instance.getUserData();
      _accessToken = accessToken;
      setState(() {
        _userData = userData;
      });
    }else{
      _loginFB();
    }
    bool? sessionSaved = prefs.getBool('sessionSaved');
    if (sessionSaved != null && sessionSaved) {
      Navigator.pushReplacementNamed(context, '/dash');
    }
  }

  void saveSession(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('sessionSaved', value);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController txtConUser = TextEditingController();
    TextEditingController txtConPass = TextEditingController();

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 36, 45, 60), // Fondo más oscuro
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20),
                Text(
                  'CELAYA_GO',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily:
                        'Anton', // Nombre de la fuente sin la extensión del archivo
                  ),
                ),
                SizedBox(height: 20),
                CircleAvatar(
                  radius: 80.0,
                  backgroundColor: Color.fromARGB(0, 226, 219, 219),
                  backgroundImage: AssetImage('assets/celaya_image2.jpg'),
                ),
                SizedBox(height: 20),
                Text(
                  'Iniciar sesion',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily:
                        'DM Serif Display', // Nombre de la fuente sin la extensión del archivo
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  enableInteractiveSelection: false,
                  style:
                      TextStyle(color: const Color.fromARGB(255, 10, 10, 10)),
                  decoration: InputDecoration(
                    hintText: 'Correo',
                    labelText: 'Correo',
                    fillColor: Color.fromARGB(255, 238, 230, 230),
                    filled: true,
                    suffixIcon: Icon(Icons.admin_panel_settings_outlined,
                        color: const Color.fromARGB(255, 34, 27, 27)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  controller: txtConUser,
                ),
                SizedBox(height: 20),
                TextField(
                  enableInteractiveSelection: false,
                  style: TextStyle(color: Color.fromARGB(255, 46, 45, 45)),
                  decoration: InputDecoration(
                    hintText: 'Contraseña',
                    labelText: 'Contraseña',
                    suffixIcon: Icon(Icons.password,
                        color: Color.fromARGB(255, 40, 40, 40)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Color.fromARGB(255, 238, 230, 230),
                  ),
                  controller: txtConPass,
                  obscureText: true,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 50.0), // Adjusted horizontal padding
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.start, // Aligned text to the left
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ForgotPasswordPage();
                              },
                            ),
                          );
                        },
                        child: AutoSizeText(
                          '¿Olvidaste tu contraseña?',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/register'),
                  child: Text(
                    '¿No tienes una cuenta? Regístrate',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await _auth.signInGoogle();
                        setState(() {
                          _user.user = _auth.user;
                          Navigator.pushNamed(context, '/dash');
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(
                            255, 232, 76, 61), // Rojo más intenso
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.sports_esports),
                          SizedBox(width: 8),
                          Text('Sign in with Google'),
                        ],
                      ),
                    ),
                    SignInButton(
                      Buttons.gitHub,
                      text: 'Inicia Sesión con GitHub',
                      onPressed: () async {
                        _gitHubSignIn(context);
                      },
                    ),
                    SizedBox(height: 20),
                    FloatingActionButton.extended(
                      icon: Icon(Icons.login),
                      label: Text('Entrar'),
                      backgroundColor: Colors.purple, // Cambiar a color morado
                      onPressed: () async {
                        bool res = await emailAuth.validateUser(
                          emailUser: txtConUser.text,
                          pwdUser: txtConPass.text,
                        );
                        if (txtConUser != null && txtConPass != null) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  'Error \n - Los campos no pueden estar vacíos \n - Correo o Contraseña Incorrectos',
                                  style: TextStyle(fontSize: 16),
                                ),
                                icon: Icon(Icons.warning),
                                actions: [
                                  Align(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Aceptar'),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                        if (res) {
                          Navigator.pushNamed(context, '/dash');
                          saveSession(isSessionSaved);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final GitHubSignIn gitHubSignIn = GitHubSignIn(
    clientId: 'ecb6060196d0df87f774',
    clientSecret: 'ea089057da1507402c3e272f6174c66ee89bfcd6',
    redirectUrl: 'https://appcelaya-bd745.firebaseapp.com/__/auth/handler',
    title: 'GitHub Connection',
    centerTitle: false,
  );

  void _gitHubSignIn(BuildContext context) async {
    var result = await gitHubSignIn.signIn(context);
    switch (result.status) {
      case GitHubSignInResultStatus.ok:
        Navigator.pushNamed(context, '/dash');
        break;

      case GitHubSignInResultStatus.cancelled:
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Un error ha ocurrido'),
              content: Text('Error de autenticación con GitHub'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.black, // Cambia el color a negro
                    ),
                  ),
                ),
              ],
            );
          },
        );
        break;
      case GitHubSignInResultStatus.failed:
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Un error ha ocurrido'),
              content: Text('Error de autenticación con GitHub'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.black, // Cambia el color a negro
                    ),
                  ),
                ),
              ],
            );
          },
        );
        break;
    }
  }
}*/
