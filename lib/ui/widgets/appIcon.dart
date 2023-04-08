import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  final IconData iconData;
  final Color iconColor;
  final double size; 

  const AppIcon({Key? key,
    required this.iconData,
    required this.iconColor,
    this.size = 40}):
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(size / 2)
      ),
      child: Icon(iconData,color: iconColor,size: 20
      ),
    );
  }
}
