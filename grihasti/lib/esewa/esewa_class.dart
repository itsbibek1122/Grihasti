// import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
// import 'package:esewa_flutter_sdk/esewa_config.dart';
// import 'package:grihasti/constant/esewa.dart';

// import 'package:esewa_flutter_sdk/esewa_payment.dart';
// import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
// import 'package:grihasti/screens/booked/book_property.dart';
// import 'package:grihasti/utils/showSnackBar.dart';

// class Esewa {
//   pay() {
//     try {
//       EsewaFlutterSdk.initPayment(
//           esewaConfig: EsewaConfig(
//               clientId: kEsewaClientId,
//               secretId: kEsewaSecretKey,
//               environment: Environment.test),
//           esewaPayment: EsewaPayment(
//             productId: "1d71jd81",
//             productName: "Product One",
//             productPrice: "20",
//           ),
//           onPaymentSuccess: (EsewaPaymentSuccessResult result) async {
//             print('payment success');
//           },
//           onPaymentFailure: () {
//             print('payment faliure');
//           },
//           onPaymentCancellation: () {
//             print('payment canceled');
//           });
//     } catch (e) {
//       print('Payment exception');
//     }
//   }
// }
