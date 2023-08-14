import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:firebase_database/firebase_database.dart';

class PropertyData {
  final String ownerName;
  final String ownerNumber;
  final String city;
  final String propertyTitle;
  final String price;
  final String purpose;
  final String detailedLocation;
  final String propertyDescription;
  final GeoPoint location;
  final String userId;
  final List<String> images;

  PropertyData({
    required this.ownerName,
    required this.ownerNumber,
    required this.city,
    required this.propertyTitle,
    required this.price,
    required this.location,
    required this.purpose,
    required this.detailedLocation,
    required this.propertyDescription,
    required this.userId,
    required this.images,
  });

  factory PropertyData.fromJson(Map<String, dynamic> json) {
    return PropertyData(
      city: json['city'],
      propertyTitle: json['propertyTitle'],
      location: json['location'],
      ownerName: 'json[ownerName]',
      ownerNumber: 'json[ownerNumber]',
      detailedLocation: 'json[detailedLocation]',
      images: [],
      price: 'json[price]',
      propertyDescription: 'json[propertyDescription]',
      purpose: 'json[purpose]',
      userId: 'json[userId]',
    );
  }
}

Future<PropertyData> fetchProperty(String propertyId) async {
  final databaseReference = FirebaseDatabase.instance.ref();

  final propertyData =
      await databaseReference.child('properties').child(propertyId).get();

  if (propertyData.exists) {
    return PropertyData.fromJson(propertyData.value as Map<String, dynamic>);
  } else {
    throw Exception('Property not found');
  }
}
