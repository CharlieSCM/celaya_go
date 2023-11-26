import 'dart:async';
import 'package:celaya_go/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:celaya_go/screens/turismo_screen.dart';
import 'package:celaya_go/models/markers_model.dart';
import 'package:celaya_go/routes.dart';

/*void main() => runApp(MaterialApp(
  home: MapSample(),
));*/

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

/*class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => MapScreenState();
}*/

//class MapScreenState extends State<MapScreen> {
class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late LocationData _currentLocation;
  bool _isLoading = true;
  Set<Marker> _markers = {};
  DatabaseHelper _databaseHelper = DatabaseHelper();
  bool _isMarkerSelected = false;
  MarkerModel? _selectedMarker;

  @override
  void initState() {
    super.initState();
    _initLocation();
    _loadMarkers();
  }

  Future<void> _initLocation() async {
    try {
      var location = Location();
      location.onLocationChanged.listen((LocationData currentLocation) {
        if (mounted) {
          setState(() {
            _currentLocation = currentLocation;
            _isLoading = false;
          });
        }
      });
    } catch (e) {
      print("Error initializing location: $e");
    }
  }

  Future<void> _loadMarkers() async {
    List<MarkerModel> markers = await _databaseHelper.getMarkers();
    setState(() {
      _markers = markers.map((marker) {
        return Marker(
          markerId: MarkerId(marker.id.toString()),
          position: LatLng(
              double.parse(marker.latitude!), double.parse(marker.longitude!)),
          infoWindow: InfoWindow(title: marker.title),
          onTap: () {
            setState(() {
              _selectedMarker = marker;
              _isMarkerSelected = true;
            });
          },
        );
      }).toSet();
    });
  }

  Future<void> _addMarker(LatLng position, String title) async {
    Marker newMarker = Marker(
      markerId: MarkerId(position.toString()),
      position: position,
      infoWindow: InfoWindow(title: title),
    );

    setState(() {
      _markers.add(newMarker);
    });

    await _databaseHelper.INSERT(
        'markers',
        MarkerModel(
          latitude: position.latitude.toString(),
          longitude: position.longitude.toString(),
          title: title,
        ));

    List<MarkerModel> markerModels = await _databaseHelper.getMarkers();

    _showSavedMarkers(markerModels);
    _loadMarkers();
  }

  Future<void> _showSavedMarkers(List<MarkerModel> markers) async {
    String markerInfo = '';
    markers.forEach((marker) {
      markerInfo +=
          'ID: ${marker.id}, Title: ${marker.title}, Latitude: ${marker.latitude}, Longitude: ${marker.longitude}\n';
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ubicaciones guardadas'),
          content: Text(markerInfo),
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

  void _deleteMarker(MarkerModel marker) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Eliminar ubicación'),
          content: Text('¿Estás seguro de que deseas eliminar esta ubicación?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                await _databaseHelper.deleteMarker(marker.id!);
                _loadMarkers();
                Navigator.of(context).pop();
              },
              child: Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  void _showMarkerOptions(MarkerModel marker) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Editar'),
              onTap: () {
                Navigator.pop(context);
                _editMarker(marker);
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Detalles'),
              onTap: () {
                Navigator.pop(context);
                _showMarkerDetails(marker);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Eliminar'),
              onTap: () {
                Navigator.pop(context);
                _deleteMarker(marker);
              },
            ),
          ],
        );
      },
    );
  }

  void _editMarker(MarkerModel marker) async {
    TextEditingController titleController = TextEditingController();
    titleController.text = marker.title ?? '';

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar ubicación'),
          content: TextField(
            controller: titleController,
            decoration: InputDecoration(hintText: 'Nuevo nombre'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                String newTitle = titleController.text.trim();
                if (newTitle.isNotEmpty) {
                  marker.title = newTitle;
                  await _databaseHelper.updateMarker(marker.toMap());
                  _loadMarkers();
                  Navigator.of(context).pop();
                }
              },
              child: Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void _showMarkerDetails(MarkerModel marker) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detalles del marcador'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('ID: ${marker.id}'),
              Text('Título: ${marker.title}'),
              Text('Latitud: ${marker.latitude}'),
              Text('Longitud: ${marker.longitude}'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _miUbicacion() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            _currentLocation.latitude!,
            _currentLocation.longitude!,
          ),
          zoom: 14.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Celaya Go'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: GoogleMap(
                    mapType: MapType.none,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        _currentLocation.latitude!,
                        _currentLocation.longitude!,
                      ),
                      zoom: 14.0,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    markers: _markers,
                    onTap: (LatLng position) {
                      _showMarkerDialog(position);
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_isMarkerSelected) {
                      _showMarkerOptions(_selectedMarker!);
                    }
                  },
                  child: Text('Mostrar opciones'),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _miUbicacion,
        label: const Text('Yo'),
        icon: const Icon(Icons.location_pin),
      ),
    );
  }

  Future<void> _showMarkerDialog(LatLng position) async {
    _isMarkerSelected = false;
    TextEditingController titleController = TextEditingController();

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ingrese el nombre de la ubicacion'),
          content: TextField(
            controller: titleController,
            decoration: InputDecoration(hintText: 'Nombre'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                String title = titleController.text.trim();
                if (title.isNotEmpty) {
                  _addMarker(position, title);
                }
                Navigator.of(context).pop();
              },
              child: Text('Guardar'),
            ),
          ],
        );
      },
    );
  }
}

