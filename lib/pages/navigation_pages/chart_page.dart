import 'package:expense_tracker/controllers/date_controller.dart';
import 'package:expense_tracker/controllers/expense_controller.dart';
import 'package:expense_tracker/widgets/chart_listview_widget.dart';
import 'package:expense_tracker/widgets/chart_widget.dart';
import 'package:expense_tracker/widgets/filter_date_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ChartsPage extends StatelessWidget {
  const ChartsPage({super.key});

  @override
  Widget build(BuildContext context) {
    //nuovo
    final DateController dateController = Get.find();
    final ExpenseController expenseController = Get.find();

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Gap(32),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: SizedBox(height: 300, child: ChartWidget()),
          ),
          const Gap(48),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //nuovo
                    Expanded(
                      child: Obx(() {
                        // Usa la lista filtrata delle spese
                        expenseController.filterExpenses(
                            startDate: dateController.startDate.value,
                            endDate: dateController.endDate.value);
                        return ChartListViewWidget(
                            expenses: expenseController.filteredExpenseList);
                      }),
                    ),

                    // Expanded(
                    //     child: Container(child: const ChartListViewWidget())),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Material(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(
                              50), // Questo è opzionale per dare un effetto di arrotondamento
                          child: const Icon(
                            Icons.filter_list,
                            size: 35,
                          ),
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (ctx) {
                                  return const FilterDateWidget();
                                });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
