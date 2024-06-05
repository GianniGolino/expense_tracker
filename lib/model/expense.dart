import 'package:expense_tracker/model/expense_category.dart';
import 'package:expense_tracker/model/currency.dart';
import 'package:expense_tracker/model/helpers.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class Expense {
  final String id = const Uuid().v1();
  double amount;
  DateTime date;
  late final String emoji;
  Currency currency;
  ExpenseCategory category;

  Expense(
      {required this.amount,
      required this.date,
      //required this.emoji,
      required this.currency,
      required this.category}) {
    emoji = getEmoji(category);
  }

  String formattedDate(date) {
    final formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(date);
  }
}
