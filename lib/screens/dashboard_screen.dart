// import 'package:celaya_go/firebase/auth_with_google.dart';
// import 'package:celaya_go/models/firebase_user.dart';
// import 'package:flutter/material.dart';
// import 'package:day_night_switcher/day_night_switcher.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:celaya_go/assets/global_values.dart';
// //import 'maps_screen.dart';

// class DashboardScreen extends StatefulWidget {
//   DashboardScreen({super.key});

//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   void logout() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove('sessionSaved');
//     //Navigator.pushReplacementNamed(context, '/map');
//   }

//   final FirebaseUser _user = FirebaseUser();
//   final AuthServiceGoogle _auth = AuthServiceGoogle();

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _user.user = _auth.user;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Bienvenidos :)'),
//       ),
//       drawer: createDrawer(),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     );
//   }

//   Widget createDrawer() {
//     return Drawer(
//       child: ListView(
//         children: [
//           UserAccountsDrawerHeader(
//               currentAccountPicture: CircleAvatar(
//                 backgroundImage: _user.imageUrl != null
//                     ? NetworkImage(_user.imageUrl!)
//                     : NetworkImage('https://i.pravatar.cc/300'),
//               ),
//               accountName: _user.name != null
//                   ? Text(_user.name!)
//                   : Text('Buenas tardes'),
//               accountEmail: _user.email != null
//                   ? Text(_user.email!)
//                   : Text('Bienvenido')),
//           ListTile(
//             leading: Icon(Icons.map),
//             title: Text('Map'),
//             onTap: () => Navigator.pushNamed(context, '/map'),
//           ),
//           ListTile(
//             leading: Icon(Icons.airplanemode_active),
//             title: Text('Turismo'),
//             onTap: () => Navigator.pushNamed(context, '/turismo'),
//           ),
//           ListTile(
//             leading: Icon(Icons.question_mark),
//             title: Text('Por si algo mas se me ocurre'),
//             onTap: () => Navigator.pushNamed(context, '/turismo'),
//           ),
//           DayNightSwitcher(
//             isDarkModeEnabled: globalValues.flagTheme.value,
//             onStateChanged: (isDarkModeEnabled) {
//               globalValues.flagTheme.value = isDarkModeEnabled;
//               globalValues().saveValue(isDarkModeEnabled);
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.logout), // Ícono de cerrar sesión
//             title: Text('Cerrar sesión'),
//             onTap: () {
//               logout(); // Llama a la función logout al hacer clic en "Cerrar sesión"
//               _handleLogOut();
//               // _logoutFB();
//             },

//         )
//         ],
//       ),
//     );

//   }

// void _handleLogOut() async {
//   await _auth.signOutGoogle();
//   Navigator.pushReplacementNamed(context, '/logout');
//   setState(() {
//     _user.user = _auth.user;
//     Navigator.pushNamed(context, '/logout');
//   });
// }

// void _handleLogin() async {
//   await _auth.signInGoogle();
//   setState(() {
//     _user.user = _auth.user;
//   });
// }
// }
//version bbeta ttest

import 'package:celaya_go/firebase/auth_with_google.dart';
import 'package:celaya_go/models/firebase_user.dart';
import 'package:flutter/material.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:celaya_go/assets/global_values.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final FirebaseUser _user = FirebaseUser();
  final AuthServiceGoogle _auth = AuthServiceGoogle();

  List<String> imagePaths = [
    'assets/celaya_image.jpg',
    'assets/celaya_image1.jpg',
    'assets/celaya_image3.jpg',
    // Agrega más rutas de imágenes según sea necesario
  ];

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _user.user = _auth.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Celaya, Gto.'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Aquí puedes agregar el widget para el PageView
          Expanded(
            child: PageView.builder(
              itemCount: imagePaths.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return Image.asset(
                  imagePaths[index],
                  width: 500, // Ajusta el ancho según sea necesario
                  height: 500, // Ajusta la altura según sea necesario
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          Container(
            color: Colors.black, // Color de fondo negro
            padding: EdgeInsets.all(
                16.0), // Ajusta el espaciado interno según tus preferencias
            child: Text(
              'Celaya es una ciudad ubicada en el estado de Guanajuato, México. '
              'Con una rica historia y cultura, Celaya ofrece a sus visitantes '
              'una experiencia única. Explora sus calles llenas de encanto, '
              'disfruta de la gastronomía local y descubre la calidez de su gente.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white, // Color del texto
              ),
            ),
          ),
          // Indicadores de página
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              imagePaths.length,
              (index) => buildPageIndicator(index),
            ),
          ),
        ],
      ),
      drawer: createDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget buildPageIndicator(int index) {
    return Container(
      width: 8.0,
      height: 8.0,
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index
            ? const Color.fromARGB(255, 228, 14, 14)
            : Colors.grey,
      ),
    );
  }

  Widget createDrawer() {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: _user.imageUrl != null
                  ? NetworkImage(_user.imageUrl!)
                  : NetworkImage('https://i.pravatar.cc/300'),
            ),
            accountName:
                _user.name != null ? Text(_user.name!) : Text('Buenas tardes'),
            accountEmail:
                _user.email != null ? Text(_user.email!) : Text('Bienvenido'),
          ),
          ListTile(
            leading: Icon(Icons.map),
            title: Text('Map'),
            onTap: () => Navigator.pushNamed(context, '/map'),
          ),
          ListTile(
            leading: Icon(Icons.airplanemode_active),
            title: Text('Turismo'),
            onTap: () => Navigator.pushNamed(context, '/turismo'),
          ),
          ListTile(
            leading: Icon(Icons.ads_click_sharp),
            title: Text('Acerca de celaya'),
            onTap: () => Navigator.pushNamed(context, '/tradicion'),
          ),
          DayNightSwitcher(
            isDarkModeEnabled: globalValues.flagTheme.value,
            onStateChanged: (isDarkModeEnabled) {
              globalValues.flagTheme.value = isDarkModeEnabled;
              globalValues().saveValue(isDarkModeEnabled);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Cerrar sesión'),
            onTap: () {
              logout();
              _handleLogOut();
              // _logoutFB(); // Puedes dejarlo comentado si no se utiliza
            },
          ),
        ],
      ),
    );
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('sessionSaved');
  }

  void _handleLogOut() async {
    await _auth.signOutGoogle();
    Navigator.pushReplacementNamed(context, '/logout');
    setState(() {
      _user.user = _auth.user;
      Navigator.pushNamed(context, '/logout');
    });
  }

  void _handleLogin() async {
    await _auth.signInGoogle();
    setState(() {
      _user.user = _auth.user;
    });
  }
}
