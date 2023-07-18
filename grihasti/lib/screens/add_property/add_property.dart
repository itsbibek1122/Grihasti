import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grihasti/provider/chip_provider.dart';
import 'package:grihasti/screens/add_property/add_prop_textfield.dart';
import 'package:grihasti/screens/add_property/maps.dart';
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
  final controller = MultiImagePickerController(
    maxImages: 5,
    withReadStream: true,
    allowedImageTypes: ['png', 'jpg', 'jpeg'],
  );

  @override
  Widget build(BuildContext context) {
    ChipOptions chipOptions = Provider.of<ChipOptions>(context);
    final locationProvider = Provider.of<LocationProvider>(context);

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
                  ),
                  AddPropTextField(
                    hintText: 'Owner Number',
                    keyboardtype: TextInputType.number,
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
                  ),
                  AddPropTextField(
                    hintText: 'Add Price',
                    keyboardtype: TextInputType.number,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Choose City",
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
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8.0, top: 14),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
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
                  Latitude: ${locationProvider.selectedLocation!.latitude}
                  
                   Longitude: ${locationProvider.selectedLocation!.longitude}''')
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
                    controller: controller,
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
                    child:
                        AuthenticationButton(text: 'Submit', onPressed: () {}),
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
