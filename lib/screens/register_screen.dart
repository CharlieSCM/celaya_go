// import 'package:flutter/material.dart';
// import 'package:celaya_go/screens/register_screen.dart';
// import 'package:celaya_go/firebase/email_auth.dart';

// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});

//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   final conNameUser = TextEditingController();
//   final conEmailUser = TextEditingController();
//   final conPwdUser = TextEditingController();
//   final emailAuth = EmailAuth();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Registrar Usuario')),
//       body: Column(children: [
//         TextFormField(
//           controller: conNameUser,
//         ),
//         TextFormField(
//           controller: conEmailUser,
//         ),
//         TextFormField(
//           controller: conPwdUser,
//         ),
//         ElevatedButton(
//             onPressed: () {
//               var email = conEmailUser.text;
//               var pwd = conPwdUser.text;
//               emailAuth.createUser(emailUser: email, pwdUser: pwd);
//             },
//             child: Text('Registrar Usuario'))
//       ]),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:celaya_go/firebase/email_auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final conNameUser = TextEditingController();
  final conEmailUser = TextEditingController();
  final conPwdUser = TextEditingController();
  final emailAuth = EmailAuth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 36, 45, 60), // Fondo más oscuro
      appBar: AppBar(
        title: Text(
          'Registrar Usuario',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 36, 45, 60), // Fondo más oscuro
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: conNameUser,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Nombre de Usuario',
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: conEmailUser,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Correo Electrónico',
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: conPwdUser,
              style: TextStyle(color: Colors.white),
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                var email = conEmailUser.text;
                var pwd = conPwdUser.text;
                emailAuth.createUser(emailUser: email, pwdUser: pwd);
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 232, 76, 61), // Rojo más intenso
              ),
              child: Text('Registrar Usuario'),
            ),
          ],
        ),
      ),
    );
  }
}

