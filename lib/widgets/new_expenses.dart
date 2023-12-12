import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expenses_/models/expense.dart';

class NewExpenses extends StatefulWidget {
  const NewExpenses({super.key, required this.addExpense});

  final void Function(Expense expense) addExpense;

  @override
  State<NewExpenses> createState() => _NewExpensesState();
}

class _NewExpensesState extends State<NewExpenses> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime? _SelectedDate;
  Category _SelectedCategory = Category.courses;

  final formatter = DateFormat().add_yMd();

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            style: const TextStyle(color: Colors.white),
            controller: _titleController,
            keyboardType: TextInputType.text,
            maxLength: 50,
            decoration: const InputDecoration(
              focusColor: Colors.white,
              label: Text(
                'Title',
                style: TextStyle(color: Colors.white),
              ),
              labelStyle: TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(22),
                ),
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(22),
                ),
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 2,
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '\$',
                    prefixStyle: TextStyle(color: Colors.white),
                    focusColor: Colors.white,
                    label: Text(
                      'price',
                      style: TextStyle(color: Colors.white),
                    ),
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(22),
                      ),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(22),
                      ),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _SelectedDate == null
                          ? 'No selected date'
                          : formatter.format(_SelectedDate!),
                      style: const TextStyle(color: Colors.white),
                    ),
                    IconButton(
                      onPressed: () async {
                        final now = DateTime.now();
                        final firstDate =
                            DateTime(now.year - 1, now.month, now.day);
                        final choosedDate = await showDatePicker(
                            context: context,
                            initialDate: now,
                            firstDate: firstDate,
                            lastDate: now);
                        setState(() {
                          _SelectedDate = choosedDate;
                        });
                      },
                      icon: const Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                child: DropdownButton(
                  value: _SelectedCategory,
                  iconEnabledColor: Colors.white,
                  dropdownColor: const Color.fromARGB(255, 14, 114, 107),
                  items: Category.values
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e.name,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _SelectedCategory = value ;
                    });
                  },
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final double? enteredAmount =
                          double.tryParse(_amountController.text);
                      final bool isVaild =
                          enteredAmount == null || enteredAmount <= 0;
                      if (_titleController.text.trim().isEmpty ||
                          _amountController.text.trim().isEmpty ||
                          _SelectedDate == null ||
                          isVaild) {
                        showDialog(
                          context: context,
                          builder: (ctx) {
                            return AlertDialog(
                              icon: const Icon(
                                Icons.error,
                                color: Colors.white,
                              ),
                              backgroundColor:
                                  const Color.fromARGB(255, 14, 114, 107),
                              title: const Text(
                                'Error',
                                style: TextStyle(color: Colors.white),
                              ),
                              content: const Text(
                                'Something is empty or wrong',
                                style: TextStyle(color: Colors.white),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx),
                                  child: const Text(
                                    'Okay',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }
                      else{
                        widget.addExpense(
                        Expense(
                          category: _SelectedCategory,
                          title: _titleController.text,
                          amount: enteredAmount,
                          date: _SelectedDate!,
                        ),
                      );
                      Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      "Saved Expenses",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
