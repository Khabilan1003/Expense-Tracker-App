import 'package:expense_tracker_app/widget/expense_chart.dart';
import 'package:expense_tracker_app/widget/expense_list.dart';
import 'package:expense_tracker_app/widget/new_expense.dart';
import "package:flutter/material.dart";
import 'package:expense_tracker_app/model/expense.dart';

class ExpenseScreen extends StatefulWidget {
  ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final List<Expense> expenses = [
    Expense(
        title: "Chicken Noodles",
        amount: 100,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: "Coimatore Travel",
        amount: 300,
        date: DateTime.now(),
        category: Category.travel),
  ];

  void addExpense(Expense expense) {
    setState(() {
      expenses.add(expense);
    });
  }

  void removeExpense(Expense expense) {
    int index = expenses.indexOf(expense);
    expenses.remove(expense);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Expense Removed"),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              expenses.insert(index, expense);
            });
          },
        ),
      ),
    );
  }

  void openModelDialog() {
    showModalBottomSheet(
        useSafeArea: true,
        context: context,
        isScrollControlled: true,
        builder: (ctx) {
          return NewExpense(
            addExpense: addExpense,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        actions: [
          IconButton(
            onPressed: openModelDialog,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            ExpenseChart(expenses: expenses),
            Expanded(
              child: ExpenseList(
                expenses: expenses,
                removeExpense: removeExpense,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
