import 'package:expenses_/models/expense.dart';
import 'package:expenses_/widgets/charts/chart_bar.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<Expense> expenses;

  List<ExpensesBucket> get bucktes {
    return [
      ExpensesBucket.forCategory(expenses, Category.courses),
      ExpensesBucket.forCategory(expenses, Category.faculty),
      ExpensesBucket.forCategory(expenses, Category.fun),
    ];
  }

  double get maxTotalExpenses {
    double maxTotalExpenses = 0;
    for (var element in bucktes) {
      if (element.totalExpenses > maxTotalExpenses) {
        maxTotalExpenses = element.totalExpenses;
      }
    }
    return maxTotalExpenses;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final ele in bucktes)
                  ChartBar(
                    fill: ele.totalExpenses == 0
                        ? 0
                        : ele.totalExpenses / maxTotalExpenses,
                  ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: bucktes
                .map(
                  (e) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        CategoryIcons[e.category],
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
