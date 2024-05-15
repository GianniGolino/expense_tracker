import 'package:expense_tracker/model/currency.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/model/expense_category.dart';
import 'package:expense_tracker/pages/navigation_pages/body_home_page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class AddExpenseWidget extends StatefulWidget {
  const AddExpenseWidget({super.key, this.onExpenseAdded, this.expenseToEdit});

  final void Function(Expense)? onExpenseAdded;
  final Expense? expenseToEdit;

  @override
  State<AddExpenseWidget> createState() => _AddExpenseWidgetState();
}

class _AddExpenseWidgetState extends State<AddExpenseWidget> {
  final TextEditingController importController = TextEditingController();
  String _buttonText = 'Aggiungi';
  String _selectedCurrency = 'EUR';
  String _selectedCategory = '🛍️ Shopping';
  DateTime? _selectedDate = DateTime.now();
  final List<String> _categories = [
    '🛒 Spese cibo e casa',
    '🏥 Spese mediche',
    '🍸 Cene ed aperitivi',
    '🎾 Padel',
    '🛍️ Shopping',
    '💲 Abbonamenti'
  ];
  @override
  void initState() {
    if (expenseToEdit != null) {
      importController.text = expenseToEdit!.amount.toString();
      _selectedDate = expenseToEdit!.date;
      _selectedCurrency = getCurrencyString(expenseToEdit!.currency);
      _selectedCategory = getCategoryString(expenseToEdit!.category);
      _buttonText = 'Salva';
      expenseToEdit = null;
    }
    super.initState();
  }

  @override
  void dispose() {
    importController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      child: Column(
        children: [
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF005757)),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    controller: importController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      label: Text('Aggiungi un mporto'),
                    ),
                  ),
                ),
                const Spacer(),
                Expanded(
                  child: DropdownButton(
                    underline: const SizedBox(),
                    value: _selectedCurrency,
                    items: const [
                      DropdownMenuItem(
                        value: 'EUR',
                        child: Text('EUR'),
                      ),
                      DropdownMenuItem(
                        value: 'USD',
                        child: Text('USD'),
                      ),
                      DropdownMenuItem(value: 'GBP', child: Text('GBP'))
                    ],
                    // items: Currency.values
                    //     .map((currency) => DropdownMenuItem(
                    //         value: currency,
                    //         child: Text(currency.name.toString())))
                    //     .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCurrency = value!;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          const Gap(16),
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF005757)),
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DropdownButton(
                  value: _selectedCategory,
                  items: _categories
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value!;
                    });
                  },
                  underline: const SizedBox(),
                ),
                const Gap(8),
              ],
            ),
          ),
          const Gap(16),
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF005757)),
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  _selectedDate == null
                      ? 'Aggiungi una data'
                      : formattedDate(_selectedDate),
                  style: const TextStyle(color: Colors.black),
                ),
                const Gap(8),
                IconButton(
                    onPressed: () async {
                      final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(DateTime.now().year - 10,
                              DateTime.now().month, DateTime.now().day),
                          lastDate: DateTime.now());
                      setState(() {
                        _selectedDate = pickedDate;
                      });
                    },
                    icon: Icon(
                      Icons.calendar_month_outlined,
                      color: Theme.of(context).primaryColor,
                    ))
              ],
            ),
          ),
          const Gap(32),
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
                        if (addExpense() != null) {
                          widget.onExpenseAdded!(addExpense()!);
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text(_buttonText,
                          style: const TextStyle(color: Colors.white)),
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }

  Expense? addExpense() {
    final double? enteredImport = double.tryParse(importController.text);
    if (enteredImport == null || enteredImport <= 0 || _selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text('Dati non validi'),
              content: const Text(
                  'Assicurarsi di inserire un importo valido ed una data.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text('Indietro'),
                ),
              ],
            );
          });
      return null;
    } else {
      return Expense(
          amount: enteredImport,
          date: _selectedDate!,
          currency: getCurrency(_selectedCurrency),
          category: getCategory(_selectedCategory));
    }
  }

  void updateExpense() {
    final double? enteredImport = double.tryParse(importController.text);
    if (enteredImport == null || enteredImport <= 0 || _selectedDate == null) {
      // Show error dialog
      return;
    }

    final updatedExpense = Expense(
      // Assuming there's an ID for each expense
      amount: enteredImport,
      date: _selectedDate!,
      currency: getCurrency(_selectedCurrency),
      category: getCategory(_selectedCategory),
    );
    // Pass the updated expense to the callback function
    widget.onExpenseAdded!(updatedExpense);
  }
  // void updateExpense() {
  //   final double? enteredImport = double.tryParse(importController.text);
  //   if (enteredImport == null || enteredImport <= 0 || _selectedDate == null) {
  //     // Show error dialog
  //     return;
  //   }

  //   final updatedExpense = Expense(
  //     // Assuming there's an ID for each expense
  //     amount: enteredImport,
  //     date: _selectedDate!,
  //     currency: getCurrency(_selectedCurrency),
  //     category: getCategory(_selectedCategory),
  //   );
  //   // Pass the updated expense to the callback function
  //   widget.onExpenseAdded(updatedExpense);
  // }

  Currency getCurrency(String selectedValue) {
    if (selectedValue == 'EUR') {
      return Currency.euro;
    } else if (selectedValue == 'USD') {
      return Currency.dollar;
    } else {
      return Currency.britishPound;
    }
  }

  String getCurrencyString(Currency existingCurrency) {
    if (existingCurrency == Currency.euro) {
      return 'EUR';
    } else if (existingCurrency == Currency.dollar) {
      return 'USD';
    } else {
      return 'GBP';
    }
  }

  ExpenseCategory getCategory(String selectedCategory) {
    switch (selectedCategory) {
      case '🛒 Spese cibo e casa':
        return ExpenseCategory.grocery;
      case '🏥 Spese mediche':
        return ExpenseCategory.medical;
      case '🍸 Cene ed aperitivi':
        return ExpenseCategory.restaurantsAndBars;
      case '🎾 Padel':
        return ExpenseCategory.padel;
      case '🛍️ Shopping':
        return ExpenseCategory.shopping;
      case '💲 Abbonamenti':
        return ExpenseCategory.subscriptions;
      default:
        return ExpenseCategory.shopping;
    }
  }

  String getCategoryString(existingCategory) {
    switch (existingCategory) {
      case ExpenseCategory.grocery:
        return '🛒 Spese cibo e casa';
      case ExpenseCategory.medical:
        return '🏥 Spese mediche';
      case ExpenseCategory.restaurantsAndBars:
        return '🍸 Cene ed aperitivi';
      case ExpenseCategory.padel:
        return '🎾 Padel';
      case ExpenseCategory.shopping:
        return '🛍️ Shopping';
      case ExpenseCategory.subscriptions:
        return '💲 Abbonamenti';
      default:
        return '🛍️ Shopping';
    }
  }

  String formattedDate(date) {
    final formatter = DateFormat('dd-MMM-yyyy');
    return formatter.format(date);
  }
}
