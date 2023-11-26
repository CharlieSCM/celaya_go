// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';

// class TurismoScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Celaya Guanajuato'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             _buildSection('Lugares Turísticos', [
//               _buildCarouselSlider([
//                 {
//                   'image': 'assets/image1.jpeg',
//                   'description': 'La bola del agua'
//                 },
//                 {'image': 'assets/image2.jpeg', 'description': 'Jardin'},
//                 {'image': 'assets/image3.jpeg', 'description': 'Museo'},
//                 {'image': 'assets/image4.jpeg', 'description': 'Estadio'},
//               ]),
//             ]),
//             _buildSection('Hoteles', [
//               _buildCarouselSlider([
//                 {
//                   'image': 'assets/image9.jpeg',
//                   'description': 'Hotel Mary 4 Estrellas'
//                 },
//                 {
//                   'image': 'assets/image10.jpg',
//                   'description': 'Casa Inn Celaya Veleros 4 Estrellas'
//                 },
//                 {
//                   'image': 'assets/image11.jpg',
//                   'description': 'Candlewood Suites Celaya 4 Estrellas '
//                 },
//                 {
//                   'image': 'assets/image12.jpg',
//                   'description': 'St George Hotel 5 Estrellas'
//                 },
//               ]),
//             ]),
//             _buildSection('Restaurantes', [
//               _buildCarouselSlider([
//                 {
//                   'image': 'assets/image13.jpg',
//                   'description': 'Restaurant Ikal'
//                 },
//                 {
//                   'image': 'assets/image14.jpeg',
//                   'description': 'Barra Galera'
//                 },
//                 {
//                   'image': 'assets/image15.jpg',
//                   'description': 'Fogon do Brasil'
//                 },
//                 {
//                   'image': 'assets/image16.jpg',
//                   'description': 'Mezzé'
//                 },
//               ]),
//             ]),
//             _buildSection('Lugares no Seguros', [
//               _buildCarouselSlider([
//                 {
//                   'image': 'assets/image5.jpeg',
//                   'description': 'Chino/Sticker-Man House'
//                 },
//                 {
//                   'image': 'assets/image6.jpeg',
//                   'description': 'Emiliano Zapata'
//                 },
//                 {
//                   'image': 'assets/image7.jpeg',
//                   'description': 'Hacienda del bosque'
//                 },
//                 {
//                   'image': 'assets/image8.jpeg',
//                   'description': 'Las insurgentes'
//                 },
//               ]),
//             ]),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSection(String title, List<Widget> content) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             title,
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//         ),
//         ...content,
//       ],
//     );
//   }

//   Widget _buildCarouselSlider(List<Map<String, String>> images) {
//     return CarouselSlider(
//       options: CarouselOptions(
//         height: 200,
//         enlargeCenterPage: true,
//         autoPlay: true,
//         aspectRatio: 16 / 9,
//         autoPlayCurve: Curves.fastOutSlowIn,
//         enableInfiniteScroll: true,
//         autoPlayAnimationDuration: Duration(milliseconds: 800),
//         viewportFraction: 0.8,
//       ),
//       items: images.map((image) {
//         return Builder(
//           builder: (BuildContext context) {
//             return GestureDetector(
//               onTap: () {
//                 _showDescriptionDialog(
//                     context, image['description'] ?? 'Sin descripción');
//               },
//               child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 margin: EdgeInsets.symmetric(horizontal: 5.0),
//                 decoration: BoxDecoration(
//                   color: Colors.grey,
//                   borderRadius: BorderRadius.circular(8.0),
//                   image: DecorationImage(
//                     image: AssetImage(image['image'] ?? ''),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       }).toList(),
//     );
//   }

//   Future<void> _showDescriptionDialog(
//       BuildContext context, String description) async {
//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Descripción'),
//           content: Text(description),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: TurismoScreen(),
//   ));
// }

// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class TurismoScreen extends StatelessWidget {
//   final List<Map<String, String>> lugares = [
//     {'image': 'assets/image1.jpeg', 'description': 'La bola del agua', 'latitude': '19.4319', 'longitude': '-99.1332'},
//     // Agrega la información de longitud y latitud para cada lugar
//     // ...
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Celaya Guanajuato'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             _buildSection('Lugares Turísticos', [
//               _buildCarouselSlider(lugares),
//             ]),
//             // Agrega secciones para Hoteles, Restaurantes, y Lugares no Seguros
//             // ...
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSection(String title, List<Widget> content) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             title,
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//         ),
//         ...content,
//       ],
//     );
//   }

