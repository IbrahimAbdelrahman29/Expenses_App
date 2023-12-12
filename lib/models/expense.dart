import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final dateformat = DateFormat().add_yMd();

enum Category { faculty, courses, fun }

const CategoryIcons = {
  Category.courses: Icons.work,
  Category.faculty: Icons.school,
  Category.fun: Icons.fastfood_rounded,
};

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return dateformat.format(date);
  }

  Expense(
      {required this.category,
      required this.title,
      required this.amount,
      required this.date})
      : id = uuid.v4();
}

class ExpensesBucket {
  final Category category;
  final List<Expense> expenses;

  ExpensesBucket(this.expenses, this.category);
  ExpensesBucket.forCategory(List<Expense> allexpenses, this.category)
      : expenses = allexpenses
            .where((element) => element.category == category)
            .toList();

  double get totalExpenses{
    double sum=0;
    for (var expense in expenses) {
      sum+=expense.amount;
    }
    return sum;
  }
}
