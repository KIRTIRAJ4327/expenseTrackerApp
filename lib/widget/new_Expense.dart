import 'dart:io';

import 'package:expense/models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddexpense});
  final void Function(Expense expense) onAddexpense;

  @override
  State<NewExpense> createState() {
    // TODO: implement createState
    return NewExpenseState();
  }
}

class NewExpenseState extends State<NewExpense> {
  DateTime? selectedDate;
  Catagory _selectCatagory = Catagory.lesiure;
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final now = DateTime.now();
  final firstDate = DateTime(2022);
  final lastDate = DateTime(2025);
  void _presentPicker() async {
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: lastDate);
    setState(() {
      selectedDate = pickedDate;
    });
  }

  void _showdialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Please make sure a valid title, amount, date and category was entered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Please make sure a valid title, amount, date and category was entered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    }
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController
        .text); // tryParse('Hello') => null, tryParse('1.12') => 1.12
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        selectedDate == null) {
      _showdialog();
      return;
    }
    widget.onAddexpense(
      Expense(
          amount: enteredAmount,
          title: _titleController.text,
          time: selectedDate!,
          catagory: _selectCatagory),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    // TODO: implement build
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 48, 16, keyboardSpace + 16),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountController,

                      decoration: const InputDecoration(
                        prefixText: '\$ ',
                        label: Text('Amount'),
                      ),
                      keyboardType: TextInputType.number,
                      // inputFormatters: <TextInputFormatter>[
                      //   FilteringTextInputFormatter.digitsOnly
                      // ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        selectedDate == null
                            ? 'No selected date'
                            : formatter.format(selectedDate!),
                      ),
                      IconButton(
                        onPressed: _presentPicker,
                        icon: const Icon(Icons.calendar_month),
                      ),
                    ],
                  )),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  // DropdownButton(
                  //     items: Catagory.values
                  //         .map(
                  //           (catagory) => DropdownMenuItem(
                  //             child: Text(
                  //               catagory.name.toString(),
                  //             ),
                  //           ),
                  //         )
                  //         .toList(),
                  //     onChanged: (value) {}),
                  DropdownButton(
                      value: _selectCatagory,
                      items: Catagory.values
                          .map(
                            (catagory) => DropdownMenuItem(
                              value: catagory,
                              child: Text(
                                catagory.name.toUpperCase(),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          _selectCatagory = value;
                        });
                      }),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      _submitExpenseData();
                    },
                    child: const Text('Change Text'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
