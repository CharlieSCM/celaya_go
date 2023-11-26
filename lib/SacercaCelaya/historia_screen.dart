// historia_screen.dart
import 'package:flutter/material.dart';

class HistoriaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historia de Celaya'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSection(
              'Fundación de Celaya',
              'La ciudad fue fundada sobre un poblado indígena llamado Nattahí, que en lengua otomí significa debajo del mezquite o a la sombra del mezquite. Varios españoles de las villas de Apaseo y Acámbaro se instalaron para surtir a los viajeros. Estos primeros españoles llamaban a la comarca el mezquital de los Apatzeos. El epicentro de construcción para la ciudadela fue el convento grande de San Francisco y el posterior establecimiento de las casas reales en la plaza de armas.',
              'assets/fundacion_celaya.jpg',
            ),
            _buildSection(
              'Independencia en Celaya',
              'Al iniciar el movimiento independentista, la ciudad recibió a Don Miguel Hidalgo, días después de proclamar el 16 de septiembre de 1810 el grito de Dolores. La muchedumbre llegó a los alrededores de Celaya el día 20 de septiembre de 1810, acampando en los terrenos de la hacienda de Santa Rita.',
              'assets/independencia_celaya.jpg',
            ),
            _buildSection(
              'Historia de Celaya',
              'En el período comprendido entre los años 1568-1569, los indomables chichimecas, alzados contra la Corona, atacaron Comanja y asesinaron sin piedad a todos los españoles allí residentes, salvándose nada más el presbítero Juan de la Cuenca y un seglar de nombre Juan de Sayas. Después, en 1570, desplazándose de estas regiones hasta Xilotepec.',
              'assets/historia_celaya.jpg',
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
