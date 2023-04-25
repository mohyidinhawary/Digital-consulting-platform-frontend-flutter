import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../constants/constant.dart';
import '../../constants/link_api.dart';
import '../../main.dart';
import '../widgets/auth_components/sign_in_form.dart';
import '../widgets/crud/crud.dart';
import '../widgets/expert_home_component/appointments.dart';
import 'client_home_screen.dart';
import 'expert_home_screen.dart';
import 'expert_sign_up_screen.dart';
import 'grid_view_doctor_screen.dart';

class ExpertSignInScreen extends StatefulWidget {
  const ExpertSignInScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ExpertSignInScreen> createState() => ExpertSignInScreenState();
}

class ExpertSignInScreenState extends State<ExpertSignInScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _email, _password;
  bool passwordVisible = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  bool ishide = true;
  bool isobscure = false;

  Crud crud = Crud();
  bool isLoading = false;

  login() async {
    isLoading = true;
    setState(() {});
    var response = await crud.postRequest(
      'https://reqres.in/api/login',
      {
        'email': emailController.text,
        'password': passwordController.text,
      },
    );
    isLoading = false;
    setState(() {});
    if (response != null) {
      sharedPref.setString(
        'token',
        response['token'],
      );
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ExpertHomeScreen(),
        ),
      );
    }
    else {
      AwesomeDialog(
        dialogType: DialogType.infoReverse,
        context: context,
        title: 'warning',
        body: Text(
          "the password or email are wrong or maybe the account doesn't exist",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        animType: AnimType.scale,
        padding: EdgeInsets.all(8),
        // btnCancel:Text('cancel',textAlign: TextAlign.center,style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
        barrierColor: Colors.grey.shade300,
        alignment: Alignment.center,
        autoHide: const Duration(seconds: 10),
      )..show();
      //btnCancel:Text('cancel');
    }
  }

  @override
  void initState() {
    super.initState();
    emailController.addListener(() => setState(() {}));
    usernameController.addListener(() => setState(() {}));
    passwordController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: isLoading == true
          ? Center(
              child: LoadingAnimationWidget.threeArchedCircle(
              color: mintColor,
              size: 50,
            ))
          : Stack(
              fit: StackFit.expand,
              children: [
                SvgPicture.asset(
                  "assets/icons/Sign_Up_bg.svg",
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.fill,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1),
                  child: SafeArea(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome Back as Expert",
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(
                                    fontFamily: 'headLine',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                          ),
                          SizedBox(
                            height: defaultPadding - 10,
                          ),
                          Text(
                            "We're happy to see you here again.",
                            style: TextStyle(fontSize: 15),
                          ),
                          const SizedBox(height: defaultPadding * 2),
                          Form(
                            key: _formKey,
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
                                            onPressed: () =>
                                                emailController.clear(),
                                          ),
                                    prefixIcon: Icon(
                                        Icons.supervised_user_circle,
                                        color: blueColor),
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
                                ),
                                const SizedBox(height: defaultPadding * 2),
                                TextFormField(
                                  controller: passwordController,
                                  obscureText: isobscure,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: ishide
                                          ? Icon(Icons.visibility)
                                          : Icon(Icons.visibility_off),
                                      color: blueColor,
                                      onPressed: () {
                                        setState(() {
                                          ishide == true
                                              ? ishide = !ishide
                                              : ishide = true;
                                          isobscure == true
                                              ? isobscure = false
                                              : isobscure = !isobscure;
                                        });
                                      },
                                    ),
                                    prefixIcon: Icon(Icons.password_sharp,
                                        color: blueColor),
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
                            //       //  Sign in also done
                            //     }
                            //   },
                            //   child: Text("Sign In"),
                            // ),ٍ
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              splashColor: mintColor,
                              minWidth: MediaQuery.of(context).size.width / 1.2,
                              height: MediaQuery.of(context).size.height / 18,
                              color: mintColor,
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  await login();
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          SizedBox(
                            height: defaultPadding,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account?"),
                              TextButton(
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ExpertSignUpScreen(),
                                  ),
                                ),
                                child: Text(
                                  "Sign Up!",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: defaultPadding,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  iconSize: 40,
                                  icon: FaIcon(
                                    FontAwesomeIcons.facebook,
                                    color: blueColor,
                                  ),
                                  onPressed: () {
                                    print("Pressed");
                                  }),
                              IconButton(
                                  iconSize: 40,
                                  icon: FaIcon(
                                    FontAwesomeIcons.snapchat,
                                    color: goldColor,
                                  ),
                                  onPressed: () {
                                    print("Pressed");
                                  }),
                              IconButton(
                                iconSize: 40,
                                icon: FaIcon(
                                  FontAwesomeIcons.twitter,
                                  color: Colors.lightBlueAccent,
                                ),
                                onPressed: () {
                                  print("Pressed");
                                },
                              ),
                            ],
                          )
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
