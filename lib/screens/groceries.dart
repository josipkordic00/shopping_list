import 'package:flutter/material.dart';
import 'package:shopping_list_app/screens/new_item.dart';
import 'package:shopping_list_app/widgets/groceries_list.dart';

class GroceriesScreen extends StatefulWidget {
  const GroceriesScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _GroceriesScreenState();
  }
}

class _GroceriesScreenState extends State<GroceriesScreen> {
  void _addItem() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: const GroceriesList(),
    );
  }
}
