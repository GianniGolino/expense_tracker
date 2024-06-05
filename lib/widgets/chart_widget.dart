import 'package:expense_tracker/controllers/expense_controller.dart';
import 'package:expense_tracker/model/expense_category.dart';
import 'package:expense_tracker/model/helpers.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChartWidget extends StatelessWidget {
  const ChartWidget({super.key});

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

      return PieChart(
        PieChartData(
          sectionsSpace: 10,
          centerSpaceRadius: double.infinity,
          sections: categoryTotals.entries.map((entry) {
            return PieChartSectionData(
              radius: 60,
              value: entry.value,
              showTitle: false,
              color: const Color.fromARGB(255, 30, 153, 153),
              badgeWidget: Text(
                getEmoji(entry.key),
                style: const TextStyle(fontSize: 25),
              ),
            );
          }).toList(),
        ),
      );
    });
  }
}
