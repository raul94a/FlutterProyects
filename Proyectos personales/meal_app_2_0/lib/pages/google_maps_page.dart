import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

class GoogleMapsPage extends StatefulWidget {
  @override
  State<GoogleMapsPage> createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(37.7182399, -3.9699874);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Column(
          children: [
            Expanded(
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 18.0,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCallButton(Icon(Icons.call), 'LLamar'),
                _buildShareButton(Icon(Icons.share), 'Compartir'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCallButton(Icon icon, String text) {
    return Column(
      children: [
        IconButton(
          icon: icon,
          color: Colors.blue,
          iconSize: 40.0,
          onPressed: () {
            launch('tel://606189830');
          },
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          text,
          style: TextStyle(fontSize: 15.0, color: Colors.blue),
        )
      ],
    );
  }

  Widget _buildShareButton(Icon icon, String texto) {
    return Column(
      children: [
        IconButton(
          icon: icon,
          color: Colors.blue,
          iconSize: 40.0,
          onPressed: () async {
            Share.share(
                'https://www.directoalpaladar.com/categoria/recetas-de-pasta');
          },
        ),
        const SizedBox(
          height: 5.0,
        ),
        Text(
          texto,
          style: TextStyle(fontSize: 15.0, color: Colors.blue),
        )
      ],
    );
  }
}
