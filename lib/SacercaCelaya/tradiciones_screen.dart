import 'package:flutter/material.dart';

class TradicionesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tradiciones de Celaya'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTraditionSection(
              'Fiestas de Tierras Negras',
              'Del 12 al 20 de enero, se celebran las tradicionales fiestas en honor a la virgen de Guadalupe en Tierras Negras. Peregrinaciones de diferentes lugares de la república llegan para participar. Hay un recorrido por las calles con la reina de Tierras Negras, bandas de música, carros alegóricos y la imagen de la virgen de Guadalupe. Se presentan danzas, coloquios, grupos musicales y diversas representaciones artísticas. La celebración incluye antojitos regionales como gorditas, buñuelos, atole, tamales y sopes.',
              'assets/fiestas_tierras_negras.jpg',
            ),
            _buildTraditionSection(
              'Semana Santa',
              'La Semana Santa en Celaya inicia desde el viernes previo al Viernes Santo. Los celayenses colocan altares afuera de sus casas con la imagen de la virgen de los dolores. El Jueves Santo es la tradicional "visita de las 7 casas". Se representan los hechos de la pasión, muerte y resurrección de Cristo en varios barrios. El Viernes Santo destaca la procesión del silencio. El Domingo de Resurrección solía incluir la quema de judas, pero se suspendió después del incidente del "domingo negro".',
              'assets/semana_santa.jpg',
            ),
            _buildTraditionSection(
              'Día de Muertos',
              'El 1 y 2 de noviembre, se lleva a cabo la venta de alfeñiques y calaveras en las afueras de los panteones y en la Calzada Hidalgo. El segundo domingo del mes se encienden fogatas en las calles aledañas al panteón municipal. Esta tradición se originó cuando el panteón se trasladó de lugar, y las fogatas ayudaban a las almas de los difuntos a encontrar su nuevo hogar.',
              'assets/dia_de_muertos.jpg',
            ),
            // Puedes agregar más secciones según las tradiciones que desees destacar
          ],
        ),
      ),
    );
  }

  Widget _buildTraditionSection(String title, String content, String imagePath) {
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

