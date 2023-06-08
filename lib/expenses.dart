import 'package:expense/models/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  final List<Expense> _registerdExpens = [
    Expense(
        amount: 19.99,
        title: 'flutter course',
        time: DateTime.now(),
        catagory: Catagory.work),
    Expense(
        amount: 9.99,
        title: 'Cinema',
        time: DateTime.now(),
        catagory: Catagory.lesiure),
    Expense(
        amount: 1,
        title: 'Bus Terminal',
        time: DateTime.now(),
        catagory: Catagory.travel),
    Expense(
        amount: 13,
        title: 'Sub way',
        time: DateTime.now(),
        catagory: Catagory.food),
  ];
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          Text('this is chart data'),
          Text('This is tabs'),
        ],
      ),
    );
  }
}
