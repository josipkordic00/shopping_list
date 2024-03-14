import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list_app/providers/grocery_provider.dart';
import 'package:shopping_list_app/widgets/groceries_item.dart';

class GroceriesList extends ConsumerStatefulWidget {
  const GroceriesList({super.key});

  @override
  ConsumerState<GroceriesList> createState() {
    return _GroceriesListState();
  }
}

class _GroceriesListState extends ConsumerState<GroceriesList> {
  var isLoading = true;
  @override
  void initState() {
    super.initState();
    ref.read(GroceryProvider.notifier).getData();
  }

  @override
  Widget build(BuildContext context) {
    final groceries = ref.watch(GroceryProvider);
    final status = ref.read(GroceryProvider.notifier).getData();

    Widget content = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Nothing here',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Add some Groceries!',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ],
      ),
    );
    status.then((value) {
      if (value == 'ok') {
        return;
      } else {
        content = const Center(
          child: Text('Failed to fetch data, try again later!'),
        );
      }
    });
    

    if (groceries.isEmpty) {
      setState(() {
        isLoading = false;
      });
      return content;
    } else {
      setState(() {
        isLoading = false;
      });
      return ListView.builder(
          itemCount: groceries.length,
          itemBuilder: (cts, index) => Dismissible(
                onDismissed: (direction) {
                  ref
                      .read(GroceryProvider.notifier)
                      .removeFromList(groceries[index]);
                },
                background: Container(
                  color: Theme.of(context).colorScheme.error.withOpacity(0.75),
                ),
                key: ValueKey(groceries[index].id),
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    child: GroceriesItem(
                        color: groceries[index].category.color,
                        name: groceries[index].name,
                        quantity: groceries[index].quantity)),
              ));
    }
  }
}
