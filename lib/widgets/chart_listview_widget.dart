import 'package:expense_tracker/controllers/expense_controller.dart';
import 'package:expense_tracker/model/expense_category.dart';
import 'package:expense_tracker/model/helpers.dart';
import 'package:expense_tracker/pages/navigation_pages/body_home_page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

class ChartListViewWidget extends StatelessWidget {
  const ChartListViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ExpenseController expenseController = Get.find<ExpenseController>();

    return Obx(() {
      final Map<ExpenseCategory, double> categoryTotals = {};

      for (var expense in expenseController.expenseList) {
        if (categoryTotals.containsKey(expense.category)) {
          categoryTotals[expense.category] =
              categoryTotals[expense.category]! + expense.amount;
        } else {
          categoryTotals[expense.category] = expense.amount;
        }
      }

      final List<MapEntry<ExpenseCategory, double>> groupedExpensesList =
          categoryTotals.entries.toList();

      return ListView.separated(
        itemBuilder: (context, index) {
          return Row(
            children: [
              Text(
                '${getCategoryString(groupedExpensesList[index].key)}:',
                style: const TextStyle(fontSize: 20),
              ),
              const Gap(8),
              Text('${groupedExpensesList[index].value.toStringAsFixed(2)}€',
                  style: const TextStyle(fontSize: 20)),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('-', style: TextStyle(fontSize: 20)),
              ),
              Text(
                  '${((groupedExpensesList[index].value / totalExpense) * 100).toStringAsFixed(2)}%',
                  style: const TextStyle(fontSize: 20)),
              //Text(totalExpense.toString())
            ],
          );
        },
        separatorBuilder: (context, index) => const Divider(
          height: 18,
          color: Colors.transparent,
        ),
        itemCount: groupedExpensesList.length,
      );
    });
  }
}
