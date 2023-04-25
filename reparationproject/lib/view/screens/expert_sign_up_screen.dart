import 'dart:convert';
import 'dart:io';
import 'package:animated_checkmark/animated_checkmark.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import '../../constants/constant.dart';
import '../../main.dart';
import '../widgets/crud/crud.dart';
import '../widgets/detail_form_components/progress.dart';
import '../widgets/expert_home_component/appointments.dart';
import 'expert_home_screen.dart';
import 'expert_sign_in_screen.dart';
import 'package:http/http.dart' as http;

class ExpertSignUpScreen extends StatefulWidget {
  const ExpertSignUpScreen({Key? key}) : super(key: key);

  @override
  State<ExpertSignUpScreen> createState() => _ExpertSignUpScreenState();
}

class _ExpertSignUpScreenState extends State<ExpertSignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _firstName,
      _email,
      _password,
      _phoneNumber,
      _address,
      _experience;
  final durationController = PageController(initialPage: 15);
  final format = DateFormat("HH:mm");
  TimeOfDay timeOfDay = const TimeOfDay(hour: 8, minute: 30);
  late String _userName;
  bool isHide = true;
  bool isObscure = false;
  bool passwordVisible = true;
  int? tag;

  List<String> options = [
    '1st category'.tr,
    '2nd category'.tr,
    '3rd category'.tr,
    '4th category'.tr,
    '5th category'.tr,
  ];
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final numberController = TextEditingController();
  final addressController = TextEditingController();
  final experienceController = TextEditingController();
  final yearsController = TextEditingController();
  final DateController = TextEditingController();
  PFormController? pformcontroller;

  bool isLoading = false;
  Crud crud = Crud();

  final feesController = PageController(
    initialPage: 15,
  );

  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
  }

  // SignUp() async {
  //   isLoading = true;
  //   // setState(() {});
  //   var response = await crud.postRequest(
  //     'http://10.0.2.2:8000/api/expert_register',
  //       {
  //         "name":"mohammed",
  //         "email":"hamed@gmail.com",
  //         "password":"12",
  //         "password_confirmation":"12",
  //         "phone_number":"0949982511",
  //         "address":"midan",
  //         "experiences":"in medical and engineering and family",
  //         "experience_years":"2",
  //         "session_price":"100",
  //         "Medical_consulting":"true",
  //         "Professional_consulting":"false",
  //         "Psychological_consulting":"true",
  //         "Family_consulting":"false",
  //         "management_consulting":"true"
  //       }
  //
  //   );
  //
  //   isLoading = false;
  //   setState(() {});
  //   if (response != null) {
  //     // sharedPref.setString(
  //     //   'token',
  //     //   response['token'].toString(),
  //     // );
  //     Navigator.of(context).push(
  //       MaterialPageRoute(
  //         builder: (context) => ExpertHomeScreen(),
  //       ),
  //     );
  //   } else {
  //
  //     AwesomeDialog(
  //       dialogType: DialogType.infoReverse,
  //       context: context,
  //       title: 'warning',
  //       body: const Text(
  //         "There's something wrong please try again",
  //         textAlign: TextAlign.center,
  //         style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
  //       ),
  //       animType: AnimType.scale,
  //       padding: const EdgeInsets.all(8),
  //       barrierColor: Colors.grey.shade300,
  //       alignment: Alignment.center,
  //       autoHide: const Duration(seconds: 10),
  //     )..show();
  //   }
  // }

  postRequest(String url, Map data) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      };
      var response = await http.post(Uri.parse(url), body: data);
      if (response.statusCode == 200) {
        print(data);
        print('success');
        print(response.body);
        var responseBody = jsonDecode(response.body);
        return responseBody;
      } else {
        print(data);
        print(response.body);
        print('Error ${response.statusCode}');
      }
    } catch (e) {
      print(data);
      print('ErrorCatch $e');
    }
  }

  @override
  void initState() {
    super.initState();
    pformcontroller = PFormController(5);
    numberController.addListener(() => setState(() {}));
    addressController.addListener(() => setState(() {}));
    experienceController.addListener(() => setState(() {}));
    emailController.addListener(() => setState(() {}));
    usernameController.addListener(() => setState(() {}));
    passwordController.addListener(() => setState(() {}));
    confirmController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    numberController.dispose();
    addressController.dispose();
    experienceController.dispose();
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? _path;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: isLoading == true
          ? Center(
              child: LoadingAnimationWidget.threeArchedCircle(
              color: mintColor,
              size: 50,
            ))
          : Stack(
              children: [
                Container(
                  height: height,
                  width: width,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [goldColor, Colors.white],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: defaultPadding * 8, right: defaultPadding * 8),
                    child: Padding(
                      padding: const EdgeInsets.only(top: defaultPadding * 4),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.grey.shade200,
                            foregroundImage: _path == null
                                ? null
                                : FileImage(
                                    File(_path),
                                  ),
                          ),
                          Positioned(
                            top: 78,
                            left: 70,
                            child: CircleAvatar(
                              backgroundColor: Colors.amber.withOpacity(0.5),
                              radius: 22,
                              child: CircleAvatar(
                                backgroundColor: mintColor,
                                child: IconButton(
                                  onPressed: () async {
                                    var imagePicker = ImagePicker();
                                    var xfile = _path == null
                                        ? await imagePicker.pickImage(
                                            source: ImageSource.gallery)
                                        : _path = null;
                                    if (xfile != null) {
                                      setState(() {
                                        _path = xfile.path;
                                      });
                                    } else {
                                      setState(() {
                                        _path = null;
                                      });
                                    }
                                  },
                                  icon: _path == null
                                      ? Icon(Icons.add,
                                          color: Colors.grey.shade200)
                                      : Icon(Icons.delete,
                                          color: Colors.grey.shade200),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: TextButton(
                    onPressed: () async {
                      var request = http.Request('POST', Uri.parse('http://10.0.2.2:8000/api/expert_register'));
                      request.body = '''{\r\n    "name":"mohammed",\r\n    "email":"mohammed56@gmail.com",\r\n    "password":"12",\r\n    "password_confirmation":"12",\r\n     "phone_number":"0949982511",\r\n            "address":"midan",\r\n            "experiences":"in medical and engineering and family",\r\n            "experience_years":"2",\r\n            "session_price":"100",\r\n            "Medical_consulting":true,\r\n            "Professional_consulting":true,\r\n            "Psychological_consulting":false,\r\n            "Family_consulting":true,\r\n            "management_consulting":false\r\n}''';

                      http.StreamedResponse response = await request.send();

                      if (response.statusCode == 200) {
                        print(await response.stream.bytesToString());
                      }
                      else {
                        print(response.reasonPhrase);
                      }
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ExpertHomeScreen(),),);
                    },
                    child: Text(
                      'ER button'.tr,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                Positioned(
                  top: 230,
                  left: 80,
                  right: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("end of ER".tr),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const ExpertSignInScreen();
                              },
                            ),
                          );
                        },
                        child: Text(
                          "Move to ESI".tr,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 800,
                  child: DraggableScrollableSheet(
                      maxChildSize: 0.93,
                      minChildSize: 0.65,
                      initialChildSize: 0.65,
                      builder: (ctx, controller) {
                        return Container(
                          padding: const EdgeInsets.fromLTRB(15, 35, 10, 0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: SingleChildScrollView(
                            controller: controller,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PForm(
                                    height: 700,
                                    controller: pformcontroller,
                                    pages: [
                                      Form(
                                        key: _formKey,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: defaultPadding),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // TextFieldName(text: "Username"),
                                              TextFormField(
                                                controller: usernameController,
                                                decoration: InputDecoration(
                                                  suffixIcon: usernameController
                                                          .text.isEmpty
                                                      ? Container(width: 0)
                                                      : IconButton(
                                                          icon: const Icon(
                                                            Icons.close,
                                                            color: blueColor,
                                                          ),
                                                          onPressed: () =>
                                                              usernameController
                                                                  .clear(),
                                                        ),
                                                  prefixIcon: const Icon(
                                                      Icons
                                                          .supervised_user_circle,
                                                      color: blueColor),
                                                  labelText:
                                                      '1st CSU text field'.tr,
                                                  border:
                                                      const OutlineInputBorder(),
                                                  filled: true,
                                                  fillColor: Colors.grey
                                                      .withOpacity(.3),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    borderSide:
                                                        const BorderSide(
                                                      width: 1.8,
                                                      color: blueColor,
                                                    ),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors.grey
                                                                  .shade600),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                ),
                                                validator: usernameValidator,
                                                // Let's save our username
                                                onSaved: (username) =>
                                                    _userName = username!,
                                              ),
                                              const SizedBox(
                                                  height: defaultPadding * 2),

                                              // TextFieldName(text: "Email"),
                                              TextFormField(
                                                controller: emailController,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                decoration: InputDecoration(
                                                  suffixIcon: emailController
                                                          .text.isEmpty
                                                      ? Container(width: 0)
                                                      : IconButton(
                                                          icon: const Icon(
                                                            Icons.close,
                                                            color: blueColor,
                                                          ),
                                                          onPressed: () =>
                                                              emailController
                                                                  .clear(),
                                                        ),
                                                  prefixIcon: const Icon(
                                                      Icons.email_sharp,
                                                      color: blueColor),
                                                  hintText: 'name@example.com',
                                                  labelText:
                                                      '2nd CSU text field'.tr,
                                                  border:
                                                      const OutlineInputBorder(),
                                                  filled: true,
                                                  fillColor: Colors.grey
                                                      .withOpacity(.3),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    borderSide:
                                                        const BorderSide(
                                                      width: 1.8,
                                                      color: blueColor,
                                                    ),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors.grey
                                                                  .shade600),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                ),
                                                validator: emailValidator,
                                                onSaved: (email) =>
                                                    _email = email!,
                                              ),
                                              // TextFieldName(text: "Phone"),
                                              const SizedBox(
                                                  height: defaultPadding * 2),
                                              // TextFieldName(text: "Password"),

                                              TextFormField(
                                                controller: passwordController,
                                                obscureText: isObscure,
                                                decoration: InputDecoration(
                                                  prefixIcon: const Icon(
                                                      Icons.password_sharp,
                                                      color: blueColor),
                                                  labelText:
                                                      '3rd CSU text field'.tr,
                                                  border:
                                                      const OutlineInputBorder(),
                                                  filled: true,
                                                  fillColor: Colors.grey
                                                      .withOpacity(.3),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    borderSide:
                                                        const BorderSide(
                                                      width: 1.8,
                                                      color: blueColor,
                                                    ),
                                                  ),
                                                  suffixIcon: IconButton(
                                                    icon: isHide == true
                                                        ? const Icon(
                                                            Icons.visibility)
                                                        : const Icon(Icons
                                                            .visibility_off),
                                                    color: blueColor,
                                                    onPressed: () {
                                                      setState(
                                                        () {
                                                          isHide == true
                                                              ? isHide = !isHide
                                                              : isHide = true;
                                                          isObscure == false
                                                              ? isObscure =
                                                                  !isObscure
                                                              : isObscure =
                                                                  false;
                                                        },
                                                      );
                                                    },
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors.grey
                                                                  .shade600),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                ),
                                                validator: passwordValidator,
                                                onSaved: (password) =>
                                                    _password = password!,
                                                onChanged: (pass) =>
                                                    _password = pass,
                                              ),
                                              const SizedBox(
                                                  height: defaultPadding * 2),
                                              // TextFieldName(text: "Confirm Password"),
                                              TextFormField(
                                                controller: confirmController,
                                                obscureText: isObscure,
                                                decoration: InputDecoration(
                                                  prefixIcon: const Icon(
                                                      Icons.verified_user,
                                                      color: blueColor),
                                                  labelText:
                                                      '4th CSU text field'.tr,
                                                  border:
                                                      const OutlineInputBorder(),
                                                  filled: true,
                                                  fillColor: Colors.grey
                                                      .withOpacity(.3),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    borderSide:
                                                        const BorderSide(
                                                      width: 1.8,
                                                      color: blueColor,
                                                    ),
                                                  ),
                                                  suffixIcon: IconButton(
                                                    icon: isHide
                                                        ? const Icon(
                                                            Icons.visibility)
                                                        : const Icon(Icons
                                                            .visibility_off),
                                                    color: blueColor,
                                                    onPressed: () {
                                                      setState(
                                                        () {
                                                          isHide == true
                                                              ? isHide = !isHide
                                                              : isHide = true;
                                                          isObscure == true
                                                              ? isObscure =
                                                                  false
                                                              : isObscure =
                                                                  !isObscure;
                                                        },
                                                      );
                                                    },
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors.grey
                                                                  .shade600),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                ),
                                                validator: (pass) => MatchValidator(
                                                        errorText:
                                                            "Password do not  match")
                                                    .validateMatch(
                                                        pass!, _password),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Column(
                                          children: [
                                            Form(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 55,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8.0,
                                                              left: 8),
                                                      child: TextFormField(
                                                        controller:
                                                            addressController,
                                                        keyboardType:
                                                            TextInputType.text,
                                                        decoration:
                                                            InputDecoration(
                                                                suffixIcon: addressController
                                                                        .text
                                                                        .isEmpty
                                                                    ? Container(
                                                                        width:
                                                                            0)
                                                                    : IconButton(
                                                                        icon:
                                                                            const Icon(
                                                                          Icons
                                                                              .close,
                                                                          color:
                                                                              blueColor,
                                                                        ),
                                                                        onPressed:
                                                                            () =>
                                                                                addressController.clear(),
                                                                      ),
                                                                labelText:
                                                                    '2nd text field page1'
                                                                        .tr,
                                                                border:
                                                                    const OutlineInputBorder(),
                                                                filled: true,
                                                                fillColor: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        .3),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15),
                                                                  borderSide:
                                                                      const BorderSide(
                                                                    width: 1.8,
                                                                    color:
                                                                        blueColor,
                                                                  ),
                                                                ),
                                                                enabledBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Colors
                                                                            .grey
                                                                            .shade600),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15))),
                                                        validator:
                                                            RequiredValidator(
                                                                errorText:
                                                                    "Address is required"),
                                                        onSaved: (Address) =>
                                                            _address = Address!,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                      height: defaultPadding),
                                                  SizedBox(
                                                    height: 55,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8.0,
                                                              left: 8),
                                                      child:
                                                          InternationalPhoneNumberInput(
                                                        //initialValue: PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber),
                                                        selectorConfig:
                                                            const SelectorConfig(
                                                          leadingPadding: 10,
                                                          selectorType:
                                                              PhoneInputSelectorType
                                                                  .DIALOG,
                                                          showFlags: true,
                                                          useEmoji: true,
                                                          trailingSpace: false,
                                                          setSelectorButtonAsPrefixIcon:
                                                              true,
                                                        ),
                                                        textFieldController: phoneController,
                                                        formatInput: true,
                                                        spaceBetweenSelectorAndTextField:
                                                            0,
                                                        onInputChanged:
                                                            (PhoneNumber
                                                                value) {},
                                                        searchBoxDecoration:
                                                            InputDecoration(
                                                          prefixIcon:
                                                              const Icon(
                                                            Icons.search,
                                                            color: blueColor,
                                                          ),
                                                          hintText: 'Search',
                                                          filled: true,
                                                          fillColor: Colors.grey
                                                              .withOpacity(.3),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            borderSide:
                                                                const BorderSide(
                                                              width: 1.8,
                                                              color: blueColor,
                                                            ),
                                                          ),
                                                        ),

                                                        inputDecoration:
                                                            InputDecoration(
                                                                labelText:
                                                                    '3rd text field page1'
                                                                        .tr,
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15),
                                                                  borderSide:
                                                                      const BorderSide(
                                                                    width: 1.8,
                                                                    color:
                                                                        blueColor,
                                                                  ),
                                                                ),
                                                                filled: true,
                                                                fillColor: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        .3),
                                                                enabledBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Colors
                                                                            .grey
                                                                            .shade600),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15))),
                                                        validator:
                                                            phoneValidator,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: defaultPadding,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8.0,
                                                            left: 8),
                                                    child: TextFormField(
                                                      maxLines: 2,
                                                      autocorrect: true,
                                                      controller:
                                                          experienceController,
                                                      keyboardType:
                                                          TextInputType
                                                              .multiline,
                                                      decoration:
                                                          InputDecoration(
                                                        suffixIcon:
                                                            experienceController
                                                                    .text
                                                                    .isEmpty
                                                                ? Container(
                                                                    width: 0)
                                                                : IconButton(
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .close,
                                                                      color:
                                                                          blueColor,
                                                                    ),
                                                                    onPressed: () =>
                                                                        experienceController
                                                                            .clear(),
                                                                  ),
                                                        labelText:
                                                            '4th text field page1'
                                                                .tr,
                                                        border:
                                                            const OutlineInputBorder(),
                                                        filled: true,
                                                        fillColor: Colors.grey
                                                            .withOpacity(.3),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          borderSide:
                                                              const BorderSide(
                                                            width: 1.8,
                                                            color: blueColor,
                                                          ),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors.grey
                                                                  .shade600),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ),
                                                      ),
                                                      validator: RequiredValidator(
                                                          errorText:
                                                              "Your Experience is required"),
                                                      onSaved: (Experience) =>
                                                          _experience =
                                                              Experience!,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: defaultPadding,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8.0,
                                                            left: 8),
                                                    child: TextFormField(
                                                      maxLines: 2,
                                                      autocorrect: true,
                                                      controller:
                                                          yearsController,
                                                      keyboardType:
                                                          TextInputType
                                                              .multiline,
                                                      decoration:
                                                          InputDecoration(
                                                        suffixIcon:
                                                            yearsController.text
                                                                    .isEmpty
                                                                ? Container(
                                                                    width: 0)
                                                                : IconButton(
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .close,
                                                                      color:
                                                                          blueColor,
                                                                    ),
                                                                    onPressed: () =>
                                                                        yearsController
                                                                            .clear(),
                                                                  ),
                                                        labelText:
                                                            '5th text field page1'
                                                                .tr,
                                                        border:
                                                            const OutlineInputBorder(),
                                                        filled: true,
                                                        fillColor: Colors.grey
                                                            .withOpacity(.3),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          borderSide:
                                                              const BorderSide(
                                                            width: 1.8,
                                                            color: blueColor,
                                                          ),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors.grey
                                                                  .shade600),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ),
                                                      ),
                                                      validator: RequiredValidator(
                                                          errorText:
                                                              "Your Experience years is required"),
                                                      onSaved: (Experience) =>
                                                          _experience =
                                                              Experience!,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: defaultPadding,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            const SizedBox(
                                              height: defaultPadding * 2,
                                            ),
                                            Container(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                'Consultation types:',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        Colors.grey.shade800),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 350,
                                              child: ChipsChoice<int>.single(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                value: tag,
                                                onChanged: (val) => setState(
                                                  () => tag = val,
                                                ),
                                                choiceItems: C2Choice.listFrom<
                                                    int, String>(
                                                  source: options,
                                                  value: (i, v) => i,
                                                  label: (i, v) => v,
                                                ),
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 5, 10, 5),
                                                choiceBuilder: (item, i) {
                                                  return CustomChip(
                                                    label: item.label,
                                                    width: 80,
                                                    height: 90,
                                                    color: goldColor,
                                                    margin: const EdgeInsets
                                                        .fromLTRB(10, 5, 0, 5),
                                                    selected: item.selected,
                                                    onSelect: item.select!,
                                                  );
                                                },
                                              ),
                                            ),
                                            const SizedBox(
                                              height: defaultPadding * 2,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'appointment fees'.tr,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          Colors.grey.shade800),
                                                ),
                                                const SizedBox(
                                                  width: 30,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5),
                                                  child: Container(
                                                    height: 45,
                                                    width: 80,
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey
                                                            .withOpacity(.3),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        border: Border.all(
                                                            color: Colors.grey
                                                                .shade600)),
                                                    child: Center(
                                                        child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          height: 30,
                                                          width: 43,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            color: Colors.white,
                                                          ),
                                                          child:
                                                              PageView.builder(
                                                                  controller:
                                                                      feesController,
                                                                  scrollDirection:
                                                                      Axis
                                                                          .vertical,
                                                                  itemCount: 41,
                                                                  itemBuilder:
                                                                      (context,
                                                                          feesValue) {
                                                                    return Center(
                                                                      child:
                                                                          Text(
                                                                        '${feesValue * 50}',
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.w400),
                                                                      ),
                                                                    );
                                                                  }),
                                                        ),
                                                        const SizedBox(
                                                          width: 6,
                                                        ),
                                                        const Text(
                                                          '\$',
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: defaultPadding * 2,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'appointment period'.tr,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          Colors.grey.shade800),
                                                ),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5),
                                                  child: Container(
                                                    height: 45,
                                                    width: 80,
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey
                                                            .withOpacity(.3),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        border: Border.all(
                                                            color: Colors.grey
                                                                .shade600)),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          height: 30,
                                                          width: 35,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            color: Colors.white,
                                                          ),
                                                          child:
                                                              PageView.builder(
                                                            controller:
                                                                durationController,
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            itemCount: 61,
                                                            itemBuilder: (context,
                                                                durationValue) {
                                                              return Center(
                                                                child: Text(
                                                                  '${durationValue}',
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 4),
                                                        const Text(
                                                          'Min',
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: defaultPadding),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CircleAvatar(
                                                  radius: 20,
                                                  backgroundColor:
                                                      Colors.blue.shade300,
                                                  child: const Text(
                                                    'S',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          20, 10, 0, 0),
                                                  child: Container(
                                                    child: DateTimeField(
                                                      decoration: InputDecoration(
                                                          labelText:
                                                              "Start Time",
                                                          enabledBorder: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color: Colors
                                                                          .black38,
                                                                      width:
                                                                          2))),
                                                      format: format,
                                                      onShowPicker: (context,
                                                          currentValue) async {
                                                        final time =
                                                            await showTimePicker(
                                                          context: context,
                                                          initialTime: TimeOfDay
                                                              .fromDateTime(
                                                                  currentValue ??
                                                                      DateTime
                                                                          .now()),
                                                        );
                                                        return DateTimeField
                                                            .convert(time);
                                                      },
                                                    ),
                                                    width: 120,
                                                    height: 40,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 10, 0, 0),
                                                  child: Container(
                                                    child: DateTimeField(
                                                      decoration: InputDecoration(
                                                          labelText: "End Time",
                                                          enabledBorder: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color: Colors
                                                                          .black38,
                                                                      width:
                                                                          2))),
                                                      format: format,
                                                      onShowPicker: (context,
                                                          currentValue) async {
                                                        final time =
                                                            await showTimePicker(
                                                          context: context,
                                                          initialTime: TimeOfDay
                                                              .fromDateTime(
                                                                  currentValue ??
                                                                      DateTime
                                                                          .now()),
                                                        );
                                                        return DateTimeField
                                                            .convert(time);
                                                      },
                                                    ),
                                                    width: 120,
                                                    height: 40,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                                height: defaultPadding),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CircleAvatar(
                                                  radius: 20,
                                                  backgroundColor:
                                                      Colors.blue.shade300,
                                                  child: const Text(
                                                    'M',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          20, 10, 0, 0),
                                                  child: Container(
                                                    child: DateTimeField(
                                                      decoration: InputDecoration(
                                                          labelText:
                                                              "Start Time",
                                                          enabledBorder: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color: Colors
                                                                          .black38,
                                                                      width:
                                                                          2))),
                                                      format: format,
                                                      onShowPicker: (context,
                                                          currentValue) async {
                                                        final time =
                                                            await showTimePicker(
                                                          context: context,
                                                          initialTime: TimeOfDay
                                                              .fromDateTime(
                                                                  currentValue ??
                                                                      DateTime
                                                                          .now()),
                                                        );
                                                        return DateTimeField
                                                            .convert(time);
                                                      },
                                                    ),
                                                    width: 120,
                                                    height: 40,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 10, 0, 0),
                                                  child: Container(
                                                    child: DateTimeField(
                                                      decoration: InputDecoration(
                                                          labelText: "End Time",
                                                          enabledBorder: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color: Colors
                                                                          .black38,
                                                                      width:
                                                                          2))),
                                                      format: format,
                                                      onShowPicker: (context,
                                                          currentValue) async {
                                                        final time =
                                                            await showTimePicker(
                                                          context: context,
                                                          initialTime: TimeOfDay
                                                              .fromDateTime(
                                                                  currentValue ??
                                                                      DateTime
                                                                          .now()),
                                                        );
                                                        return DateTimeField
                                                            .convert(time);
                                                      },
                                                    ),
                                                    width: 120,
                                                    height: 40,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                                height: defaultPadding),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CircleAvatar(
                                                  radius: 20,
                                                  backgroundColor:
                                                      Colors.blue.shade300,
                                                  child: const Text(
                                                    'T',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          20, 10, 0, 0),
                                                  child: Container(
                                                    child: DateTimeField(
                                                      decoration: InputDecoration(
                                                          labelText:
                                                              "Start Time",
                                                          enabledBorder: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color: Colors
                                                                          .black38,
                                                                      width:
                                                                          2))),
                                                      format: format,
                                                      onShowPicker: (context,
                                                          currentValue) async {
                                                        final time =
                                                            await showTimePicker(
                                                          context: context,
                                                          initialTime: TimeOfDay
                                                              .fromDateTime(
                                                                  currentValue ??
                                                                      DateTime
                                                                          .now()),
                                                        );
                                                        return DateTimeField
                                                            .convert(time);
                                                      },
                                                    ),
                                                    width: 120,
                                                    height: 40,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 10, 0, 0),
                                                  child: Container(
                                                    child: DateTimeField(
                                                      decoration: InputDecoration(
                                                          labelText: "End Time",
                                                          enabledBorder: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color: Colors
                                                                          .black38,
                                                                      width:
                                                                          2))),
                                                      format: format,
                                                      onShowPicker: (context,
                                                          currentValue) async {
                                                        final time =
                                                            await showTimePicker(
                                                          context: context,
                                                          initialTime: TimeOfDay
                                                              .fromDateTime(
                                                                  currentValue ??
                                                                      DateTime
                                                                          .now()),
                                                        );
                                                        return DateTimeField
                                                            .convert(time);
                                                      },
                                                    ),
                                                    width: 120,
                                                    height: 40,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                                height: defaultPadding),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CircleAvatar(
                                                  radius: 20,
                                                  backgroundColor:
                                                      Colors.blue.shade300,
                                                  child: const Text(
                                                    'W',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          20, 10, 0, 0),
                                                  child: Container(
                                                    child: DateTimeField(
                                                      decoration: InputDecoration(
                                                          labelText:
                                                              "Start Time",
                                                          enabledBorder: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color: Colors
                                                                          .black38,
                                                                      width:
                                                                          2))),
                                                      format: format,
                                                      onShowPicker: (context,
                                                          currentValue) async {
                                                        final time =
                                                            await showTimePicker(
                                                          context: context,
                                                          initialTime: TimeOfDay
                                                              .fromDateTime(
                                                                  currentValue ??
                                                                      DateTime
                                                                          .now()),
                                                        );
                                                        return DateTimeField
                                                            .convert(time);
                                                      },
                                                    ),
                                                    width: 120,
                                                    height: 40,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 10, 0, 0),
                                                  child: Container(
                                                    child: DateTimeField(
                                                      decoration: InputDecoration(
                                                          labelText: "End Time",
                                                          enabledBorder: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color: Colors
                                                                          .black38,
                                                                      width:
                                                                          2))),
                                                      format: format,
                                                      onShowPicker: (context,
                                                          currentValue) async {
                                                        final time =
                                                            await showTimePicker(
                                                          context: context,
                                                          initialTime: TimeOfDay
                                                              .fromDateTime(
                                                                  currentValue ??
                                                                      DateTime
                                                                          .now()),
                                                        );
                                                        return DateTimeField
                                                            .convert(time);
                                                      },
                                                    ),
                                                    width: 120,
                                                    height: 40,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                                height: defaultPadding),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CircleAvatar(
                                                  radius: 20,
                                                  backgroundColor:
                                                      Colors.blue.shade300,
                                                  child: const Text(
                                                    'T',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          20, 10, 0, 0),
                                                  child: Container(
                                                    child: DateTimeField(
                                                      decoration: InputDecoration(
                                                          labelText:
                                                              "Start Time",
                                                          enabledBorder: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color: Colors
                                                                          .black38,
                                                                      width:
                                                                          2))),
                                                      format: format,
                                                      onShowPicker: (context,
                                                          currentValue) async {
                                                        final time =
                                                            await showTimePicker(
                                                          context: context,
                                                          initialTime: TimeOfDay
                                                              .fromDateTime(
                                                                  currentValue ??
                                                                      DateTime
                                                                          .now()),
                                                        );
                                                        return DateTimeField
                                                            .convert(time);
                                                      },
                                                    ),
                                                    width: 120,
                                                    height: 40,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 10, 0, 0),
                                                  child: Container(
                                                    child: DateTimeField(
                                                      decoration: InputDecoration(
                                                          labelText: "End Time",
                                                          enabledBorder: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color: Colors
                                                                          .black38,
                                                                      width:
                                                                          2))),
                                                      format: format,
                                                      onShowPicker: (context,
                                                          currentValue) async {
                                                        final time =
                                                            await showTimePicker(
                                                          context: context,
                                                          initialTime: TimeOfDay
                                                              .fromDateTime(
                                                                  currentValue ??
                                                                      DateTime
                                                                          .now()),
                                                        );
                                                        return DateTimeField
                                                            .convert(time);
                                                      },
                                                    ),
                                                    width: 120,
                                                    height: 40,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                                height: defaultPadding),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CircleAvatar(
                                                  radius: 20,
                                                  backgroundColor:
                                                      Colors.blue.shade300,
                                                  child: const Text(
                                                    'F',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          20, 10, 0, 0),
                                                  child: Container(
                                                    child: DateTimeField(
                                                      decoration: InputDecoration(
                                                          labelText:
                                                              "Start Time",
                                                          enabledBorder: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color: Colors
                                                                          .black38,
                                                                      width:
                                                                          2))),
                                                      format: format,
                                                      onShowPicker: (context,
                                                          currentValue) async {
                                                        final time =
                                                            await showTimePicker(
                                                          context: context,
                                                          initialTime: TimeOfDay
                                                              .fromDateTime(
                                                                  currentValue ??
                                                                      DateTime
                                                                          .now()),
                                                        );
                                                        return DateTimeField
                                                            .convert(time);
                                                      },
                                                    ),
                                                    width: 120,
                                                    height: 40,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 10, 0, 0),
                                                  child: Container(
                                                    child: DateTimeField(
                                                      decoration: InputDecoration(
                                                          labelText: "End Time",
                                                          enabledBorder: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color: Colors
                                                                          .black38,
                                                                      width:
                                                                          2))),
                                                      format: format,
                                                      onShowPicker: (context,
                                                          currentValue) async {
                                                        final time =
                                                            await showTimePicker(
                                                          context: context,
                                                          initialTime: TimeOfDay
                                                              .fromDateTime(
                                                                  currentValue ??
                                                                      DateTime
                                                                          .now()),
                                                        );
                                                        return DateTimeField
                                                            .convert(time);
                                                      },
                                                    ),
                                                    width: 120,
                                                    height: 40,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                    title: [
                                      PTitle(
                                        activeColor: Colors.black,
                                        subTitle: '1st ER subtitle'.tr,
                                        title: '1st ER title'.tr,
                                      ),
                                      PTitle(
                                        activeColor: Colors.black,
                                        subTitle: '2nd ER subtitle'.tr,
                                        title: '2nd ER title'.tr,
                                      ),
                                      PTitle(
                                        activeColor: Colors.black,
                                        subTitle: "3rd ER subtitle".tr,
                                        title: "3rd ER title".tr,
                                      ),
                                      PTitle(
                                        activeColor: Colors.black,
                                        subTitle: "4th ER subtitle".tr,
                                        title: "4th ER title".tr,
                                      ),
                                    ])
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              pformcontroller?.prevPage();
              setState(() {});
            },
            child: Visibility(
              visible: pformcontroller?.currentPage != 0 ? true : false,
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                height: 50,
                width: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    goldColor,
                    Colors.amber.shade500,
                    Colors.amber.shade400,
                    Colors.amber.shade300,
                    Colors.amber.shade200,
                    Colors.white
                  ], end: Alignment.topCenter, begin: Alignment.bottomCenter),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          InkWell(
            onTap: () {
              pformcontroller?.nextPage();
              setState(() {});
            },
            child: Visibility(
              visible:
                  pformcontroller?.currentPage == pformcontroller!.length! - 1
                      ? false
                      : true,
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                height: 50,
                width: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    goldColor,
                    Colors.amber.shade500,
                    Colors.amber.shade400,
                    Colors.amber.shade300,
                    Colors.amber.shade200,
                    Colors.white
                  ], end: Alignment.topCenter, begin: Alignment.bottomCenter),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomChip extends StatelessWidget {
  final String label;
  final Color? color;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final bool selected;
  final Function(bool selected) onSelect;

  const CustomChip({
    Key? key,
    required this.label,
    this.color,
    this.width,
    this.height,
    this.margin,
    this.selected = false,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedContainer(
      width: width,
      height: 65,
      margin: margin ?? const EdgeInsets.symmetric(vertical: 15, horizontal: 1),
      duration: const Duration(milliseconds: 300),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: selected
            ? (color ?? Colors.green)
            : theme.unselectedWidgetColor.withOpacity(.12),
        borderRadius: BorderRadius.all(Radius.circular(selected ? 20 : 10)),
        border: Border.all(
          color: selected
              ? (color ?? Colors.green)
              : theme.colorScheme.onSurface.withOpacity(.38),
          width: 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(selected ? 20 : 10)),
        onTap: () => onSelect(!selected),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            AnimatedCheckmark(
              active: selected,
              color: Colors.white,
              size: const Size.square(32),
              weight: 5,
              duration: const Duration(milliseconds: 400),
            ),
            Positioned(
              left: 9,
              right: 9,
              bottom: 7,
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: selected ? Colors.white : theme.colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
