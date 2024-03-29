import 'package:flutter/material.dart';
import "package:uuid/uuid.dart";
import 'package:intl/intl.dart';

enum Category { food, leisure, travel, work }

const Uuid uuid = Uuid();
DateFormat format = DateFormat.yMd();

Map<Category, IconData> categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return format.format(date);
  }
}
