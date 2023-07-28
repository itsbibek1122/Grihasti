// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:grihasti/screens/add_property/model/property_model.dart';

// class PropertyFormProvider extends ChangeNotifier {
//   Property _property = Property(detailedLocation: '');

//   Property get property => _property;

//   void updateProperty(Property newProperty) {
//     _property = newProperty;
//     notifyListeners();
//   }

//   // Function to submit the form and save data to Firebase
//   void submitFormToFirebase() {
//     CollectionReference propertiesCollection =
//         FirebaseFirestore.instance.collection('properties');

//     propertiesCollection.add({
//       'ownerName': ownerName,
//       'ownerNumber': ownerNumber,
//       'city': selectedCity,
//       'propertyTitle': propertyTitle,
//       'price': price,
//       'purpose': selectedPurpose,
//       'detailedLocation': detailedLocation,
//       'propertyDescription': propertyDescription,
//       'latitude': latitude,
//       'longitude': longitude,
//       'images': images,
//     }).then((value) {
//       // Form data has been successfully saved to Firebase
//       print('Form data saved to Firebase with ID: ${value.id}');
//     }).catchError((error) {
//       // An error occurred while saving form data
//       print('Error saving form data: $error');
//     });
//   }
// }
