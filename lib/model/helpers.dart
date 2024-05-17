import 'package:expense_tracker/model/currency.dart';
import 'package:expense_tracker/model/expense_category.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void showCustomDialogue(BuildContext context) {
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
}

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

String formattedDateAsddMMMyyyy(date) {
  final formatter = DateFormat('dd-MMM-yyyy');
  return formatter.format(date);
}

//TODO to potentially delete if we rename the currecy enum values and use them directly
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

String formattedDateAsddMMM(date) {
  final formatter = DateFormat('dd-MMM');
  return formatter.format(date);
}