/*import 'dart:async';
import 'package:celaya_go/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
//import 'package:celaya_go/screens/turismo_screen.dart';
import 'package:celaya_go/models/markers_model.dart';
import 'package:celaya_go/screens/turismo_screen.dart';

/*void main() => runApp(MaterialApp(
  home: MapSample(),
));*/

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

/*class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => MapScreenState();
}*/

//class MapScreenState extends State<MapScreen> {
class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late LocationData _currentLocation;
  bool _isLoading = true;
  Set<Marker> _markers = {};
  DatabaseHelper _databaseHelper = DatabaseHelper();
  bool _isMarkerSelected = false;
  MarkerModel? _selectedMarker;

  @override
  void initState() {
    super.initState();
    _initLocation();
    _loadMarkers();
  }

  Future<void> _initLocation() async {
    try {
      var location = Location();
      location.onLocationChanged.listen((LocationData currentLocation) {
        if (mounted) {
          setState(() {
            _currentLocation = currentLocation;
            _isLoading = false;
          });
        }
      });
    } catch (e) {
      print("Error initializing location: $e");
    }
  }

  Future<void> _loadMarkers() async {
    List<MarkerModel> markers = await _databaseHelper.getMarkers();
    setState(() {
      _markers = markers.map((marker) {
        return Marker(
          markerId: MarkerId(marker.id.toString()),
          position: LatLng(
              double.parse(marker.latitude!), double.parse(marker.longitude!)),
          infoWindow: InfoWindow(title: marker.title),
          onTap: () {
            setState(() {
              _selectedMarker = marker;
              _isMarkerSelected = true;
            });
          },
        );
      }).toSet();
    });
  }

  Future<void> _addMarker(LatLng position, String title) async {
    Marker newMarker = Marker(
      markerId: MarkerId(position.toString()),
      position: position,
      infoWindow: InfoWindow(title: title),
    );

    setState(() {
      _markers.add(newMarker);
    });

    await _databaseHelper.INSERT(
        'markers',
        MarkerModel(
          latitude: position.latitude.toString(),
          longitude: position.longitude.toString(),
          title: title,
        ));

    List<MarkerModel> markerModels = await _databaseHelper.getMarkers();

    _showSavedMarkers(markerModels);
  }

  Future<void> _showSavedMarkers(List<MarkerModel> markers) async {
    String markerInfo = '';
    markers.forEach((marker) {
      markerInfo +=
          'ID: ${marker.id}, Title: ${marker.title}, Latitude: ${marker.latitude}, Longitude: ${marker.longitude}\n';
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ubicaciones guardadas'),
          content: Text(markerInfo),
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

  void _deleteMarker(MarkerModel marker) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Eliminar ubicación'),
          content: Text('¿Estás seguro de que deseas eliminar esta ubicación?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                await _databaseHelper.deleteMarker(marker.id!);
                _loadMarkers();
                Navigator.of(context).pop();
              },
              child: Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  void _showMarkerOptions(MarkerModel marker) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Editar'),
              onTap: () {
                Navigator.pop(context);
                _editMarker(marker);
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Detalles'),
              onTap: () {
                Navigator.pop(context);
                _showMarkerDetails(marker);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Eliminar'),
              onTap: () {
                Navigator.pop(context);
                _deleteMarker(marker);
              },
            ),
          ],
        );
      },
    );
  }

  void _editMarker(MarkerModel marker) async {
    TextEditingController titleController = TextEditingController();
    titleController.text = marker.title ?? '';

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar ubicación'),
          content: TextField(
            controller: titleController,
            decoration: InputDecoration(hintText: 'Nuevo nombre'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                String newTitle = titleController.text.trim();
                if (newTitle.isNotEmpty) {
                  marker.title = newTitle;
                  await _databaseHelper.updateMarker(marker.toMap());
                  _loadMarkers();
                  Navigator.of(context).pop();
                }
              },
              child: Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void _showMarkerDetails(MarkerModel marker) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detalles del marcador'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('ID: ${marker.id}'),
              Text('Título: ${marker.title}'),
              Text('Latitud: ${marker.latitude}'),
              Text('Longitud: ${marker.longitude}'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _miUbicacion() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            _currentLocation.latitude!,
            _currentLocation.longitude!,
          ),
          zoom: 14.0,
        ),
      ),
    );
  }

  Drawer createDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              '',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('turismo'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TurismoScreen()),
              );
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              // Handle item 2
            },
          ),

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Celaya Go'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: GoogleMap(
                    mapType: MapType.none,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        _currentLocation.latitude!,
                        _currentLocation.longitude!,
                      ),
                      zoom: 14.0,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    markers: _markers,
                    onTap: (LatLng position) {
                      _showMarkerDialog(position);
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_isMarkerSelected) {
                      _showMarkerOptions(_selectedMarker!);
                    }
                  },
                  child: Text('Mostrar opciones'),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _miUbicacion,
        label: const Text('Yo'),
        icon: const Icon(Icons.location_pin),
      ),
      drawer: createDrawer(context),
    );
  }

  Future<void> _showMarkerDialog(LatLng position) async {
    _isMarkerSelected = false;
    TextEditingController titleController = TextEditingController();

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ingrese el nombre de la ubicacion'),
          content: TextField(
            controller: titleController,
            decoration: InputDecoration(hintText: 'Nombre'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                String title = titleController.text.trim();
                if (title.isNotEmpty) {
                  _addMarker(position, title);
                }
                Navigator.of(context).pop();
              },
              child: Text('Guardar'),
            ),
          ],
        );
      },
    );
  }
}*/