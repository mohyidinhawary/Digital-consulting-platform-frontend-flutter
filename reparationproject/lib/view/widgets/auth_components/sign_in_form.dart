import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../constants/constant.dart';


class SignInForm extends StatefulWidget {
  SignInForm({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  final GlobalKey formKey;

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  late String _email, _password;
  bool passwordVisible = true;
  final emailController = TextEditingController();
  final numberController = TextEditingController();
  final usernameController = TextEditingController();
  bool ishide = true;
  bool isobscure = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(() => setState(() {}));
    usernameController.addListener(() => setState(() {}));
    numberController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    emailController.dispose();
    numberController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              suffixIcon: emailController.text.isEmpty
                  ? Container(width: 0)
                  : IconButton(
                icon: Icon(
                  Icons.close,
                  color: blueColor,
                ),
                onPressed: () => emailController.clear(),
              ),
              prefixIcon: Icon(Icons.supervised_user_circle, color: blueColor),
              hintText: 'name@example.com',
              labelText: 'Email',
              border: OutlineInputBorder(),
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  width: 1.8,
                  color: blueColor,
                ),
              ),
            ),
            validator: EmailValidator(errorText: "Use a valid email!"),
            onSaved: (email) => _email = email!,
          ),
          const SizedBox(height: defaultPadding*2),
          TextFormField(
            obscureText: isobscure,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: ishide
                      ? Icon(Icons.visibility)
                      : Icon(Icons.visibility_off),
                  color: blueColor,
                  onPressed: () {
                    setState(() {
                      ishide == true ? ishide = !ishide : ishide = true;
                      isobscure == true
                          ? isobscure = false
                          : isobscure = !isobscure;
                    });
                  },
                ),
              prefixIcon: Icon(Icons.password_sharp, color: blueColor),
              hintText: '*****',
              labelText: 'Password',
              border: OutlineInputBorder(),
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  width: 1.8,
                  color: blueColor,
                ),
              ),
            ),
            validator: passwordValidator,
            onSaved: (password) => _password = password!,
          ),
          const SizedBox(height: defaultPadding),
        ],
      ),
    );
  }
}
