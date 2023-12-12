import 'package:expenses_/models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesItem extends StatelessWidget {
  const ExpensesItem({super.key, required this.expense});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 14, 114, 107),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expense.title,style:Theme.of(context).textTheme.titleLarge),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Text("${expense.amount.toStringAsFixed(2)}\$",style: const TextStyle(color: Colors.white),),
                const Spacer(),
                Row(
                  children: [
                    Icon(CategoryIcons[expense.category],color: Colors.white,),
                    const SizedBox(width: 8,),
                    Text(expense.formattedDate,style: const TextStyle(color: Colors.white),),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
