import 'package:expense_tracker/pages/navigation_pages/body_home_page.dart';
import 'package:expense_tracker/pages/navigation_pages/calendar_page.dart';
import 'package:expense_tracker/pages/navigation_pages/chart_page.dart';
import 'package:expense_tracker/pages/navigation_pages/settings_page.dart';
import 'package:expense_tracker/widgets/bottom_nav_bar_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> pagesList = [
      const BodyHomePage(),
      //homePageBuilder(context),
      const ChartsPage(),
      const CalendarPage(),
      const SettingsPage(),
    ];
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: pagesList[currentIndex],
      bottomNavigationBar: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: BottomNavBarWidget(onTabChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        }),
      ),
    );
  }
}

// Widget homePageBuilder(BuildContext context) {
//   final expense = Expense(
//       amount: 250,
//       date: DateTime.now(),
//       emoji: '🏥',
//       currency: Currency.euro,
//       category: ExpenseCategory.medical);
//   final expense2 = Expense(
//       amount: 100,
//       date: DateTime.now(),
//       emoji: '🎾',
//       currency: Currency.euro,
//       category: ExpenseCategory.padel);
//   final List<Expense> expenseList = [expense, expense2];
//   return SafeArea(
//     child: Column(
//       children: [
//         SizedBox(
//           height: 200,
//           child: Padding(
//             padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Ciao Gianni!',
//                           style: TextStyle(fontSize: 22, color: Colors.white),
//                         ),
//                         Gap(8),
//                         Text(
//                           'Spese totali: 2.626 €',
//                           style: TextStyle(fontSize: 22, color: Colors.white),
//                         ),
//                       ],
//                     ),
//                     Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                             onPressed: () {
//                               showModalBottomSheet(
//                                   context: context,
//                                   builder: (context) {
//                                     return const Expanded(
//                                         child: SizedBox(
//                                       height: double.infinity,
//                                       width: double.infinity,
//                                       child: Text('Test'),
//                                     ));
//                                   });
//                             },
//                             icon: const Icon(
//                               size: 32,
//                               Icons.add_circle_outline,
//                               color: Colors.white,
//                             ))
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Expanded(
//           child: Container(
//             decoration: const BoxDecoration(
//                 color: Color(0xFFF4F6FB),
//                 borderRadius:
//                     BorderRadiusDirectional.vertical(top: Radius.circular(50))),
//             height: 200,
//             child: Column(
//               children: [
//                 const Gap(32),
//                 Expanded(
//                   child: ListView.separated(
//                     itemBuilder: (context, index) {
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.grey.withOpacity(0.4),
//                                         spreadRadius: 2,
//                                         blurRadius: 10,
//                                         offset: const Offset(0, 3),
//                                       )
//                                     ],
//                                     border: Border.all(
//                                       width: 2,
//                                       color: const Color(0xFF005757),
//                                     ),
//                                     color: const Color(0xFFF4F6FB),
//                                     borderRadius: const BorderRadius.all(
//                                         Radius.circular(20))),
//                                 height: 80,
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 12.0, vertical: 8.0),
//                                   child: Row(
//                                     children: [
//                                       const Text(
//                                         '🏥',
//                                         style: TextStyle(fontSize: 32),
//                                       ),
//                                       const Gap(16),
//                                       Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             showCategory(
//                                                 expenseList[index].category),
//                                             style:
//                                                 const TextStyle(fontSize: 16),
//                                           ),
//                                           Row(
//                                             children: [
//                                               Text(
//                                                 expenseList[index]
//                                                     .amount
//                                                     .toString(),
//                                                 style: const TextStyle(
//                                                     fontSize: 16),
//                                               ),
//                                               const Gap(4),
//                                               Text(showCurrency(
//                                                   expenseList[index].currency))
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                       const Spacer(),
//                                       IconButton(
//                                         onPressed: () {},
//                                         icon: const Icon(
//                                           Icons.edit,
//                                           color: Color(0xFF005757),
//                                         ),
//                                       ),
//                                       IconButton(
//                                         onPressed: () {

//                                         },
//                                         icon: const Icon(Icons.delete,
//                                             color: Color(0xFF005757)),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                     separatorBuilder: (context, index) {
//                       return const Divider(
//                         color: Colors.transparent,
//                       );
//                     },
//                     itemCount: expenseList.length,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         )
//       ],
//     ),
//   );
// }

// String showCategory(ExpenseCategory category) {
//   switch (category) {
//     case ExpenseCategory.medical:
//       return 'Spese mediche';
//     case ExpenseCategory.grocery:
//       return 'Spese cibo e casa';
//     case ExpenseCategory.restaurantsAndBars:
//       return 'Cene ed aperitivi';
//     case ExpenseCategory.padel:
//       return 'Padel';
//     case ExpenseCategory.shopping:
//       return 'Shopping';
//     case ExpenseCategory.subscriptions:
//       return 'Abbonamenti';
//     default:
//       return '';
//   }
// }

// String showCurrency(Currency currency) {
//   switch (currency) {
//     case Currency.euro:
//       return '€';
//     case Currency.dollar:
//       return '\$';
//     case Currency.britishPound:
//       return '£';
//     default:
//       return '';
//   }
// }
