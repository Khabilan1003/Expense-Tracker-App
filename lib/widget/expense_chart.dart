import "dart:math";

import "package:flutter/material.dart";
import "package:expense_tracker_app/model/expense.dart";

class ExpenseChart extends StatelessWidget {
  const ExpenseChart({super.key, required this.expenses});
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    List<double> costForCategory = Category.values.map((e) => 0.0).toList();
    double maxAmount = 0;

    for (int i = 0; i < expenses.length; i++) {
      costForCategory[expenses[i].category.index] += expenses[i].amount;
      maxAmount = max(maxAmount, costForCategory[expenses[i].category.index]);
    }

    for (int i = 0; i < costForCategory.length; i++) {
      costForCategory[i] /= maxAmount;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ...List.generate(costForCategory.length, (index) => index).map(
              (int index) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 150 * costForCategory[index],
                          decoration: const BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          Category.values[index].name.toUpperCase(),
                          style: TextStyle(color: Colors.black87),
                        )
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
