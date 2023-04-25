
import 'package:flutter/material.dart';

Widget CustomCategoryContainer(Color color) {
  return
    InkWell(
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
            color: color,
           ),
      ),
    );
}

