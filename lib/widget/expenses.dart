import 'package:expense/widget/expense_list/expense_list.dart';
import 'package:expense/models/expense.dart';
import 'package:expense/widget/new_Expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
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

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
        onAddexpense: _addExpense,
      ),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registerdExpens.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registerdExpens.indexOf(expense);
    setState(() {
      _registerdExpens.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense Deleted'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registerdExpens.insert(expenseIndex, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget maincontent = const Center(
      child: Text('No Expenses found. Staart adding some!! '),
    );
    if (_registerdExpens.isNotEmpty) {
      maincontent = ExpenseList(
        expenses: _registerdExpens,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker app"),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          const Text('this is chart data'),
          Expanded(
            child: maincontent,
          ),
        ],
      ),
    );
  }
}
