import 'package:flutter/material.dart';

class GroceriesItem extends StatelessWidget {
  const GroceriesItem(
      {super.key,
      required this.color,
      required this.name,
      required this.quantity});

  final Color color;
  final String name;
  final int quantity;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.square,
          color: color,
          size: 30,
        ),
        const SizedBox(
          width: 30,
        ),
        Text(
          name,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
        const Spacer(),
        Text(
              quantity.toString(),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
      ],
    );
  }
}
