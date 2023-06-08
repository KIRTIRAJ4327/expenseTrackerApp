import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Catagory {
  travel,
  food,
  lesiure,
  work,
} // enum used to define catagory types custom variable.

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
}
