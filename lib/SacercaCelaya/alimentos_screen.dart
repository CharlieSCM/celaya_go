import 'package:flutter/material.dart';

class AlimentosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alimentos de Celaya'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSection(
              'Platillos Tradicionales',
              'Entre los platillos tradicionales destacan el mole preparado con carne de pavo, chiles, chocolate, además de una variedad de especias para los chiles rellenos o las carnitas, el caldo michi, sopa de pescado preparada con verdura picada, zanahoria, chayote, calabaza, col y apio, pico de gallo, ensalada a base de jitomate, cebolla, chile de árbol y cilantro. La barbacoa incluye varios tipos de carnes (cabrito, carnero o jabalí) que se cocinan dentro de un hoyo en la tierra. También son típicos los dulces cubiertos de piñón y nuez, los cacahuates garapiñados y una gran variedad de ates, acitrones y cajeta.',
              'assets/platillos_tradicionales.jpg',
            ),
            _buildSection(
              'Gastronomía Celayense',
              'La gastronomía en Celaya es uno de sus atractivos, ya que cuenta con una gran variedad de platillos típicos. Entre ellos se encuentran las gorditas de tierras negras, elaboradas con harina de maíz y rellenas de restos de carnitas de cerdo o queso con chile guajillo. Otros platillos imperdibles son la barbacoa, los duritos (una especie de tostada) de chicharrón con cueritos, las pacharelas (grandes tacos rellenos de chicharrón ranchero, requesón o frijoles) y, por supuesto, sus famosos tacos con ricos guisados.',
              'assets/gastronomia_celayense.jpg',
            ),
            _buildSection(
              'Dulces Tradicionales',
              'Lo que le ha ganado fama a Celaya son sus dulces, especialmente la cajeta, que viene presentada en varias opciones como cajeta quemada, de vainilla, de nuez, pasa, piñón o almendras. También hay otros dulces que combinan la rica cajeta como las obleas, chiclosos o paletas. Si eres amante de lo dulce, también puedes deleitarte con ricos ates y cacahuates garapiñados.',
              'assets/dulces_tradicionales.jpg',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content, String imagePath) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 200.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 16.0),
        Text(
          title,
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Text(
          content,
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(height: 16.0),
      ],
    );
  }
}
