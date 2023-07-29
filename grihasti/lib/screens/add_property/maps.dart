import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:grihasti/screens/add_property/add_property.dart';
import 'package:grihasti/screens/homescreen/components/custom_appbar.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../provider/location_provider.dart';

class MyMap extends StatelessWidget {
  // LatLng _selectedLocation = LatLng(0, 0);

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    return Scaffold(
      appBar: MyAppBar(title: 'Select Location'),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(27.700769, 85.300140),
          zoom: 13.0,
          onTap: (tapPosition, latLng) => locationProvider.handleMapTap(latLng),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(
            markers: locationProvider.selectedLocation != null
                ? [
                    Marker(
                      width: 30.0,
                      height: 30.0,
                      point: locationProvider.selectedLocation!,
                      builder: (ctx) => const Icon(
                        Icons.person_pin_circle_outlined,
                        color: Colors.purple,
                      ),
                    ),
                  ]
                : [],
          ),
          if (locationProvider.selectedLocation != null)
            Container(
              padding: EdgeInsets.only(top: 16.0),
              color: Colors.white,
              child: Text('''
                  Latitude: ${locationProvider.selectedLocation!.latitude}
                   Longitude: ${locationProvider.selectedLocation!.longitude}'''),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF1B1A25),
        onPressed: () {
          if (locationProvider.selectedLocation != null) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Location Selected"),
                  content: Text('''
                  Latitude: ${locationProvider.selectedLocation!.latitude}
                  
                   Longitude: ${locationProvider.selectedLocation!.longitude}'''),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("OK"),
                    ),
                  ],
                );
              },
            );
            Navigator.pushNamed(context, '/addProperty');
            print(
                'Latitude is ${locationProvider.selectedLocation!.latitude.toString()}');
            print(
                'Longitude is ${locationProvider.selectedLocation!.longitude.toString()}');
          } else {
            Fluttertoast.showToast(msg: 'Select Location First');
          }
        },
        tooltip: 'Show Location',
        child: Wrap(
          children: const [
            Icon(Icons.save),
            Text('Save'),
          ],
        ),
      ),
    );
  }
}
