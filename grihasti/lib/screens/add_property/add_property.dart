import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grihasti/provider/chip_provider.dart';
import 'package:grihasti/provider/user_provider.dart';
import 'package:grihasti/screens/add_property/add_prop_textfield.dart';
import 'package:grihasti/screens/add_property/components/user_repository.dart';
import 'package:grihasti/screens/add_property/maps.dart';
import 'package:grihasti/screens/add_property/model/property_model.dart';
import 'package:grihasti/screens/add_property/model/submit.dart';
import 'package:grihasti/screens/authentication/components/my_button.dart';

import 'package:grihasti/screens/homescreen/components/custom_drawer.dart';
import 'package:grihasti/style/colors.dart';
import 'package:latlong2/latlong.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

import 'package:provider/provider.dart';

import '../../provider/location_provider.dart';
import '../homescreen/components/custom_appbar.dart';

class AddProperty extends StatefulWidget {
  // final LatLng selectedLocation;

  // AddProperty({required this.selectedLocation});

  @override
  State<AddProperty> createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddProperty> {
  final imgcontroller = MultiImagePickerController(
    maxImages: 5,
    withReadStream: true,
    allowedImageTypes: ['png', 'jpg', 'jpeg'],
  );

  TextEditingController ownerName = TextEditingController();
  final TextEditingController ownerNumber = TextEditingController();
  final TextEditingController propertyTitle = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController detailedLocation = TextEditingController();
  final TextEditingController propertyDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ChipOptions chipOptions = Provider.of<ChipOptions>(context);
    final locationProvider = Provider.of<LocationProvider>(context);
    final userId = Provider.of<UserProvider>(context).userId;

    void onSubmitForm() {
      // Collect the form data and create a PropertyData object
      PropertyData propertyData = PropertyData(
        // Populate the properties with the form values
        // (You'll need to adjust this based on your actual form fields)
        ownerName: ownerName.text,
        ownerNumber: ownerNumber.text,
        // city: selectedCity,
        propertyTitle: propertyTitle.text,
        price: price.text,
        // purpose: selectedPurpose,
        detailedLocation: detailedLocation.text,
        propertyDescription: propertyDescription.text,
        latitude: locationProvider.selectedLocation!.latitude,
        longitude: locationProvider.selectedLocation!.longitude,
        // imageUrls: selectedImageUrls, // List of image URLs selected by the user
      );

      // Call the FirebaseService method to save the data
      FirebaseService.savePropertyData(propertyData);
    }

    // void submitFormToFirebase() {
    //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    //   // Generate a unique ID for the property
    //   String propertyId = _firestore.collection('properties').doc().id;

    //   Map<String, dynamic> formData = {
    //     'ownerName': ownerName,
    //     'ownerNumber': ownerNumber,
    //     // 'city': selectedCity,
    //     'propertyTitle': propertyTitle,
    //     'price': price,
    //     // 'purpose': selectedPurpose,
    //     'detailedLocation': detailedLocation,
    //     'propertyDescription': propertyDescription,
    //     'latitude': (locationProvider.selectedLocation!.latitude),
    //     'longitude': locationProvider.selectedLocation!.longitude,
    //     'userId': userId,
    //   };

    //   // Save the data to Firestore under the 'properties' collection with the generated ID
    //   _firestore.collection('properties').doc(propertyId).set(formData);
    // }

    return Scaffold(
      appBar: MyAppBar(
        title: 'Add Property',
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AddPropTextField(
                    hintText: 'Owner Name',
                    keyboardtype: TextInputType.name,
                    controller: ownerName,
                  ),
                  AddPropTextField(
                    hintText: 'Owner Number',
                    keyboardtype: TextInputType.number,
                    controller: ownerNumber,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Purpose",
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Wrap(
                      spacing: 15.0,
                      children: List<Widget>.generate(
                          chipOptions.purposeOptions.length, (index) {
                        return ChoiceChip(
                          backgroundColor: AppColors.blackColor,
                          selectedColor: AppColors.orangeColor,
                          label: Text(
                            chipOptions.purposeOptions[index],
                            style: const TextStyle(color: Colors.white),
                          ),
                          selected: chipOptions.selectedPurposeIndex == index,
                          onSelected: (bool selected) {
                            chipOptions
                                .setSelectedPurposeIndex(selected ? index : -1);
                          },
                        );
                      }),
                    ),
                  ),
                  AddPropTextField(
                    hintText: 'Property Title',
                    keyboardtype: TextInputType.text,
                    controller: propertyTitle,
                  ),
                  AddPropTextField(
                    hintText: 'Add Price',
                    keyboardtype: TextInputType.number,
                    controller: price,
                  ),
                  const Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Choose City",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Wrap(
                      spacing: 15.0,
                      children: List<Widget>.generate(
                          chipOptions.cityOptions.length, (index) {
                        return ChoiceChip(
                          backgroundColor: AppColors.blackColor,
                          selectedColor: AppColors.orangeColor,
                          label: Text(
                            chipOptions.cityOptions[index],
                            style: const TextStyle(color: Colors.white),
                          ),
                          selected: chipOptions.selectedCityIndex == index,
                          onSelected: (bool selected) {
                            chipOptions
                                .setSelectedCityIndex(selected ? index : -1);
                          },
                        );
                      }),
                    ),
                  ),
                  AddPropTextField(
                    hintText: 'Detailed Location',
                    keyboardtype: TextInputType.text,
                    controller: detailedLocation,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8.0, top: 14),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      controller: propertyDescription,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'Enter Property Descripton',
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, left: 12.0),
                    child: Row(
                      children: [
                        ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  AppColors.blackColor),
                              // Add more style configurations as needed
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/mapScreen');
                            },
                            child: const Text('Add Map')),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: locationProvider.selectedLocation != null
                              ? Text('''
                  Latitude: ${locationProvider.selectedLocation!.latitude.toDouble()}
                  
                   Longitude: ${locationProvider.selectedLocation!.longitude.toDouble()}''')
                              : Text('Map location will be displayed here'),
                        )
                      ],
                    ),
                  ),

                  //For Image
                  const SizedBox(height: 8),
                  MultiImagePickerView(
                    addButtonTitle: 'Add Photos',
                    onChange: (list) {
                      debugPrint(list.toString());
                    },
                    controller: imgcontroller,
                    padding: const EdgeInsets.all(10),
                  ),
                  const SizedBox(height: 32),
//Yo Submit garney code ho IMP DO NOT DELETE
                  // ElevatedButton(
                  //   onPressed: () {
                  //     final images = controller.images;
                  //     // use these images
                  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //         content: Text(images.map((e) => e.name).toString())));
                  //   },
                  //   child: null,
                  // ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AuthenticationButton(
                        text: 'Submit',
                        onPressed: () {
                          onSubmitForm();
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
