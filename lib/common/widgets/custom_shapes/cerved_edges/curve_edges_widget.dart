import 'package:ecommerce_app/common/widgets/custom_shapes/cerved_edges/curved_edges.dart';
import 'package:flutter/material.dart';

class TCurveEdeWidget extends StatelessWidget {
  final Widget? child;
  const TCurveEdeWidget({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return ClipPath(clipper: TCustomCurvesEdges(), child: child);
  }
}
