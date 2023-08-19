import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grihasti/provider/current_location_provider.dart';
import 'package:grihasti/screens/homescreen/components/custom_appbar.dart';
import 'package:grihasti/screens/homescreen/components/other_products.dart';
import 'package:grihasti/utils/style/colors.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class MapsView extends StatefulWidget {
  @override
  State<MapsView> createState() => _MapsViewState();
}

class _MapsViewState extends State<MapsView> {
  final CollectionReference propertiesCollection =
      FirebaseFirestore.instance.collection('properties');

  late LatLng userLocation = LatLng(27.700769, 85.300140); // Default location

  @override
  void initState() {
    super.initState();
    _updateUserLocation();
  }

  Future<void> _updateUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        userLocation = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      print('Unable to access location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Property Maps'),
      body: StreamBuilder<QuerySnapshot>(
        stream: propertiesCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No data available.'));
          }
          final markers = snapshot.data!.docs.map((doc) {
            final geoPoint = doc['location'] as GeoPoint;
            final latLng = LatLng(geoPoint.latitude, geoPoint.longitude);

            return Marker(
              width: 30.0,
              height: 30.0,
              point: latLng,
              builder: (ctx) => GestureDetector(
                onTap: () {
                  _showPropertyDetailsDialog(context, doc);
                },
                child: const Icon(
                  Icons.home,
                  color: Colors.black,
                  size: 42,
                ),
              ),
              anchorPos: AnchorPos.align(AnchorAlign.top),
            );
          }).toList();

          return FlutterMap(
            options: MapOptions(
              center: LatLng(27.700769, 85.300140),
              zoom: 13.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: markers,
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.blackColor,
        onPressed: () => _showNearestPropertyDialog(),
        icon: Icon(Icons.near_me_outlined),
        label: Text('Nearest Property'),
      ),
    );
  }

  void _showPropertyDetailsDialog(BuildContext context, DocumentSnapshot doc) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        final geoPoint = doc['location'] as GeoPoint;
        final documentId = doc.id;

        final propertyLatLng = LatLng(geoPoint.latitude, geoPoint.longitude);

        final distance = calculateDistance(userLocation, propertyLatLng);

        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Property Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              SizedBox(height: 8),

              Text('Distance: ${distance.toStringAsFixed(2)} meters'),
              Text('Title: ${doc['propertyTitle']}'),
              Text('Location: ${doc['detailedLocation']}'),
              Text('Price: ${doc['price']}'),
              Text('Purpose: ${doc['purpose']}'),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/details',
                        arguments: documentId);
                  },
                  child: Text('Show details')),

              // Add more details as needed
            ],
          ),
        );
      },
    );
  }

  double calculateDistance(LatLng from, LatLng to) {
    final double distance = Distance().as(
      LengthUnit.Meter,
      LatLng(from.latitude, from.longitude),
      LatLng(to.latitude, to.longitude),
    );
    return distance;
  }

  void _showNearestPropertyDialog() async {
    final userLocationProvider = context.read<CurrentLocationProvider>();

    await userLocationProvider.updateUserLocation(); // Update the user location

    final userLocation = userLocationProvider.userLocation;

    if (userLocation == null) {
      return print('Unable to access location');
    } else {
      print(userLocation);
    }

    final snapshot = await propertiesCollection.get(); // Fetch the data once

    double? nearestDistance = double.infinity;
    String? nearestPropertyDocumentId;
    String? nearestPropertyImageUrl;
    String? nearestPropertyTitle;
    String? nearestPropertyDetailedLocation;
    int? nearestPropertyPrice;
    String? nearestPropertyPurpose;

    for (final doc in snapshot.docs) {
      final geoPoint = doc['location'] as GeoPoint;
      final propertyLatLng = LatLng(geoPoint.latitude, geoPoint.longitude);

      final distance = calculateDistance(userLocation, propertyLatLng);
      if (distance < nearestDistance!) {
        nearestDistance = distance as double?;
        nearestPropertyDocumentId = doc.id;
        nearestPropertyImageUrl = doc['images'][0];
        nearestPropertyTitle = doc['propertyTitle'];
        nearestPropertyDetailedLocation = doc['detailedLocation'];
        nearestPropertyPrice = int.parse(doc['price']);
        nearestPropertyPurpose = doc['purpose'];
      }
    }

    showModalBottomSheet(
      context: context,
      builder: (context) => FutureBuilder(
        future:
            Future.delayed(Duration(seconds: 1)), // Simulating a loading delay
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nearest Property Details',
                      style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  Text(
                      'Nearest Distance: ${nearestDistance!.toStringAsFixed(2)} meters'),
                  // Display other property details here
                  OtherCard(
                    title: nearestPropertyTitle ?? '',
                    description: nearestPropertyDetailedLocation ?? '',
                    imageUrl: nearestPropertyImageUrl ?? '',
                    price: nearestPropertyPrice ?? 0,
                    purpose: nearestPropertyPurpose ?? '',
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
