import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list_app/data/categories.dart';
import 'package:shopping_list_app/models/category.dart';
import 'package:shopping_list_app/models/grocery_item.dart';
import 'package:http/http.dart' as http;

class GroceryProviderNotifier extends StateNotifier<List<GroceryItem>> {
  GroceryProviderNotifier() : super([]);

  void setList(List<GroceryItem> list) {
    state = list;
  }

  void addToList(GroceryItem item) {
    state = [...state, item];
  }

  void removeFromList(GroceryItem item) {
    state = state.where((e) => e.id != item.id).toList();
  }

  void postData(String enteredName, int enteredQuantity,
      Category selectedCategory) async {
    final url = Uri(
        scheme: 'https',
        host: 'bezze-63e62-default-rtdb.firebaseio.com',
        path: 'shopping-list.json');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': enteredName,
        'quantity': enteredQuantity,
        'category': selectedCategory.name
      }),
    );
    final Map<String, dynamic> resData = json.decode(response.body);
    addToList(GroceryItem(
        id: resData['name'],
        name: enteredName,
        quantity: enteredQuantity,
        category: selectedCategory));
  }


  Future<String> getData() async {
    final url = Uri(
        scheme: 'https',
        host: 'bezze-63e62-default-rtdb.firebaseio.com',
        path: 'shopping-list.json');
    final response = await http.get(url);
    if (response.statusCode >= 400) {
      return 'no';
    }
    final Map<String, dynamic> data = json.decode(response.body);
    List<GroceryItem> list = [];
    for (final i in data.entries) {
      var icategory = categories.entries
          .firstWhere((cat) => cat.value.name == i.value['category']);
      list.add(GroceryItem(
          id: i.key,
          name: i.value['name'],
          quantity: i.value['quantity'],
          category: icategory.value));
    }
    setList(list);
    
    return 'ok';
  }
}

final GroceryProvider =
    StateNotifierProvider<GroceryProviderNotifier, List<GroceryItem>>((ref) {
  return GroceryProviderNotifier();
});
