import 'package:expenses_/models/expense.dart';
import 'package:expenses_/widgets/charts/chart.dart';
import 'package:expenses_/widgets/new_expenses.dart';
import 'package:flutter/material.dart';
import 'expenses_list/expesesList.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
   final List<Expense> _registerExpenses = [
    Expense(
      category: Category.courses,
      title: "flutter course",
      amount: 29,
      date: DateTime.now(),
    ),
    Expense(
      category: Category.faculty,
      title: "Transform",
      amount: 15,
      date: DateTime.now(),
    ),
    Expense(
      category: Category.fun,
      title: "nodlls",
      amount: 10,
      date: DateTime.now(),
    ),
  ];

  void _addExpense(Expense expense){
    setState(() {
      _registerExpenses.add(expense);
    });
  }
  void _removeExpense(Expense expense){
    setState(() {
      _registerExpenses.remove(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 14, 114, 107),
        title: const Center(child: Text("Expenses app",style: TextStyle(color: Colors.white),)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Chart(expenses: _registerExpenses),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ExpensesList(
                expenses: _registerExpenses,
                removeExpense: _removeExpense,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        focusColor: const Color.fromARGB(255, 8, 78, 74),
        backgroundColor: const Color.fromARGB(255, 14, 114, 107),
        onPressed: () {
          setState(() {
            showModalBottomSheet(
              backgroundColor:const Color.fromARGB(255, 14, 114, 107),
              context: context,
              builder: (e) => NewExpenses(addExpense: _addExpense,),
            );
          });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
