import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/model/helpers.dart';
import 'package:expense_tracker/pages/navigation_pages/body_home_page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AddExpenseWidget extends StatefulWidget {
  const AddExpenseWidget(
      {super.key,
      this.onExpenseAdded,
      this.expenseToEdit,
      this.onExpenseEdited});

  final void Function(Expense)? onExpenseAdded;
  final void Function(Expense)? onExpenseEdited;
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
    if (widget.expenseToEdit != null) {
      importController.text = widget.expenseToEdit!.amount.toString();
      _selectedDate = widget.expenseToEdit!.date;
      _selectedCurrency = getCurrencyString(widget.expenseToEdit!.currency);
      _selectedCategory = getCategoryString(widget.expenseToEdit!.category);
      _buttonText = 'Salva';
      //expenseToEdit = null;
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
                      : formattedDateAsddMMMyyyy(_selectedDate),
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
                        //TODO capire se si può usare un valore scriminante diverso da _buttonText
                        //TODO fare prova con vecchio codice

                        if (expenseToEdit == null) {
                          if (addExpense() != null) {
                            widget.onExpenseAdded!(addExpense()!);
                          } else {
                            showCustomDialogue(context);
                          }
                        } else {
                          if (updateExpense() != null) {
                            widget.onExpenseEdited!(updateExpense()!);
                          } else {
                            showCustomDialogue(context);
                          }
                        }
                        Navigator.of(context).pop();
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
      showCustomDialogue(context);
      return null;
    } else {
      return Expense(
          amount: enteredImport,
          date: _selectedDate!,
          currency: getCurrency(_selectedCurrency),
          category: getCategory(_selectedCategory));
    }
  }

  //nuovo
  Expense? updateExpense() {
    final double? enteredImport = double.tryParse(importController.text);
    if (enteredImport == null || enteredImport <= 0 || _selectedDate == null) {
      showCustomDialogue(context);
      return null;
    } else {
      Expense updatedExpense = Expense(
          amount: enteredImport,
          date: _selectedDate!,
          currency: getCurrency(_selectedCurrency),
          category: getCategory(_selectedCategory));
      return updatedExpense;
    }
  }
}
