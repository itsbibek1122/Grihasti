import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grihasti/provider/chip_provider.dart';
import 'package:grihasti/provider/dropdown_provider.dart';
import 'package:grihasti/provider/user_provider.dart';
import 'package:grihasti/screens/add_property/model/add_prop_textfield.dart';
import 'package:grihasti/screens/add_property/components/user_repository.dart';
import 'package:grihasti/screens/add_property/model/maps.dart';
import 'package:grihasti/screens/add_property/model/property_model.dart';
import 'package:grihasti/screens/add_property/components/submit.dart';
import 'package:grihasti/screens/authentication/components/my_button.dart';

import 'package:grihasti/screens/homescreen/components/custom_drawer.dart';
import 'package:grihasti/utils/style/colors.dart';
import 'package:grihasti/utils/showSnackBar.dart';
import 'package:latlong2/latlong.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

import 'package:provider/provider.dart';

import '../../provider/location_provider.dart';
import '../homescreen/components/custom_appbar.dart';

class AddProperty extends StatefulWidget {
  @override
  State<AddProperty> createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddProperty> {
  TextEditingController ownerName = TextEditingController();
  final TextEditingController ownerNumber = TextEditingController();
  final TextEditingController propertyTitle = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController detailedLocation = TextEditingController();
  final TextEditingController propertyDescription = TextEditingController();
  final MultiImagePickerController imagePickerController =
      MultiImagePickerController(
    maxImages: 7,
    allowedImageTypes: ['png', 'jpg', 'jpeg'],
    withData: false,
    withReadStream: true,
  );

  @override
  Widget build(BuildContext context) {
    ChipOptions chipOptions = Provider.of<ChipOptions>(context);
    final locationProvider = Provider.of<LocationProvider>(
      context,
    );
    final userId = Provider.of<UserProvider>(context).userId;
    print(userId);
    final dropdownProvider = Provider.of<DropdownProvider>(context);

    List<String> bedrooms = ["1", "2", "3", "4", "5"];
    List<String> bathrooms = ["1", "2", "3", "4"];
    List<String> kitchens = ["1", "2", "3"];
    List<String> carParking = ["Yes", "No"];
    List<String> bikeParking = ["Yes", "No"];

    bool _validateForm() {
      if (ownerName.text.isEmpty ||
          ownerNumber.text.isEmpty ||
          propertyTitle.text.isEmpty ||
          price.text.isEmpty ||
          detailedLocation.text.isEmpty ||
          propertyDescription.text.isEmpty ||
          locationProvider.selectedLocation == null ||
          imagePickerController.hasNoImages ||
          chipOptions.selectedCityIndex == -1 ||
          chipOptions.selectedPurposeIndex == -1 ||
          dropdownProvider.selectedBathrooms.isEmpty ||
          dropdownProvider.selectedBedrooms.isEmpty ||
          dropdownProvider.selectedKitchen.isEmpty ||
          dropdownProvider.selectedCarParking.isEmpty ||
          dropdownProvider.selectedBikeParking.isEmpty) {
        mySnackBar(context, 'Please fill in all fields');
        return false;
      }
      return true;
    }

    void onSubmitForm() {
      // Collect the form data and create a PropertyData object
      if (_validateForm()) {
        PropertyData propertyData = PropertyData(
          ownerName: ownerName.text,
          ownerNumber: ownerNumber.text,
          city: chipOptions.cityOptions[chipOptions.selectedCityIndex],
          propertyTitle: propertyTitle.text,
          price: price.text,
          purpose: chipOptions.purposeOptions[chipOptions.selectedPurposeIndex],
          detailedLocation: detailedLocation.text,
          propertyDescription: propertyDescription.text,
          location: GeoPoint(locationProvider.selectedLocation!.latitude,
              locationProvider.selectedLocation!.longitude),
          userId: userId.toString(),
          images: imagePickerController.images
              .map((imageFile) => imageFile.path) // Map ImageFile? to String?
              .whereType<String>() // Filter out null values
              .toList(),
          bedroom: dropdownProvider.selectedBedrooms.toString(),
          bathroom: dropdownProvider.selectedBathrooms.toString(),
          kitchen: dropdownProvider.selectedKitchen.toString(),
          carparking: dropdownProvider.selectedCarParking.toString(),
          bikeparking: dropdownProvider.selectedBikeParking.toString(),

          // List of image URLs selected by the user
        );

        // Call the FirebaseService method to save the data
        FirebaseService.savePropertyData(propertyData);

        //showing the user the response
        Fluttertoast.showToast(msg: 'Property Added to Database');

        // Clear form values
        ownerName.clear();
        ownerNumber.clear();
        propertyTitle.clear();
        price.clear();
        detailedLocation.clear();
        propertyDescription.clear();
        locationProvider.handleMapTap(null); // Clear the selected location
        chipOptions.setSelectedCityIndex(-1); // Reset city selection
        chipOptions.setSelectedPurposeIndex(-1); // Reset purpose selection
        imagePickerController.clearImages();
        dropdownProvider.clearSelectedBedrooms();
        dropdownProvider.clearSelectedBathrooms();
        dropdownProvider.clearSelectedKitchen();
        dropdownProvider.clearSelectedCarParking();
        dropdownProvider.clearSelectedBikeParking();

        // Clear selected images
      }
    }

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
                  Consumer<LocationProvider>(
                      builder: (context, locationProvider, _) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 12.0, left: 12.0),
                      child: Row(
                        children: [
                          ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
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
          Longitude: ${locationProvider.selectedLocation!.longitude.toDouble()}
          ''')
                                : Text('Map location will be displayed here'),
                          )
                        ],
                      ),
                    );
                  }),
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
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      "Purpose",
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
                        chipOptions.purposeOptions.length,
                        (index) {
                          return ChoiceChip(
                            backgroundColor: AppColors.blackColor,
                            selectedColor: AppColors.orangeColor,
                            label: Text(
                              chipOptions.purposeOptions[index],
                              style: const TextStyle(color: Colors.white),
                            ),
                            selected: chipOptions.selectedPurposeIndex == index,
                            onSelected: (bool selected) {
                              chipOptions.setSelectedPurposeIndex(
                                  selected ? index : -1);
                            },
                          );
                        },
                      ),
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
                    padding: EdgeInsets.all(12.0),
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
                        chipOptions.cityOptions.length,
                        (index) {
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
                        },
                      ),
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
                      maxLength: 550,
                      keyboardType: TextInputType.multiline,
                      controller: propertyDescription,
                      maxLines: 5,
                      decoration: InputDecoration(
                        counterText: '',
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
                      padding: const EdgeInsets.all(8.0),
                      child: Consumer<DropdownProvider>(
                          builder: (context, dropdownProvider, _) {
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(9.0),
                                child: Text(
                                  "Property Details",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Column(
                                    children: [
                                      const Text('Bedroom'),
                                      buildDropdown(
                                        dropdownProvider.selectedBedrooms,
                                        (String? newValue) {
                                          dropdownProvider
                                              .setSelectedBedrooms(newValue);
                                        },
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Text('Bathroom'),
                                      buildDropdown(
                                        dropdownProvider.selectedBathrooms,
                                        (String? newValue) {
                                          dropdownProvider
                                              .setSelectedBathrooms(newValue);
                                        },
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Text('Kitchen'),
                                      buildDropdown(
                                        dropdownProvider.selectedKitchen,
                                        (String? newValue) {
                                          dropdownProvider
                                              .setSelectedKitchen(newValue);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ]);
                      })),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          const Text('Car Parking'),
                          buildDropdown(
                            dropdownProvider.selectedCarParking,
                            (String? newValue) {
                              dropdownProvider.setSelectedCarParking(newValue);
                            },
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text('Bike Parking'),
                          buildDropdown(
                            dropdownProvider.selectedBikeParking,
                            (String? newValue) {
                              dropdownProvider.setSelectedBikeParking(newValue);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),

                  //For Image
                  const SizedBox(height: 8),
                  MultiImagePickerView(
                    addButtonTitle: 'Add Photos',
                    onChange: (list) {
                      debugPrint(list.toString());
                    },
                    controller: imagePickerController,
                    padding: const EdgeInsets.all(10),
                  ),

                  const SizedBox(height: 32),

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

DropdownButton<String> buildDropdown(
    String value, void Function(String?) onChanged) {
  List<String> options = ['0', '1', '2', '3', '4', '5'];

  return DropdownButton<String>(
    value: value,
    onChanged: onChanged,
    items: options.map<DropdownMenuItem<String>>((String option) {
      return DropdownMenuItem<String>(
        value: option,
        child: Text(option),
      );
    }).toList(),
  );
}
