import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ItemQuantityController extends StatefulWidget {
  const ItemQuantityController({
    super.key,
    required this.getQuantity,
  });

  final void Function(int quantity) getQuantity;

  @override
  State<ItemQuantityController> createState() => _ProductQuantityCounterState();
}

class _ProductQuantityCounterState extends State<ItemQuantityController> {
  int counter = 1;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextTheme.of(context).bodyLarge!.copyWith(),
      child: Center(
        child: Row(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Quantity",
              style: TextTheme.of(context)
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
            Gap(12),
            Row(
              children: [
                IconButton(
                    onPressed: counter == 1
                        ? null
                        : () {
                            setState(() {
                              if (counter > 1) {
                                counter--;
                                widget.getQuantity(counter);
                              }
                            });
                          },
                    icon: Icon(Icons.remove)),
                Text(counter.toString()),
                IconButton(
                    onPressed: () {
                      setState(() {
                        counter++;
                        widget.getQuantity(counter);
                      });
                    },
                    icon: Icon(Icons.add)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
