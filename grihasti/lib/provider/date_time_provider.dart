import 'package:flutter/foundation.dart';

class DatePickerState extends ChangeNotifier {
  DateTime? selectedDate;
  bool isDateSelected = false;

  void setSelectedDate(DateTime date) {
    selectedDate = date;
    isDateSelected = true;
    notifyListeners();
  }
}
