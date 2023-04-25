import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../constants/constant.dart';
import '../../../constants/link_api.dart';
import '../crud/crud.dart';

class SignUpForm extends StatefulWidget {
  SignUpForm({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  final GlobalKey formKey;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  late String _userName, _email, _password, _phoneNumber;
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  bool isHide = true;
  bool isObscure = false;
  bool passwordVisible = true;

  Crud _crud = Crud();

  final _formKey = GlobalKey<FormState>();

  SignUpScreen() async {
    var response = await _crud.postRequest(linkSignUp, {
      'username': usernameController.text,
      'email': emailController.text,
      'password': numberController.text,
      'confirmation password': usernameController.text,
    });
    if(response['status']=='success'){
      //go to homw page using navigator pushnamedandremoveuntil
    }
    else{
      print('Sign up Fail');
    }
  }

  @override
  void initState() {
    super.initState();
    emailController.addListener(() => setState(() {}));
    usernameController.addListener(() => setState(() {}));
    numberController.addListener(() => setState(() {}));
    confirmController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    emailController.dispose();
    numberController.dispose();
    usernameController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TextFieldName(text: "Username"),
          TextFormField(
            controller: usernameController,
            decoration: InputDecoration(
              suffixIcon: usernameController.text.isEmpty
                  ? Container(width: 0)
                  : IconButton(
                      icon: Icon(
                        Icons.close,
                        color: blueColor,
                      ),
                      onPressed: () => usernameController.clear(),
                    ),
              prefixIcon: Icon(Icons.supervised_user_circle, color: blueColor),
              hintText: 'Franky',
              labelText: 'Username',
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
            validator: usernameValidator,
            // Let's save our username
            onSaved: (username) => _userName = username!,
          ),
          const SizedBox(height: defaultPadding * 2),

          // TextFieldName(text: "Email"),
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
              prefixIcon: Icon(Icons.email_sharp, color: blueColor),
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
            validator: emailValidator,
            onSaved: (email) => _email = email!,
          ),
          // TextFieldName(text: "Phone"),
          const SizedBox(height: defaultPadding * 2),
          // TextFieldName(text: "Password"),

          TextFormField(
            // We want to hide our password
            obscureText: isObscure,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.password_sharp, color: blueColor),
                hintText: '*******',
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
                suffixIcon: IconButton(
                  icon: isHide == true
                      ? Icon(Icons.visibility)
                      : Icon(Icons.visibility_off),
                  color: blueColor,
                  onPressed: () {
                    setState(() {
                      isHide == true ? isHide = !isHide : isHide = true;
                      isObscure == false
                          ? isObscure = !isObscure
                          : isObscure = false;
                    });
                  },
                )),
            validator: passwordValidator,
            onSaved: (password) => _password = password!,
            onChanged: (pass) => _password = pass,
          ),
          const SizedBox(height: defaultPadding * 2),
          // TextFieldName(text: "Confirm Password"),
          TextFormField(
            obscureText: isObscure,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.verified_user, color: blueColor),
                hintText: '*******',
                labelText: 'Confirm Password',
                border: OutlineInputBorder(),
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    width: 1.8,
                    color: blueColor,
                  ),
                ),
                suffixIcon: IconButton(
                  icon: isHide
                      ? Icon(Icons.visibility)
                      : Icon(Icons.visibility_off),
                  color: blueColor,
                  onPressed: () {
                    setState(() {
                      isHide == true ? isHide = !isHide : isHide = true;
                      isObscure == true
                          ? isObscure = false
                          : isObscure = !isObscure;
                    });
                  },
                )),
            validator: (pass) =>
                MatchValidator(errorText: "Password do not  match")
                    .validateMatch(pass!, _password),
          ),
        ],
      ),
    );
  }
}
