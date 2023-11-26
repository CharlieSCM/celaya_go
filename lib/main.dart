// import 'package:celaya_go/screens/maps_screen.dart';
// import 'package:flutter/material.dart';
// //import 'package:celaya_go/routes.dart';
// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(

//       title: 'Celaya Go',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MapSample(),
//     );
//   }
// }

// import 'package:celaya_go/assets/global_values.dart';
// import 'package:celaya_go/screens/OnboardingScreen.dart';
// import 'package:celaya_go/screens/login_screen.dart';
// //import 'package:celaya_go/screens/maps_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:celaya_go/routes.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   FirebaseAuth.instance.authStateChanges();

//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

//   runApp(MyApp(isFirstTime: isFirstTime));
// }



// class MyApp extends StatelessWidget {
//   final bool isFirstTime;
//   @override
  
// void initState() {
//   super.initState();
//   globalValues().readValue();
// }

//   MyApp({required this.isFirstTime});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Celaya Go',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       //home: isFirstTime ? OnboardingPage() : MapSample(),
//       home: LoginScreen(),
//       routes: getRouters(),
//     );
//   }
// }



import 'package:celaya_go/routes.dart';
import 'package:celaya_go/screens/OnboardingScreen.dart';
import 'package:celaya_go/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../assets/global_values.dart';
import '../assets/styles_app.dart';
import 'package:celaya_go/firebase/notificaciones.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuth.instance.authStateChanges();
  await PushNotificationProvider().initializeApp();

  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    globalValues().readValue();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(

      valueListenable: globalValues.flagTheme, 
      builder: (context, value, _){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: OnboardingPage(), //LoginScreen(),
          routes: getRouters(),
          theme: value ? StylesApp.darkTheme(context) : StylesApp.lightTheme(context)
        );
      }
    );
  }
}