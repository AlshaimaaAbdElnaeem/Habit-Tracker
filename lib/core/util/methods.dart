import 'package:flutter/cupertino.dart';

class CustomShapeClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);
    var firstControlPoint = Offset(size.width/6, size.height-80);
    var firstEndPoint = Offset(size.width/3, size.height-40);
    var secondControlPoint = Offset(size.width/2, size.height);
    var secondEndPoint = Offset(2*size.width/3, size.height-40);
    var thirdControlPoint = Offset(5*size.width/6, size.height-80);
    var thirdEndPoint = Offset(size.width, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndPoint.dx, thirdEndPoint.dy);
    path.lineTo(size.width, 0.0);
    path.close();
   return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false ;
  }

}