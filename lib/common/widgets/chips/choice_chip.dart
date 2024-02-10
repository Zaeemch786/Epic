import 'package:ecommerce_app/common/widgets/custom_shapes/container/circular_container.dart';
import 'package:ecommerce_app/utills/constants/colors.dart';
import 'package:ecommerce_app/utills/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';

class TChoiceChip extends StatelessWidget {
  const TChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
  });
  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final getColor = THelperFunctions.getColor(text) != null;
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        label: getColor ? const SizedBox() : Text(text),
        selected: selected,
        onSelected: onSelected,
        labelStyle: TextStyle(color: selected ? TColors.white : null),
        avatar: getColor
            ? TCircularContainer(
                width: 50,
                height: 50,
                backGroundColor: THelperFunctions.getColor(text)!,
              )
            : null,
        shape: getColor ? const CircleBorder() : null,
        backgroundColor: getColor ? THelperFunctions.getColor(text)! : null,
        labelPadding: getColor ? const EdgeInsets.all(0) : null,
        // selectedColor: Colors.blue,
        padding: getColor ? const EdgeInsets.all(0) : null,
      ),
    );
  }
}
