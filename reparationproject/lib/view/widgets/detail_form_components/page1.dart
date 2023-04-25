import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../constants/constant.dart';

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  String? _path;
  late String _firstName,
      _email,
      _password,
      _phoneNumber,
      _address,
      _experience;
  final numberController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final addressController = TextEditingController();
  final experienceController = TextEditingController();
  final yearsController = PageController(initialPage: 15);

  @override
  void initState() {
    super.initState();
    firstNameController.addListener(() => setState(() {}));
    lastNameController.addListener(() => setState(() {}));
    numberController.addListener(() => setState(() {}));
    addressController.addListener(() => setState(() {}));
    experienceController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    numberController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    addressController.dispose();
    experienceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(right: 8.0, left: 8),
                //   child: SizedBox(
                //     height: 55,
                //     child: TextFormField(
                //       controller: firstNameController,
                //       decoration: InputDecoration(
                //         prefixText: ' Mr/Mrs. ',
                //         prefixStyle:
                //             TextStyle(color: Colors.black, fontSize: 15),
                //         suffixIcon: firstNameController.text.isEmpty
                //             ? Container(width: 0)
                //             : IconButton(
                //                 icon: Icon(
                //                   Icons.close,
                //                   color: blueColor,
                //                 ),
                //                 onPressed: () => firstNameController.clear(),
                //               ),
                //         labelText: '1st text field page1'.tr,
                //         border: OutlineInputBorder(
                //             borderSide: BorderSide(color: blueColor)),
                //         filled: true,
                //         fillColor: Colors.grey.withOpacity(.3),
                //         focusedBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(15),
                //           borderSide: BorderSide(
                //             width: 1.8,
                //             color: blueColor,
                //           ),
                //         ),
                //         enabledBorder: OutlineInputBorder(
                //           borderSide: BorderSide(color: Colors.grey.shade600),
                //           borderRadius: BorderRadius.circular(15),
                //         ),
                //       ),
                //       validator: usernameValidator,
                //       onSaved: (firstName) => _firstName = firstName!,
                //     ),
                //   ),
                // ),
                // SizedBox(height: defaultPadding),
                SizedBox(
                  height: 55,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8),
                    child: TextFormField(
                      controller: addressController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          suffixIcon: addressController.text.isEmpty
                              ? Container(width: 0)
                              : IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    color: blueColor,
                                  ),
                                  onPressed: () => addressController.clear(),
                                ),
                          labelText:'2nd text field page1'.tr,
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.grey.withOpacity(.3),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              width: 1.8,
                              color: blueColor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade600),
                              borderRadius: BorderRadius.circular(15))),
                      validator:
                          RequiredValidator(errorText: "Address is required"),
                      onSaved: (Address) => _address = Address!,
                    ),
                  ),
               ),
                SizedBox(height: defaultPadding),
                SizedBox(
                  height: 55,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8),
                    child: InternationalPhoneNumberInput(
                      //initialValue: PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber),
                      selectorConfig: SelectorConfig(
                        leadingPadding: 10,
                        selectorType: PhoneInputSelectorType.DIALOG,
                        showFlags: true,
                        useEmoji: true,
                        trailingSpace: false,
                        setSelectorButtonAsPrefixIcon: true,
                      ),
                      formatInput: true,
                      spaceBetweenSelectorAndTextField: 0,
                      onInputChanged: (PhoneNumber value) {},
                      searchBoxDecoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: blueColor,
                        ),
                        hintText: 'Search',
                        filled: true,
                        fillColor: Colors.grey.withOpacity(.3),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            width: 1.8,
                            color: blueColor,
                          ),
                        ),
                      ),
                      inputDecoration: InputDecoration(
                          labelText: '3rd text field page1'.tr,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              width: 1.8,
                              color: blueColor,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.grey.withOpacity(.3),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade600),
                              borderRadius: BorderRadius.circular(15))),
                      validator: phoneValidator,
                    ),
                  ),
                ),
                SizedBox(
                  height: defaultPadding,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8),
                  child: TextFormField(
                    maxLines: 2,
                    autocorrect: true,
                    controller: experienceController,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      suffixIcon: experienceController.text.isEmpty
                          ? Container(width: 0)
                          : IconButton(
                              icon: Icon(
                                Icons.close,
                                color: blueColor,
                              ),
                              onPressed: () => experienceController.clear(),
                            ),
                      labelText: '4th text field page1'.tr,
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(.3),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          width: 1.8,
                          color: blueColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade600),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    validator: RequiredValidator(
                        errorText: "Your Experience is required"),
                    onSaved: (Experience) => _experience = Experience!,
                  ),
                ),
                SizedBox(
                  height: defaultPadding,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    children: [
                      Text(
                        '5th text field page1'.tr,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade800),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Container(
                          height: 45,
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(.3),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.grey.shade600)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 20,
                                width: 25,
                                child: PageView.builder(
                                    controller: yearsController,
                                    scrollDirection: Axis.vertical,
                                    itemCount: 61,
                                    itemBuilder: (context, durationValue) {
                                      return Text(
                                        '${durationValue}',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400),
                                      );
                                    }),
                              ),
                              Text(
                                'years of experience'.tr,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
