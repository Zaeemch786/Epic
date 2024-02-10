import 'package:ecommerce_app/common/widgets/custom_shapes/cerved_edges/curve_edges_widget.dart';
import 'package:ecommerce_app/common/widgets/custom_shapes/container/circular_container.dart';
import 'package:ecommerce_app/utills/constants/colors.dart';
import 'package:flutter/material.dart';

class TPrimaryHeaderContainer extends StatelessWidget {
  final Widget child;
  const TPrimaryHeaderContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return TCurveEdeWidget(
      child: Container(
        color: TColors.primary,
        padding: const EdgeInsets.all(0),
        child: Stack(children: [
          Positioned(
              top: -150,
              right: -250,
              child: TCircularContainer(
                backGroundColor: TColors.textWhite.withOpacity(0.1),
              )),
          Positioned(
            top: 100,
            right: -300,
            child: TCircularContainer(
              backGroundColor: TColors.textWhite.withOpacity(0.1),
            ),
          ),
          child
        ]),
      ),
    );
  }
}
