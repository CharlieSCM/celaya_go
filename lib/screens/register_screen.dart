
import 'package:flutter/material.dart';
import 'package:celaya_go/firebase/email_auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final conNameUser = TextEditingController();
  final conEmailUser = TextEditingController();
  final conPwdUser = TextEditingController();
  final emailAuth = EmailAuth();

  String errorMessage = '';

  // Función para mostrar una ventana emergente
  Future<void> _showDialog(String message) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Mensaje'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 36, 45, 60),
      appBar: AppBar(
        title: Text(
          'Registrar Usuario',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 36, 45, 60),
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
            Text(
              errorMessage,
              style: TextStyle(color: Colors.red),
            ),
            ElevatedButton(
              onPressed: () async {
                if (conNameUser.text.isNotEmpty &&
                    conEmailUser.text.isNotEmpty &&
                    conPwdUser.text.isNotEmpty) {
                  // Todos los campos están llenos
                  var email = conEmailUser.text;
                  var pwd = conPwdUser.text;
                  emailAuth.createUser(emailUser: email, pwdUser: pwd);

                  // Muestra la ventana emergente con el mensaje de verificación
                  await _showDialog('Verifique su correo por favor.');

                } else {
                  // Al menos un campo está vacío
                  setState(() {
                    errorMessage = 'Llene el formulario.';
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 232, 76, 61),
              ),
              child: Text('Registrar Usuario'),
            ),
          ],
        ),
      ),
    );
  }
}
