import 'package:expense_tracker/model/expense_category.dart';
import 'package:expense_tracker/model/currency.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widgets/add_expense_widget.dart';
import 'package:expense_tracker/widgets/expense_listview_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BodyHomePage extends StatefulWidget {
  const BodyHomePage({super.key});

  @override
  State<BodyHomePage> createState() => _BodyHomePageState();
}

Expense? expenseToEdit;
int currentIndex = 0;
final expense = Expense(
    amount: 250,
    date: DateTime.now(),
    currency: Currency.euro,
    category: ExpenseCategory.medical);
final expense2 = Expense(
    amount: 100,
    date: DateTime.now(),
    currency: Currency.euro,
    category: ExpenseCategory.padel);

final List<Expense> expenseList = [expense, expense2];
double totalExpense = 350;
double todayExpenses = 0;

class _BodyHomePageState extends State<BodyHomePage> {
  @override
  Widget build(BuildContext context) {
    expenseList.sort(
      (a, b) => b.date.compareTo(a.date),
    );

    getTodayExpenses();

    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Ciao Gianni!',
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                          const Gap(8),
                          Text(
                            'Oggi hai speso: $todayExpenses',
                            style: const TextStyle(
                                fontSize: 22, color: Colors.white),
                          ),
                          const Gap(8),
                          Text(
                            'Spese totali: $totalExpense',
                            style: const TextStyle(
                                fontSize: 22, color: Colors.white),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return AddExpenseWidget(
                                          onExpenseAdded: (p0) {
                                        setState(() {
                                          expenseList.add(p0);
                                          totalExpense += p0.amount;
                                        });
                                      });
                                    });
                              },
                              icon: const Icon(
                                size: 32,
                                Icons.add_circle_outline,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  color: Color(0xFFF4F6FB),
                  borderRadius: BorderRadiusDirectional.vertical(
                      top: Radius.circular(30))),
              //height: 200,
              child: Column(
                children: [
                  const Gap(12),
                  Expanded(
                    child: ExpenseListViewWidget(
                      expenseList: expenseList,
                      onDeletion: (p0) {
                        setState(() {
                          totalExpense -= p0;
                        });
                      },
                      onEdit: (p0) {
                        setState(() {
                          expenseToEdit = p0;
                        });
                        showModalBottomSheet(
                            context: context,
                            builder: (ctx) {
                              return AddExpenseWidget(
                                expenseToEdit: expenseToEdit,
                              );
                            });
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  double getTodayExpenses() {
    todayExpenses = 0;
    final now = DateTime.now();
    for (Expense expense in expenseList) {
      if (expense.date.year == now.year &&
          expense.date.month == now.month &&
          expense.date.day == now.day) {
        todayExpenses += expense.amount;
      }
    }
    return todayExpenses;
  }
}