//   Widget _buildCarouselSlider(List<Map<String, String>> lugares) {
//     return CarouselSlider(
//       options: CarouselOptions(
//         height: 200,
//         enlargeCenterPage: true,
//         autoPlay: true,
//         aspectRatio: 16 / 9,
//         autoPlayCurve: Curves.fastOutSlowIn,
//         enableInfiniteScroll: true,
//         autoPlayAnimationDuration: Duration(milliseconds: 800),
//         viewportFraction: 0.8,
//       ),
//       items: lugares.map((lugar) {
//         return Builder(
//           builder: (BuildContext context) {
//             return GestureDetector(
//               onTap: () {
//                 _showDescriptionDialog(context, lugar);
//               },
//               child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 margin: EdgeInsets.symmetric(horizontal: 5.0),
//                 decoration: BoxDecoration(
//                   color: Colors.grey,
//                   borderRadius: BorderRadius.circular(8.0),
//                   image: DecorationImage(
//                     image: AssetImage(lugar['image'] ?? ''),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       }).toList(),
//     );
//   }

//   Future<void> _showDescriptionDialog(
//       BuildContext context, Map<String, String> lugar) async {
//     final LatLng location = LatLng(
//       double.parse(lugar['latitude'] ?? '0.0'),
//       double.parse(lugar['longitude'] ?? '0.0'),
//     );

//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Descripción'),
//           content: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Nombre: ${lugar['description']}'),
//               Text('Latitud: ${lugar['latitude']}'),
//               Text('Longitud: ${lugar['longitude']}'),
//               SizedBox(height: 10),
//               Container(
//                 height: 200,
//                 child: GoogleMap(
//                   initialCameraPosition: CameraPosition(
//                     target: location,
//                     zoom: 15.0,
//                   ),
//                   markers: {
//                     Marker(
//                       markerId: MarkerId('Lugar'),
//                       position: location,
//                     ),
//                   },
//                 ),
//               ),
//             ],
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: TurismoScreen(),
//   ));
// }

///DE ABAJO JALA Y DE ARRIBA ES LO ANTERIOR

// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class TurismoScreen extends StatelessWidget {
//   final List<Map<String, String>> lugares = [
//     {'image': 'assets/image1.jpeg', 'description': 'La bola del agua', 'latitude': '19.4319', 'longitude': '-99.1332'},
//     {'image': 'assets/image2.jpeg', 'description': 'Jardin', 'latitude': '19.4319', 'longitude': '-99.1332'},
//     // Agrega la información de longitud y latitud para cada lugar
//     // ...
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Celaya Guanajuato'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             _buildSection('Lugares Turísticos', [
//               _buildCarouselSlider(lugares),
//             ]),
//             _buildSection('Hoteles', [
//               _buildCarouselSlider([
//                 {
//                   'image': 'assets/image9.jpeg',
//                   'description': 'Hotel Mary 4 Estrellas',
//                   'latitude': '19.4215',
//                   'longitude': '-99.1565',
//                 },
//                 {
//                   'image': 'assets/image10.jpg',
//                   'description': 'Casa Inn Celaya Veleros 4 Estrellas',
//                   'latitude': '19.4353',
//                   'longitude': '-99.1290',
//                 },
//                 {
//                   'image': 'assets/image11.jpg',
//                   'description': 'Candlewood Suites Celaya 4 Estrellas',
//                   'latitude': '19.4160',
//                   'longitude': '-99.1385',
//                 },
//                 {
//                   'image': 'assets/image12.jpg',
//                   'description': 'St George Hotel 5 Estrellas',
//                   'latitude': '19.4289',
//                   'longitude': '-99.1285',
//                 },
//               ]),
//             ]),
//             _buildSection('Restaurantes', [
//               _buildCarouselSlider([
//                 {
//                   'image': 'assets/image13.jpg',
//                   'description': 'Restaurant Ikal',
//                   'latitude': '19.4293',
//                   'longitude': '-99.1332',
//                 },
//                 {
//                   'image': 'assets/image14.jpeg',
//                   'description': 'Barra Galera',
//                   'latitude': '19.4274',
//                   'longitude': '-99.1333',
//                 },
//                 {
//                   'image': 'assets/image15.jpg',
//                   'description': 'Fogon do Brasil',
//                   'latitude': '19.4263',
//                   'longitude': '-99.1341',
//                 },
//                 {
//                   'image': 'assets/image16.jpg',
//                   'description': 'Mezzé',
//                   'latitude': '19.4243',
//                   'longitude': '-99.1319',
//                 },
//               ]),
//             ]),
//             _buildSection('Lugares no Seguros', [
//               _buildCarouselSlider([
//                 {
//                   'image': 'assets/image5.jpeg',
//                   'description': 'Chino/Sticker-Man House',
//                   'latitude': '19.4260',
//                   'longitude': '-99.1361',
//                 },
//                 {
//                   'image': 'assets/image6.jpeg',
//                   'description': 'Emiliano Zapata',
//                   'latitude': '19.4301',
//                   'longitude': '-99.1318',
//                 },
//                 {
//                   'image': 'assets/image7.jpeg',
//                   'description': 'Hacienda del bosque',
//                   'latitude': '19.4257',
//                   'longitude': '-99.1356',
//                 },
//                 {
//                   'image': 'assets/image8.jpeg',
//                   'description': 'Las insurgentes',
//                   'latitude': '19.4269',
//                   'longitude': '-99.1312',
//                 },
//               ]),
//             ]),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSection(String title, List<Widget> content) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             title,
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//         ),
//         ...content,
//       ],
//     );
//   }

