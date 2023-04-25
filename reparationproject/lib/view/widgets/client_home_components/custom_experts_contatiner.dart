
import 'package:flutter/material.dart';

Widget CustomExpertContainer() {
  return InkWell(
    child: Container(
      margin: EdgeInsets.fromLTRB(15, 5, 5, 0),
      height: 300,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 60),
        // child: Column(
        //   children: [
        //     Container(
        //       height: 35,
        //       width: 200,
        //       decoration: BoxDecoration(
        //         image: DecorationImage(
        //             image: AssetImage("assets/images/doctor.jpg"),
        //             fit: BoxFit.cover),
        //         color: Colors.white,
        //         borderRadius: BorderRadius.circular(10),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    ),
  );
}
