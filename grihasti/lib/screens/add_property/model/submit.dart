import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grihasti/screens/add_property/model/property_model.dart';

class FirebaseService {
  static Future<void> savePropertyData(PropertyData propertyData) async {
    // try {
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
      'detailedLocation': propertyData.detailedLocation,
      'propertyDescription': propertyData.propertyDescription,
      'latitude': propertyData.latitude,
      'longitude': propertyData.longitude,
      // Add other fields as needed
    });

    // Handle image upload separately, assuming you have a list of image URLs in propertyData
    //   await uploadPropertyImages(propertyId, propertyData.imageUrls);
    // } catch (e) {
    //   // Handle errors appropriately
    //   print("Error saving property data: $e");
    // }

    // static Future<void> uploadPropertyImages(
    //     String propertyId, List<String> imageUrls) async {
    //   try {
    //     // Get the Firebase Storage instance
    //     FirebaseStorage storage = FirebaseStorage.instance;

    //     // Create a reference to the property's image folder in Firebase Storage
    //     Reference propertyImageRef =
    //         storage.ref().child('properties/$propertyId');

    //     // Upload each image to Firebase Storage
    //     for (int i = 0; i < imageUrls.length; i++) {
    //       String imageName =
    //           'image_$i.jpg'; // You can customize the image name if needed
    //       String imageUrl = imageUrls[i];

    //       // Upload the image
    //       await propertyImageRef.child(imageName).putFile(Uri.parse(imageUrl));
    //     }
    //   } catch (e) {
    //     // Handle errors appropriately
    //     print("Error uploading property images: $e");
    //   }
    // }
  }
}