//   Widget _buildCarouselSlider(List<Map<String, String>> lugares) {
//     return CarouselSlider(
//       options: CarouselOptions(
//         height: 200,
//         enlargeCenterPage: true,
//         autoPlay: true,
//         aspectRatio: 16 / 9,
//         autoPlayCurve: Curves.fastOutSlowIn,
//         enableInfiniteScroll: true,
//         autoPlayAnimationDuration: Duration(milliseconds: 800),
//         viewportFraction: 0.8,
//       ),
//       items: lugares.map((lugar) {
//         return Builder(
//           builder: (BuildContext context) {
//             return GestureDetector(
//               onTap: () {
//                 _showDescriptionDialog(context, lugar);
//               },
//               child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 margin: EdgeInsets.symmetric(horizontal: 5.0),
//                 decoration: BoxDecoration(
//                   color: Colors.grey,
//                   borderRadius: BorderRadius.circular(8.0),
//                   image: DecorationImage(
//                     image: AssetImage(lugar['image'] ?? ''),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       }).toList(),
//     );
//   }

//   Future<void> _showDescriptionDialog(
//       BuildContext context, Map<String, String> lugar) async {
//     final LatLng location = LatLng(
//       double.parse(lugar['latitude'] ?? '0.0'),
//       double.parse(lugar['longitude'] ?? '0.0'),
//     );

//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Descripción'),
//           content: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Nombre: ${lugar['description']}'),
//               Text('Latitud: ${lugar['latitude']}'),
//               Text('Longitud: ${lugar['longitude']}'),
//               SizedBox(height: 10),
//               Container(
//                 height: 200,
//                 child: GoogleMap(
//                   initialCameraPosition: CameraPosition(
//                     target: location,
//                     zoom: 15.0,
//                   ),
//                   markers: {
//                     Marker(
//                       markerId: MarkerId('Lugar'),
//                       position: location,
//                     ),
//                   },
//                 ),
//               ),
//             ],
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: TurismoScreen(),
//   ));
// }

//PIOLA ESTE DEJAR SI LO DEMAS SE CORROMPE

// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class TurismoScreen extends StatelessWidget {
//   final List<Map<String, String>> lugares = [
//     {'image': 'assets/image1.jpeg', 'description': 'La bola del agua', 'latitude': '19.4319', 'longitude': '-99.1332'},
//     {'image': 'assets/image2.jpeg', 'description': 'Jardin', 'latitude': '19.4319', 'longitude': '-99.1332'},
//     // Agrega la información de longitud y latitud para cada lugar
//     // ...
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Celaya Guanajuato'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             _buildSection('Lugares Turísticos', [
//               _buildCarouselSlider(lugares),
//             ]),
//             _buildSection('Hoteles', [
//               _buildCarouselSlider([
//                 {
//                   'image': 'assets/image9.jpeg',
//                   'description': 'Hotel Mary 4 Estrellas',
//                   'latitude': '19.4215',
//                   'longitude': '-99.1565',
//                 },
//                 {
//                   'image': 'assets/image10.jpg',
//                   'description': 'Casa Inn Celaya Veleros 4 Estrellas',
//                   'latitude': '19.4353',
//                   'longitude': '-99.1290',
//                 },
//                 {
//                   'image': 'assets/image11.jpg',
//                   'description': 'Candlewood Suites Celaya 4 Estrellas',
//                   'latitude': '19.4160',
//                   'longitude': '-99.1385',
//                 },
//                 {
//                   'image': 'assets/image12.jpg',
//                   'description': 'St George Hotel 5 Estrellas',
//                   'latitude': '19.4289',
//                   'longitude': '-99.1285',
//                 },
//               ]),
//             ]),
//             _buildSection('Restaurantes', [
//               _buildCarouselSlider([
//                 {
//                   'image': 'assets/image13.jpg',
//                   'description': 'Restaurant Ikal',
//                   'latitude': '19.4293',
//                   'longitude': '-99.1332',
//                 },
//                 {
//                   'image': 'assets/image14.jpeg',
//                   'description': 'Barra Galera',
//                   'latitude': '19.4274',
//                   'longitude': '-99.1333',
//                 },
//                 {
//                   'image': 'assets/image15.jpg',
//                   'description': 'Fogon do Brasil',
//                   'latitude': '19.4263',
//                   'longitude': '-99.1341',
//                 },
//                 {
//                   'image': 'assets/image16.jpg',
//                   'description': 'Mezzé',
//                   'latitude': '19.4243',
//                   'longitude': '-99.1319',
//                 },
//               ]),
//             ]),
//             _buildSection('Lugares no Seguros', [
//               _buildCarouselSlider([
//                 {
//                   'image': 'assets/image5.jpeg',
//                   'description': 'Chino/Sticker-Man House',
//                   'latitude': '19.4260',
//                   'longitude': '-99.1361',
//                 },
//                 {
//                   'image': 'assets/image6.jpeg',
//                   'description': 'Emiliano Zapata',
//                   'latitude': '19.4301',
//                   'longitude': '-99.1318',
//                 },
//                 {
//                   'image': 'assets/image7.jpeg',
//                   'description': 'Hacienda del bosque',
//                   'latitude': '19.4257',
//                   'longitude': '-99.1356',
//                 },
//                 {
//                   'image': 'assets/image8.jpeg',
//                   'description': 'Las insurgentes',
//                   'latitude': '19.4269',
//                   'longitude': '-99.1312',
//                 },
//               ]),
//             ]),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSection(String title, List<Widget> content) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             title,
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//         ),
//         ...content,
//       ],
//     );
//   }

//   Widget _buildCarouselSlider(List<Map<String, String>> lugares) {
//     return CarouselSlider(
//       options: CarouselOptions(
//         height: 200,
//         enlargeCenterPage: true,
//         autoPlay: true,
//         aspectRatio: 16 / 9,
//         autoPlayCurve: Curves.fastOutSlowIn,
//         enableInfiniteScroll: true,
//         autoPlayAnimationDuration: Duration(milliseconds: 800),
//         viewportFraction: 0.8,
//       ),
//       items: lugares.map((lugar) {
//         return Builder(
//           builder: (BuildContext context) {
//             return GestureDetector(
//               onTap: () {
//                 _showDescriptionDialog(context, lugar);
//               },
//               child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 margin: EdgeInsets.symmetric(horizontal: 5.0),
//                 decoration: BoxDecoration(
//                   color: Colors.grey,
//                   borderRadius: BorderRadius.circular(8.0),
//                   image: DecorationImage(
//                     image: AssetImage(lugar['image'] ?? ''),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       }).toList(),
//     );
//   }

//   Future<void> _showDescriptionDialog(
//       BuildContext context, Map<String, String> lugar) async {
//     final LatLng location = LatLng(
//       double.parse(lugar['latitude'] ?? '0.0'),
//       double.parse(lugar['longitude'] ?? '0.0'),
//     );

