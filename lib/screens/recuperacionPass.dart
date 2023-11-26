// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// class ForgotPasswordPage extends StatefulWidget {
//   const ForgotPasswordPage({super.key});

//   @override
//   State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
// }

// class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

//     TextEditingController txtConUser = TextEditingController();

//   @override
//   void dispose() {
//     txtConUser.dispose();
//     super.dispose();
//   }

// Future passwordReset() async {
//   try {
//     await FirebaseAuth.instance
//       .sendPasswordResetEmail(email: txtConUser.text.trim());
//       showDialog(context: context, builder: (context){
//         return AlertDialog(
//           content: Text('Contraseña reiniciada. Revisa tu correo.'),
//         );
//       });
//   } on FirebaseAuthException catch (e) {
//     print(e);
//     showDialog(context: context, builder: (context){
//         return AlertDialog(
//           content: Text(e.message.toString()),
//         );
//       });
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(255, 0, 0, 0),
//         title: Text('Restablecer Contraseña', 
//         textAlign: TextAlign.center,),
//         elevation: 0,
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 25),
//             child: Text('Introduce tu correo', 
//             textAlign: TextAlign.center, 
//             style: TextStyle(fontSize: 20),
//             ),
//           ),
//           SizedBox(height: 10,),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 25.0),
//             child: TextField(
//                   enableInteractiveSelection: false,
//                   decoration: InputDecoration(
//                     hintText: 'Correo',
//                     labelText: 'Correo',
//                     suffix: Icon(
//                       Icons.verified_user
//                     ) ,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20.0)
//                     )
//                   ),
//                   controller: txtConUser,
//                 ),
//           ),
//           SizedBox(height: 10,),
//               MaterialButton(
//                 onPressed: passwordReset,
//                 child: Text('Restablecer contraseña'),
//           )
//         ],
//       ),
//     );
//   }
// }


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController txtConUser = TextEditingController();

  @override
  void dispose() {
    txtConUser.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: txtConUser.text.trim());
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Contraseña reiniciada. Revisa tu correo.'),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 36, 45, 60), // Fondo más oscuro
      appBar: AppBar(
        title: Text(
          'Restablecer Contraseña',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 36, 45, 60), // Fondo más oscuro
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Introduce tu correo',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            SizedBox(height: 10),
            TextField(
              enableInteractiveSelection: false,
              decoration: InputDecoration(
                hintText: 'Correo',
                labelText: 'Correo',
                suffix: Icon(Icons.verified_user, color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                hintStyle: TextStyle(color: Colors.white),
                labelStyle: TextStyle(color: Colors.white),
              ),
              controller: txtConUser,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: passwordReset,
              child: Text(
                'Restablecer contraseña',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 232, 76, 61), // Rojo más intenso
              ),
            ),
          ],
        ),
      ),
    );
  }
}
