import 'package:flutter/material.dart';

class CulturaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cultura de Celaya'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSection(
              'Instituto de Arte y Cultura de Celaya',
              'El Instituto de Arte y Cultura de Celaya es un organismo público que coordina, dirige y promueve actividades de difusión, promoción y capacitación en el área de cultura para consolidar la identidad de los celayenses. Su misión es fomentar nuestras tradiciones y los valores universales, además de estimular la creatividad artística e intelectual de la comunidad.',
              'assets/instituto_arte_cultura.png',
            ),
            _buildSection(
              'Sistema de Información Cultural (SIC)',
              'Con el propósito de que los datos públicos contenidos en el Sistema de Información Cultural puedan ser utilizados y compartidos por los usuarios de la plataforma, se ofrece la posibilidad de descargar archivos en diversos formatos abiertos, como CSV compatible con Excel y otros más oportunos para su procesamiento informático. La información se presenta con un nivel de desagregación suficiente para permitir su análisis y la construcción de nuevas variables agregadas. Es importante destacar que la información del SIC se actualiza de manera permanente.',
              'assets/sistema_informacion_cultural.jpg',
            ),
            _buildSection(
              'Museo de Celaya, Historia Regional',
              'El Museo de Celaya, Historia Regional, es un espacio dedicado a preservar y mostrar la rica historia de la región. A través de exposiciones permanentes y temporales, el museo ofrece a los visitantes la oportunidad de explorar y comprender el pasado de Celaya y sus alrededores.',
              'assets/museo_celaya.jpg',
            ),
            
            // Puedes agregar más secciones según la información cultural que desees destacar
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
