// celaya_info_screen.dart
import 'package:celaya_go/SacercaCelaya/alimentos_screen.dart';
import 'package:celaya_go/SacercaCelaya/cultura_screen.dart';
import 'package:celaya_go/SacercaCelaya/historia_screen.dart';
import 'package:celaya_go/SacercaCelaya/tradiciones_screen.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MaterialApp(
    home: CelayaInfoScreen(),
  ));
}

class CelayaInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Celaya, Guanajuato'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            _buildSection('Historia', Icons.history, context),
            _buildSection('Cultura', Icons.palette, context),
            _buildSection('Alimentos', Icons.local_dining, context),
            _buildSection('Tradiciones', Icons.event, context),
            // Puedes seguir añadiendo secciones según tus necesidades
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/celaya_image.jpg',
            height: 200.0,
            width: 200.0,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 16.0),
          Text(
            'Bienvenido a Celaya',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Descubre la historia, cultura y tradiciones',
            style: TextStyle(fontSize: 16.0),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, IconData icon, BuildContext context) {
    return GestureDetector(
      onTap: () {
        _navigateToSectionScreen(context, title);
      },
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 30.0,
                  color: Colors.blue,
                ),
                SizedBox(width: 16.0),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }

  void _navigateToSectionScreen(BuildContext context, String section) {
    switch (section) {
      case 'Historia':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HistoriaScreen()),
        );
        break;
      case 'Cultura':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CulturaScreen()),
        );
        break;
      case 'Alimentos':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AlimentosScreen()),
        );
        break;
      case 'Tradiciones':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TradicionesScreen()),
        );
        break;
    }
  }
}
