import 'package:expense_tracker/controllers/date_controller.dart';
import 'package:expense_tracker/controllers/expense_controller.dart';
import 'package:expense_tracker/model/helpers.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

class FilterDateWidget extends StatelessWidget {
  const FilterDateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //nuovo
    final DateController dateController = Get.find();

    final ExpenseController expenseController = Get.find();

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    showDatePicker(
                            context: (context),
                            initialDate: DateTime.now(),
                            firstDate: DateTime(DateTime.now().year - 10),
                            lastDate: DateTime.now())
                        .then((pickedDate) {
                      if (pickedDate != null &&
                          pickedDate != dateController.startDate.value) {
                        dateController.setStartDate(pickedDate);
                      }
                    });
                  },
                  icon: Icon(
                    size: 30,
                    Icons.calendar_month_outlined,
                    color: Theme.of(context).primaryColor,
                  )),
              const Gap(8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dal giorno:',
                      style: TextStyle(
                          fontSize: 16, color: Theme.of(context).primaryColor),
                    ),
                    const Gap(4),
                    Obx(() {
                      return Text(formattedDateAsddMMMyyyy(
                          dateController.startDate.value));
                    }),
                  ],
                ),
              ),
              SizedBox(
                height:
                    32, // Puoi regolare l'altezza in base alle tue necessità
                child: VerticalDivider(
                  thickness: 2,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Al giorno:',
                        style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).primaryColor)),
                    const Gap(4),
                    Obx(() {
                      return Text(formattedDateAsddMMMyyyy(
                          dateController.endDate.value));
                    }),
                  ],
                ),
              ),
              const Gap(8),
              IconButton(
                  onPressed: () {
                    showDatePicker(
                            context: (context),
                            initialDate: DateTime.now(),
                            firstDate: DateTime(DateTime.now().year - 10),
                            lastDate: DateTime.now())
                        .then((pickedDate) {
                      if (pickedDate != null &&
                          pickedDate != dateController.endDate.value) {
                        dateController.setEndDate(pickedDate);
                      }
                    });
                  },
                  icon: Icon(
                    size: 30,
                    Icons.calendar_month_outlined,
                    color: Theme.of(context).primaryColor,
                  )),
            ],
          ),
          const Gap(16),
          Row(
            children: [
              Expanded(
                  child: SizedBox(
                height: 55,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        backgroundColor: Theme.of(context).primaryColor),
                    onPressed: () {
                      //nuovo
                      expenseController.filterExpenses(
                        startDate: dateController.startDate.value,
                        endDate: dateController.endDate.value,
                      );
                      Navigator.of(context).pop();
                    },
                    child: const Text('Filtra',
                        style: TextStyle(color: Colors.white, fontSize: 16))),
              )),
            ],
          ),
          const Gap(4),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Indietro',
                    style: TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
