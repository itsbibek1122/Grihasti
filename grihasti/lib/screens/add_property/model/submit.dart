import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:grihasti/provider/user_provider.dart';
import 'package:grihasti/screens/add_property/model/property_model.dart';
import 'package:provider/provider.dart';

class FirebaseService {
  static Future<void> savePropertyData(PropertyData propertyData) async {
    try {
      // Get the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Generate a unique ID for the property
      String propertyId = firestore.collection('properties').doc().id;

      // Store the property data under the 'properties' collection with the generated ID
      await firestore.collection('properties').doc(propertyId).set({
        'ownerName': propertyData.ownerName,
        'ownerNumber': propertyData.ownerNumber,
        // 'city': propertyData.city,
        'propertyTitle': propertyData.propertyTitle,
        'price': propertyData.price,
        // 'purpose': propertyData.purpose,
        'location': propertyData.location,
        'detailedLocation': propertyData.detailedLocation,
        'propertyDescription': propertyData.propertyDescription,

        'userId': propertyData.userId,
        'images': propertyData.images,

        // Add other fields as needed
      });

      // Handle image upload separately, assuming you have a list of image URLs in propertyData
      await uploadPropertyImages(propertyId, propertyData.images);
    } catch (e) {
      // Handle errors appropriately
      print("Error saving property data: $e");
    }
  }

  static Future<void> uploadPropertyImages(
      String propertyId, List<String> imageFilePaths) async {
    try {
      // Get the Firebase Storage instance
      FirebaseStorage storage = FirebaseStorage.instance;

      // Create a reference to the property's image folder in Firebase Storage
      Reference propertyImageRef =
          storage.ref().child('properties/$propertyId');

      // Upload each image to Firebase Storage
      for (int i = 0; i < imageFilePaths.length; i++) {
        String imageName =
            'image_$i.jpg'; // You can customize the image name if needed
        String imageFilePath = imageFilePaths[i];

        File imageFile = File(imageFilePath);
        if (imageFile.existsSync()) {
          // Upload the file to Firebase Storage.
          await propertyImageRef.child(imageName).putFile(imageFile);
        } else {
          // Create the file.
          // imageFile.createSync();

          print('Error: File not found at path $imageFilePath');
          // Upload the file to Firebase Storage.
        }
      }
    } catch (e) {
      // Handle errors appropriately
      print("Error uploading property images: $e");
    }
  }
}
