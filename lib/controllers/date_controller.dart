import 'package:get/state_manager.dart';

class DateController extends GetxController {
  var startDate = DateTime(DateTime.now().year - 1).obs;
  var endDate = DateTime.now().obs;

  void setStartDate(DateTime date) {
    startDate.value =
        DateTime(date.year, date.month, date.day); // Normalizzare al giorno
  }

  void setEndDate(DateTime date) {
    endDate.value =
        DateTime(date.year, date.month, date.day); // Normalizzare al giorno
  }

  bool isWithinRange(DateTime date) {
    DateTime normalizedDate =
        DateTime(date.year, date.month, date.day); // Normalizzare al giorno
    return (normalizedDate.isAfter(startDate.value) ||
            normalizedDate.isAtSameMomentAs(startDate.value)) &&
        (normalizedDate.isBefore(endDate.value) ||
            normalizedDate.isAtSameMomentAs(endDate.value));
  }
}
