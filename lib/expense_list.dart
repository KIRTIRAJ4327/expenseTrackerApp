import 'package:expense/expenses.dart';
import 'package:expense/models/expense.dart';

import 'package:flutter/widgets.dart';

// class ExpenseList extends StatelessWidget {
//   ExpenseList({super.key, required this.expenses});
//   final List<Expense> expenses;
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: expenses.length,
//       itemBuilder: (context, index) => Text(expenses[index].title),
//     );
//   }
// }
class ExpenseList extends StatelessWidget {
  ExpenseList({super.key, required this.expenses});
  final List<Expense> expenses;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) => Text(expenses[index].title));
  }
}
