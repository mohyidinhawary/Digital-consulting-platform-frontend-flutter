
import 'package:flutter/material.dart';

class OnBoardingModel {
  final String? title;
  final String? image;
  final String? body;
  final Widget? bg;
  final int? selected;

  OnBoardingModel({this.selected, this.bg, this.body, this.title, this.image});
}