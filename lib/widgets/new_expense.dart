import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  void _openDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    
    final pickedDate = await showDatePicker(context: context, initialDate: now, firstDate: firstDate, lastDate: now);

    // sets the selected date to the picked date
    setState(() {
      _selectedDate = pickedDate;
    });    
  }

  void _submitData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty || amountIsInvalid || _selectedDate == null) {
      showDialog(context: context, builder: (ctx) => AlertDialog(
        title: const Text('Invlaid input'),
        content: const Text('Please enter a valid title, amount and date.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: const Text('Okay')
          )
        ],
      ));
      return;
    }

    widget.onAddExpense(Expense(title: _titleController.text, amount: enteredAmount, date: _selectedDate!, category: _selectedCategory));
    
    Navigator.pop(context);

    showDialog(context: context, builder: (ctx) => AlertDialog(
      title: const Text('Expense added'),
      content: const Text('The expense has been added successfully.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(ctx);
          },
          child: const Text('Close')
        )
      ],
    ));
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
        padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
        child: Column(
          children: [
            TextField(
              // keyboardType: the type that should be rendered when opened
              controller: _titleController,
              maxLength: 50, // maximum number of characters
              decoration: const InputDecoration(
                label: Text('Title'),
              ),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimaryContainer
              )
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
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer
                    )
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // the ! forces the value to be non-nullable
                      Text(
                        _selectedDate == null ? 'No date selected' : formatter.format(_selectedDate!),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimaryContainer
                        )   
                      ), 
                      IconButton(
                        onPressed: _openDatePicker,
                        icon: const Icon(Icons.calendar_month),
                      )
                    ]
                  )
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(children: [
              DropdownButton(
                value: _selectedCategory,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer
                ),
                items: Category.values.map(
                  (category) => DropdownMenuItem(value: category, child: Text(category.name.toUpperCase()))
                ).toList(),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    _selectedCategory = value;
                  });
                }
              ),
              const Spacer(),
              const SizedBox(width: 10),              
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel')
              ),
              ElevatedButton(
                onPressed: _submitData,
                child: const Text('Save Expense'),
              ),
            ])
          ],
        ));
  }
}
