import 'package:flutter/material.dart';

class TCustomCurvesEdges extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    final firstCurve = Offset(0, size.height - 20);
    // ignore: non_constant_identifier_names
    final LlastCurve = Offset(30, size.height - 20);
    path.quadraticBezierTo(
        firstCurve.dx, firstCurve.dy, LlastCurve.dx, LlastCurve.dy);
    final secondFirstCurve = Offset(0, size.height - 20);
    final secondLlastCurve = Offset(size.width - 30, size.height - 20);
    path.quadraticBezierTo(secondFirstCurve.dx, secondFirstCurve.dy,
        secondLlastCurve.dx, secondLlastCurve.dy);
    // ignore: non_constant_identifier_names
    final ThirdfirstCurve = Offset(size.width, size.height - 20);
    // ignore: non_constant_identifier_names
    final ThirdLlastCurve = Offset(size.width, size.height);
    path.quadraticBezierTo(ThirdfirstCurve.dx, ThirdfirstCurve.dy,
        ThirdLlastCurve.dx, ThirdLlastCurve.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
