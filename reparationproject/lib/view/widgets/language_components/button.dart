import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {

  String?text;

  MyButton({
    Key? key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: Container(
        height: 150,
        padding: EdgeInsets.all(20),
        child: Center(child: Text(text!,style: TextStyle(fontSize:22,fontWeight: FontWeight.bold,fontFamily: 'headLine',color: Colors.grey.shade600),)),
        decoration: BoxDecoration(
            shape: BoxShape.circle,

            color: Colors.grey[300],
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[600]!,
                  offset: Offset(4.0, 4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0),
              BoxShadow(
                  color: Colors.white,
                  offset: Offset(-4.0, -4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0),
            ],
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.grey[200]!,
                  Colors.grey[300]!,
                  Colors.grey[400]!,
                  Colors.grey[500]!,
                ],
                stops: [
                  0.1,
                  0.3,
                  0.8,
                  1
                ])),
      ),
    );
  }
}
