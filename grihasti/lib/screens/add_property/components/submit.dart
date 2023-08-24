import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:grihasti/provider/user_provider.dart';
import 'package:grihasti/screens/add_property/model/property_model.dart';
import 'package:provider/provider.dart';

class FirebaseService {
  static Future<void> savePropertyData(PropertyData propertyData) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      String propertyId = firestore.collection('properties').doc().id;

      // Upload the images and get the image URLs
      List<String> imageUrls =
          await uploadPropertyImages(propertyId, propertyData.images);

      await firestore.collection('properties').doc(propertyId).set({
        'postedBy': propertyData.userId,
        'ownerName': propertyData.ownerName,
        'ownerNumber': propertyData.ownerNumber,
        'city': propertyData.city,
        'propertyTitle': propertyData.propertyTitle,
        'price': propertyData.price,
        'purpose': propertyData.purpose,
        'location': propertyData.location,
        'detailedLocation': propertyData.detailedLocation,
        'propertyDescription': propertyData.propertyDescription,
        'bedroom': propertyData.bedroom,
        'bathroom': propertyData.bathroom,
        'kitchen': propertyData.kitchen,
        'carparking': propertyData.carparking,
        'bikeparking': propertyData.bikeparking,
        'images': imageUrls,
        'premium': 'No',
        'date': DateTime.now(),
        'bookedBy': null,
        // Store the image URLs in the Firestore document
      });
    } catch (e) {
      print("Error saving property data: $e");
    }
  }

  static Future<List<String>> uploadPropertyImages(
      String propertyId, List<String> imageFilePaths) async {
    List<String> imageUrls = [];

    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference propertyImageRef =
          storage.ref().child('properties/$propertyId');

      for (int i = 0; i < imageFilePaths.length; i++) {
        String imageName = 'image_$i.jpg';
        String imageFilePath = imageFilePaths[i];
        File imageFile = File(imageFilePath);
        if (imageFile.existsSync()) {
          TaskSnapshot uploadTask =
              await propertyImageRef.child(imageName).putFile(imageFile);

          // Get the download URL for the uploaded image
          String imageUrl = await uploadTask.ref.getDownloadURL();
          imageUrls.add(imageUrl);
        } else {
          print('Error: File not found at path $imageFilePath');
        }
      }
    } catch (e) {
      print("Error uploading property images: $e");
    }

    return imageUrls; // Return the list of image URLs
  }
}
