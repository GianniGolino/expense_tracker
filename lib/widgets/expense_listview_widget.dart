import 'package:expense_tracker/model/currency.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/model/expense_category.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class ExpenseListViewWidget extends StatefulWidget {
  const ExpenseListViewWidget(
      {super.key,
      required this.expenseList,
      required this.onDeletion,
      required this.onEdit});

  final List<Expense> expenseList;
  final void Function(double) onDeletion;
  final void Function(Expense) onEdit;

  @override
  State<ExpenseListViewWidget> createState() => _ExpenseListViewWidgetState();
}

class _ExpenseListViewWidgetState extends State<ExpenseListViewWidget> {
  @override
  Widget build(BuildContext context) {
    return GroupedListView(
      elements: widget.expenseList,
      groupBy: (expense) =>
          DateTime(expense.date.year, expense.date.month, expense.date.day),
      order: GroupedListOrder.DESC,
      groupSeparatorBuilder: (value) {
        return Padding(
          padding: const EdgeInsets.only(left: 28.0, bottom: 8, top: 8),
          child: Text(formattedDate(value)),
        );
      },
      separator: const SizedBox(height: 8),
      indexedItemBuilder: (context, element, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        )
                      ],
                      border: Border.all(
                        width: 2,
                        color: const Color(0xFF005757),
                      ),
                      color: const Color(0xFFF4F6FB),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  height: 90,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                    child: Row(
                      children: [
                        Text(
                          widget.expenseList[index].emoji,
                          style: const TextStyle(fontSize: 32),
                        ),
                        const Gap(16),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              showCategory(widget.expenseList[index].category),
                              style: const TextStyle(fontSize: 16),
                            ),
                            Row(
                              children: [
                                Text(
                                  widget.expenseList[index].amount
                                      .toStringAsFixed(2),
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const Gap(4),
                                Text(showCurrency(
                                    widget.expenseList[index].currency))
                              ],
                            ),
                            Text(
                              widget.expenseList[index].formattedDate(
                                  widget.expenseList[index].date),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              widget.onEdit(widget.expenseList[index]);
                            });
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Color(0xFF005757),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              widget
                                  .onDeletion(widget.expenseList[index].amount);
                              widget.expenseList.removeAt(index);
                            });
                          },
                          icon: const Icon(Icons.delete,
                              color: Color(0xFF005757)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  //TODO to potentially delete if we rename the currency enum values and use them directly
  String showCurrency(Currency currency) {
    switch (currency) {
      case Currency.euro:
        return 'EUR';
      case Currency.dollar:
        return 'USD';
      case Currency.britishPound:
        return 'GBP';
      default:
        return 'EUR';
    }
  }

  String showCategory(ExpenseCategory category) {
    switch (category) {
      case ExpenseCategory.medical:
        return 'Spese mediche';
      case ExpenseCategory.grocery:
        return 'Spese cibo e casa';
      case ExpenseCategory.restaurantsAndBars:
        return 'Cene ed aperitivi';
      case ExpenseCategory.padel:
        return 'Padel';
      case ExpenseCategory.shopping:
        return 'Shopping';
      case ExpenseCategory.subscriptions:
        return 'Abbonamenti';
      default:
        return '';
    }
  }

  String formattedDate(date) {
    final formatter = DateFormat('dd-MMM');
    return formatter.format(date);
  }
}
