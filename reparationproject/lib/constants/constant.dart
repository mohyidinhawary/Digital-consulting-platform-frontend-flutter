import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';


const primaryColor = Color(0xFF255ED6);
const textColor = Color(0xFF35364F);
const backgroundColor = Color(0xFFE6EFF9);

const kBackgoundColor = Color(0xFF091C40);
const kSecondaryColor = Color(0xFF606060);
const kRedColor = Color(0xFFFF1E46);

const blueColor = Color(0xFF2E4FFF);
const goldColor = Color(0xFFFEA41D);
const mintColor = Color(0xFF6CD8D1);

const defaultPadding = 16.0;

OutlineInputBorder textFieldBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: primaryColor.withOpacity(0.1),
  ),
);

// I will explain it later

const emailError = 'Enter a valid email address';
const requiredField = "This field is required";

final passwordValidator = MultiValidator(
  [
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ],);

final emailValidator = MultiValidator(
  [
    RequiredValidator(errorText: 'Email is required'),
    EmailValidator(errorText: 'Use a valid email')
  ],);

final usernameValidator=MultiValidator([
  RequiredValidator(errorText: "Username is required"),
  PatternValidator(r'^[A-Z a-z]+$', errorText: 'Use a valid username')
]
);

final phoneValidator=MultiValidator([
  RequiredValidator(errorText: 'Phone is required'),
 PatternValidator(r'^(?:[+0]9)?[0-9]{10}$', errorText: 'Use a valid phone number'),
]);

final confirmationValidator=MultiValidator([
  RequiredValidator(errorText: 'Confirmation field is required'),
]);