//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Descripción'),
//           content: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Nombre: ${lugar['description']}'),
//               Text('Latitud: ${lugar['latitude']}'),
//               Text('Longitud: ${lugar['longitude']}'),
//               SizedBox(height: 10),
//               Container(
//                 height: 150, // Ajusta la altura del mapa aquí
//                 child: GoogleMap(
//                   initialCameraPosition: CameraPosition(
//                     target: location,
//                     zoom: 15.0,
//                   ),
//                   markers: {
//                     Marker(
//                       markerId: MarkerId('Lugar'),
//                       position: location,
//                     ),
//                   },
//                 ),
//               ),
//             ],
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: TurismoScreen(),
//   ));
// }

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class TurismoScreen extends StatelessWidget {
  final List<Map<String, String>> lugares = [
    {
      'image': 'assets/image1.jpeg',
      'description': 'La bola del agua',
      'latitude': '20.52206199227398',
      'longitude': '-100.8120920932067'
    },
    {
      'image': 'assets/image2.jpeg',
      'description': 'Jardin Principal',
      'latitude': '20.522024043414902',
      'longitude': '-100.81412551534389'
    },
    {
      'image': 'assets/image3.jpeg',
      'description': 'Museo de momias',
      'latitude': '20.533422314222786',
      'longitude': '-100.81959184901955'
    },
    {
      'image': 'assets/image4.jpeg',
      'description': 'Estadio del Celaya',
      'latitude': '20.535318422821774',
      'longitude': '-100.81827164902633'
    },
    // Agrega la información de longitud y latitud para cada lugar 20.52206199227398, -100.8120920932067
    // ...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Celaya Guanajuato'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSection('Lugares Turísticos', [
              _buildCarouselSlider(lugares),
            ]),
            _buildSection('Hoteles', [
              _buildCarouselSlider([
                {
                  'image': 'assets/image9.jpeg',
                  'description': 'Hotel Mary 4 Estrellas',
                  'latitude': '20.519643638332564 ',
                  'longitude': '-100.81459688652168',
                },
                {
                  'image': 'assets/image10.jpg',
                  'description': 'Casa Inn Celaya Veleros 4 Estrellas',
                  'latitude': '20.537079873524963',
                  'longitude': '-100.82640954902628',
                },
                {
                  'image': 'assets/image11.jpg',
                  'description': 'Candlewood Suites Celaya 4 Estrellas',
                  'latitude': '20.523869585716422',
                  'longitude': '-100.77708607971455',
                },
                {
                  'image': 'assets/image12.jpg',
                  'description': 'St George Hotel 5 Estrellas',
                  'latitude': '20.518947292505477',
                  'longitude': '-100.83674326437081',
                },
              ]),
            ]),
            _buildSection('Restaurantes', [
              _buildCarouselSlider([
                {
                  'image': 'assets/image13.jpg',
                  'description': 'Restaurant Ikal',
                  'latitude': '20.53056138684756',
                  'longitude': '-100.80585675087832',
                },
                {
                  'image': 'assets/image14.jpeg',
                  'description': 'Barra Galera',
                  'latitude': '20.528007137276827',
                  'longitude': '-100.8088209201906',
                },
                {
                  'image': 'assets/image15.jpg',
                  'description': 'Fogon do Brasil',
                  'latitude': '20.529642218078603',
                  'longitude': '-100.77680029937565',
                },
                {
                  'image': 'assets/image16.jpg',
                  'description': 'Mezzé',
                  'latitude': '20.52326693021887',
                  'longitude': '-100.7787766220426',
                },
              ]),
            ]),
            _buildSection('Lugares no Seguros', [
              _buildCarouselSlider([
                {
                  'image': 'assets/image5.jpeg',
                  'description': 'Chino/Sticker-Man House',
                  'latitude': '20.542742613991102',
                  'longitude': ' -100.82105342019001',
                },
                {
                  'image': 'assets/image6.jpeg',
                  'description': 'Emiliano Zapata',
                  'latitude': '20.54536934554629',
                  'longitude': '-100.79852588944819',
                },
                {
                  'image': 'assets/image7.jpeg',
                  'description': 'Hacienda del bosque',
                  'latitude': '20.529898138581522',
                  'longitude': ' -100.86185991877792',
                },
                {
                  'image': 'assets/image8.jpeg',
                  'description': 'Las insurgentes',
                  'latitude': '20.521539909549826',
                  'longitude': '-100.79548382626795',
                },
              ]),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        ...content,
      ],
    );
  }

  Widget _buildCarouselSlider(List<Map<String, String>> lugares) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 0.8,
      ),
      items: lugares.map((lugar) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                _showDescriptionDialog(context, lugar);
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: AssetImage(lugar['image'] ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Future<void> _showDescriptionDialog(
      BuildContext context, Map<String, String> lugar) async {
    final LatLng location = LatLng(
      double.parse(lugar['latitude'] ?? '0.0'),
      double.parse(lugar['longitude'] ?? '0.0'),
    );

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        double screenWidth = MediaQuery.of(context).size.width;
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          title: Text('Descripción'),
          content: Container(
            width: screenWidth *
                0.9, // Puedes ajustar el factor según sea necesario
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Nombre: ${lugar['description']}'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Latitud: ${lugar['latitude']}'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Longitud: ${lugar['longitude']}'),
                ),
                Container(
                  height: 150,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: location,
                      zoom: 15.0,
                    ),
                    markers: {
                      Marker(
                        markerId: MarkerId('Lugar'),
                        position: location,
                      ),
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: TurismoScreen(),
  ));
}
