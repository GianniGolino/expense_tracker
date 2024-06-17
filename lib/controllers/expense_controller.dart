import 'package:get/state_manager.dart';
import '../model/expense.dart';

class ExpenseController extends GetxController {
  var expenseList = <Expense>[].obs;
  var filteredExpenseList = <Expense>[].obs;

  @override
  void onInit() {
    super.onInit();
    filterExpenses(); // Filtra le spese all'inizializzazione
  }

  void addExpense(Expense expense) {
    expenseList.add(expense);
    filterExpenses(); // Aggiorna la lista filtrata quando si aggiunge una nuova spesa
  }

  void removeExpense(int index) {
    expenseList.removeAt(index);
    filterExpenses(); // Aggiorna la lista filtrata quando si rimuove una spesa
  }

  void filterExpenses({DateTime? startDate, DateTime? endDate}) {
    DateTime effectiveStartDate =
        startDate ?? DateTime(DateTime.now().year - 1);
    DateTime effectiveEndDate = endDate ?? DateTime.now();

    filteredExpenseList.value = expenseList.where((expense) {
      return (expense.date.isAfter(effectiveStartDate) ||
          expense.date == effectiveStartDate &&
              expense.date.isBefore(effectiveEndDate) ||
          expense.date == effectiveEndDate);
      // return (expense.date.isAfter(effectiveStartDate) ||
      //         expense.date.isAtSameMomentAs(effectiveStartDate)) &&
      //     (expense.date.isBefore(effectiveEndDate) ||
      //         expense.date.isAtSameMomentAs(effectiveEndDate));
    }).toList();
  }
}
