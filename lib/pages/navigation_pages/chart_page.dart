import 'package:expense_tracker/widgets/chart_listview_widget.dart';
import 'package:expense_tracker/widgets/chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ChartsPage extends StatelessWidget {
  const ChartsPage({super.key});

  @override
  Widget build(BuildContext context) {
    //dummy values to test fl_chart package

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
              child: const Padding(
                padding: EdgeInsets.all(24.0),
                child: ChartListViewWidget(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
