import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

enum Catagory {
  travel,
  food,
  lesiure,
  work,
} // enum used to define catagory types custom variable.

const catagoryIcons = {
  Catagory.food: Icons.lunch_dining,
  Catagory.travel: Icons.travel_explore,
  Catagory.lesiure: Icons.restaurant,
  Catagory.work: Icons.work,
};

class Expense {
  Expense(
      {required this.amount,
      required this.title,
      required this.time,
      required this.catagory})
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime time;
  final Catagory catagory;

  get formattedDate {
    return formatter.format(time);
  }
}

class Expensebucket {
  const Expensebucket({
    required this.catagory,
    required this.expenses,
  });
  Expensebucket.forCatagory(
    List<Expense> allExpenses,
    this.catagory,
  ) : expenses = allExpenses
            .where((expense) => expense.catagory == catagory)
            .toList();
  final Catagory catagory;
  final List<Expense> expenses;
  double get totalExpense {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
