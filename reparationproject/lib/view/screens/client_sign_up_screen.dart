import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../api/api.dart';
import '../../constants/constant.dart';

import '../../constants/link_api.dart';
import '../../main.dart';
import '../widgets/auth_components/sign_up_form.dart';
import '../widgets/crud/crud.dart';
import 'client_home_screen.dart';
import 'client_sign_in_screen.dart';

class ClientSignUpScreen extends StatefulWidget {
  const ClientSignUpScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ClientSignUpScreen> createState() => _ClientSignUpScreenState();
}

class _ClientSignUpScreenState extends State<ClientSignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _userName, _email, _password, _phoneNumber;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  bool isHide = true;
  bool isObscure = false;
  bool passwordVisible = true;
  bool isLoading = false;
  Crud crud = Crud();

  SignUp() async {
    isLoading = true;
    // setState(() {});
    var response = await crud.postRequest(
      'http://10.0.2.2:8000/api/user_register',
      {
        "name": usernameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "password_confirmation": confirmController.text,
      },
    );
  }
  
  @override
  void initState() {
    super.initState();
    emailController.addListener(() => setState(() {}));
    usernameController.addListener(() => setState(() {}));
    passwordController.addListener(() => setState(() {}));
    confirmController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:isLoading == true
          ? Center(
          child: LoadingAnimationWidget.threeArchedCircle(
            color:mintColor,
            size: 50,
          ))
          : Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            "assets/icons/Sign_Up_bg.svg",
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill,
            // Now it takes 100% of our height
          ),
          Center(
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Client SU title".tr,
                      style: TextStyle(
                          fontFamily: 'headLine',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: defaultPadding - 10,
                    ),
                    Text(
                      "Client SU subtitle".tr,
                      style: TextStyle(fontSize: 15),
                    ),
                    const SizedBox(height: defaultPadding * 2),
                    Form(
                      key: _formKey,
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
                                      onPressed: () =>
                                          usernameController.clear(),
                                    ),
                              prefixIcon: Icon(Icons.supervised_user_circle,
                                  color: blueColor),
                              labelText: '1st CSU text field'.tr,
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
                              prefixIcon:
                                  Icon(Icons.email_sharp, color: blueColor),
                              hintText: 'name@example.com',
                              labelText: '2nd CSU text field'.tr,
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
                            controller: passwordController,
                            // We want to hide our password
                            obscureText: isObscure,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.password_sharp,
                                    color: blueColor),
                                labelText: '3rd CSU text field'.tr,
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
                                      isHide == true
                                          ? isHide = !isHide
                                          : isHide = true;
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
                            controller: confirmController,
                            obscureText: isObscure,
                            decoration: InputDecoration(
                                prefixIcon:
                                    Icon(Icons.verified_user, color: blueColor),
                                labelText: '4th CSU text field'.tr,
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
                                      isHide == true
                                          ? isHide = !isHide
                                          : isHide = true;
                                      isObscure == true
                                          ? isObscure = false
                                          : isObscure = !isObscure;
                                    });
                                  },
                                )),
                            validator: (pass) => MatchValidator(
                                    errorText: "Password do not  match")
                                .validateMatch(pass!, _password),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: defaultPadding * 2),
                    SizedBox(
                      width: double.infinity,
                      // child: ElevatedButton(
                      //   onPressed: () {
                      //     if (_formKey.currentState!.validate()) {
                      //       // Sign up form is done
                      //       // It saved our inputs
                      //       _formKey.currentState!.save();
                      //     }
                      //   },
                      //   child: Text("Sign Up"),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        splashColor: blueColor,
                        minWidth: MediaQuery.of(context).size.width / 1.2,
                        height: MediaQuery.of(context).size.height / 18,
                        color: mintColor,
                        child: Text(
                          'CSU button'.tr,
                          style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            await SignUp();
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ClientHomeScreen(),
                                ),);
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("end of CSU".tr),
                        TextButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ClientSignInScreen(),
                              )),
                          child: Text(
                            "Move to CSI".tr,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).viewInsets.bottom,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
