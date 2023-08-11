import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

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
}
