import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  void _openDatePicker() {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    showDatePicker(context: context, initialDate: now, firstDate: firstDate, lastDate: now);
  }

  // dispose of the controller when the widget is removed
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              // keyboardType: the type that should be rendered when opened
              controller: _titleController,
              maxLength: 50, // maximum number of characters
              decoration: const InputDecoration(
                label: Text('Title'),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number, // only numbers keyboard
                    decoration: const InputDecoration(
                      prefixText: '\$ ',
                      label: Text('Amount'),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      const Text('Selected date'),
                      IconButton(
                        onPressed: _openDatePicker,
                        icon: const Icon(Icons.calendar_month),
                      )
                    ]))
              ],
            ),
            const SizedBox(height: 20),
            Row(children: [
              ElevatedButton(
                onPressed: () {
                  print(_titleController.text);
                  print(_amountController.value.text);
                },
                child: const Text('Save Expense'),
              ),
              const SizedBox(width: 10),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'))
            ])
          ],
        ));
  }
}
