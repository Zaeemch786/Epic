import 'package:flutter/material.dart';

class TProductPriceText extends StatelessWidget {
  const TProductPriceText({
    super.key,
    this.currentSign = '\$',
    required this.price,
    this.maxLines = 1,
    this.lineThrouh = false,
    this.isLarge = false,
  });
  final String currentSign, price;
  final int maxLines;
  final bool lineThrouh;
  final bool isLarge;

  @override
  Widget build(BuildContext context) {
    return Text(
      currentSign + price,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: isLarge
          ? Theme.of(context)
              .textTheme
              .headlineMedium!
              .apply(decoration: lineThrouh ? TextDecoration.lineThrough : null)
          : Theme.of(context).textTheme.titleLarge!.apply(
              decoration: lineThrouh ? TextDecoration.lineThrough : null),
    );
  }
}
