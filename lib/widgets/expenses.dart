import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpenseState();
  }
}

class _ExpenseState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(title: "Flutter Course", amount: 13.99, date: DateTime.now(), category: Category.work),
    Expense(title: "Groceries", amount: 50.00, date: DateTime.now(), category: Category.food),
    Expense(title: "New Shoes", amount: 99.99, date: DateTime.now(), category: Category.leisure),
    Expense(title: "Flight to Paris", amount: 300.00, date: DateTime.now(), category: Category.travel),
    Expense(title: "Books", amount: 30.00, date: DateTime.now(), category: Category.leisure)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: Column (
        children: [
          const Text('chart'),
          Expanded (child: ExpensesList(expenses: _registeredExpenses))
        ]
      )
    );
  }
}
