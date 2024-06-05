import 'package:get/state_manager.dart';

import '../model/expense.dart';

class ExpenseController extends GetxController {
  var expenseList = <Expense>[].obs;

  void addExpense(Expense expense) {
    expenseList.add(expense);
  }

  void removeExpense(int index) {
    expenseList.removeAt(index);
  }
}
