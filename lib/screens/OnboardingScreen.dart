

// import 'package:flutter/material.dart';
// import 'package:celaya_go/screens/login_screen.dart';

// class OnboardingPage extends StatefulWidget {
//   @override
//   _OnboardingPageState createState() => _OnboardingPageState();
// }

// class _OnboardingPageState extends State<OnboardingPage> {
//   PageController _pageController = PageController();
//   int _currentPage = 0;

//   final List<Widget> onboardingPages = [
//     OnboardingCard(
//       title: "Bienvenido a Celaya Go",
//       subtitle: "Descubre la emoción de la ciudad ",
//       image: AssetImage('assets/celaya_guanajuato.jpg'),
//       color: Colors.blue,
//     ),
//     OnboardingCard(
//       title: "Explora Celaya",
//       subtitle:
//           "Celaya es conocida como la Puerta de Oro del Bajío y por sus deliciosos dulces",
//       image: AssetImage('assets/celaya_guanajuato2.jpg'),
//       color: Colors.pink, // Cambiado a rosado/morado
//     ),
//     OnboardingCard(
//       title: "¡Comienza a Navegar!",
//       subtitle: "Desliza para explorar",
//       image: AssetImage('assets/celaya_guanajuato3.jpg'),
//       color: Colors.orange, // Mismo color que el segundo
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView(
//         controller: _pageController,
//         onPageChanged: (int page) {
//           setState(() {
//             _currentPage = page;
//           });
//         },
//         children: onboardingPages,
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         icon: Icon(Icons.arrow_forward),
//         label: Text(_currentPage < onboardingPages.length - 1 ? 'Siguiente' : 'Comenzar'),
//         onPressed: () {
//           if (_currentPage < onboardingPages.length - 1) {
//             _pageController.nextPage(
//               duration: Duration(milliseconds: 500),
//               curve: Curves.easeInOut,
//             );
//           } else {
//             // Navegar a la pantalla principal después del onboarding
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => LoginScreen()),
//             );
//           }
//         },
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//     );
//   }
// }

// class OnboardingCard extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final ImageProvider image;
//   final Color color;

//   OnboardingCard({
//     required this.title,
//     required this.subtitle,
//     required this.image,
//     required this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [color.withOpacity(0.8), color.withOpacity(0.2)],
//         ),
//       ),
//       padding: EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           // Añadir animación de escala al título
//           TweenAnimationBuilder(
//             duration: Duration(milliseconds: 500),
//             tween: Tween<double>(begin: 0, end: 1),
//             builder: (BuildContext context, double value, Widget? child) {
//               return Transform.scale(
//                 scale: value,
//                 child: Text(
//                   title,
//                   style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
//                 ),
//               );
//             },
//           ),
//           SizedBox(height: 16.0),
//           Text(
//             subtitle,
//             style: TextStyle(fontSize: 18.0, color: Colors.white),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: 32.0),
//           ClipRRect(
//             borderRadius: BorderRadius.circular(20.0),
//             child: Image(
//               image: image,
//               width: double.infinity,
//               height: 300.0,
//               fit: BoxFit.cover,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:celaya_go/screens/login_screen.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  PageController _pageController = PageController();
  int _currentPage = 0;
  bool _onboardingCompleted = false;

  @override
  void initState() {
    super.initState();
    _loadOnboardingStatus();
  }

  _loadOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool onboardingCompleted = prefs.getBool('onboardingCompleted') ?? false;
    setState(() {
      _onboardingCompleted = onboardingCompleted;
    });
  }

  _saveOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingCompleted', true);
  }

  final List<Widget> onboardingPages = [
    OnboardingCard(
      title: "Bienvenido a Celaya Go",
      subtitle: "Descubre la emoción de la ciudad ",
      image: AssetImage('assets/celaya_guanajuato.jpg'),
      color: Colors.blue,
    ),
    OnboardingCard(
      title: "Explora Celaya",
      subtitle:
          "Celaya es conocida como la Puerta de Oro del Bajío y por sus deliciosos dulces",
      image: AssetImage('assets/celaya_guanajuato2.jpg'),
      color: Colors.pink, // Cambiado a rosado/morado
    ),
    OnboardingCard(
      title: "¡Comienza a Navegar!",
      subtitle: "Desliza para explorar",
      image: AssetImage('assets/celaya_guanajuato3.jpg'),
      color: Colors.orange, // Mismo color que el segundo
    ),
  ];

  @override
  Widget build(BuildContext context) {
    if (_onboardingCompleted) {
      return LoginScreen();
    }

    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        children: onboardingPages,
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.arrow_forward),
        label: Text(_currentPage < onboardingPages.length - 1 ? 'Siguiente' : 'Comenzar'),
        onPressed: () {
          if (_currentPage < onboardingPages.length - 1) {
            _pageController.nextPage(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          } else {
            _saveOnboardingStatus();
            setState(() {
              _onboardingCompleted = true;
            });

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class OnboardingCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final ImageProvider image;
  final Color color;

  OnboardingCard({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [color.withOpacity(0.8), color.withOpacity(0.2)],
        ),
      ),
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Añadir animación de escala al título
          TweenAnimationBuilder(
            duration: Duration(milliseconds: 500),
            tween: Tween<double>(begin: 0, end: 1),
            builder: (BuildContext context, double value, Widget? child) {
              return Transform.scale(
                scale: value,
                child: Text(
                  title,
                  style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
          SizedBox(height: 16.0),
          Text(
            subtitle,
            style: TextStyle(fontSize: 18.0, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              image: image,
              width: double.infinity,
              height: 300.0,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

