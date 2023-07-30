// import 'package:flutter/foundation.dart';
// import 'package:multi_image_picker_view/multi_image_picker_view.dart';

// class ImageUploadProvider extends ChangeNotifier {
//   List<Asset>? _selectedImages = [];

//   List<Asset>? get selectedImages => _selectedImages;

//   void setImages(List<Asset> images) {
//     _selectedImages = images;
//     notifyListeners();
//   }

//   void addImage(Asset image) {
//     _selectedImages?.add(image);
//     notifyListeners();
//   }

//   void removeImage(Asset image) {
//     _selectedImages?.remove(image);
//     notifyListeners();
//   }

//   void clearImages() {
//     _selectedImages?.clear();
//     notifyListeners();
//   }

//   Future<void> uploadImagesToFirebase() async {
//     if (_selectedImages == null || _selectedImages!.isEmpty) {
//       return;
//     }

//     for (int i = 0; i < _selectedImages!.length; i++) {
//       Asset image = _selectedImages![i];
//       ByteData byteData = await image.getByteData();
//       List<int> imageData = byteData.buffer.asUint8List();

//       String fileName = DateTime.now().toString() + '_$i.jpg';

//       try {
//         await firebase_storage.FirebaseStorage.instance
//             .ref('images/$fileName')
//             .putData(imageData);
//       } on firebase_storage.FirebaseException catch (e) {
//         print(e);
//       }
//     }
//   }
// }
