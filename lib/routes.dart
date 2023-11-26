import 'package:celaya_go/screens/OnboardingScreen.dart';
import 'package:celaya_go/screens/dashboard_screen.dart';
import 'package:celaya_go/screens/login_screen.dart';
import 'package:celaya_go/screens/register_screen.dart';
import 'package:celaya_go/screens/tradicion.dart';
import 'package:flutter/widgets.dart';
import 'package:celaya_go/screens/maps_screen.dart';
import 'package:celaya_go/screens/turismo_screen.dart';

Map<String, WidgetBuilder> getRouters() {
  return {
    '/map': (BuildContext context) => const MapSample(),
    '/turismo': (BuildContext context) => TurismoScreen(),
    '/onboar': (BuildContext context) => OnboardingPage(),
    '/dash': (BuildContext context) => DashboardScreen(),
    '/logout': (BuildContext context) => LoginScreen(),
    '/register': (BuildContext context) => RegisterScreen(),
    '/tradicion': (BuildContext context) => CelayaInfoScreen(),
    //'/namerout' : (BuildContext context) => classname(),
    //'/namerout' : (BuildContext context) => classname(),
    //'/namerout' : (BuildContext context) => classname(),
  };
}
