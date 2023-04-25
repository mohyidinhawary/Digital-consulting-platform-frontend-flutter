import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im_stepper/stepper.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import '../../constants/constant.dart';
import '../widgets/book_appointment_components/stepper.dart';

class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({Key? key}) : super(key: key);

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  int activeStep = 0;
  int upperBound = 2;
  final firstNameController = TextEditingController();
  final AddressController = TextEditingController();
  final AgeController = TextEditingController();
  final DateController = TextEditingController();
  late String _firstName, address;
  late int age;

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

  fetchExperts() async {
    var response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/availableTime/1'),
    );
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      print('success');
      return responseBody;
    } else {
      print('failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 50,
                    foregroundImage: AssetImage('assets/images/doctor.jpg'),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text('Dr.Mohammed Jabber',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'headLine',
                              color: Colors.indigo.shade900,
                            )),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.grey.shade600,
                          ),
                          Text(
                            'Location clinic Address',
                            style: TextStyle(color: Colors.grey.shade800),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                SizedBox(width: 120),
                Text(
                  'appointment fees'.tr,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue),
                ),
                Text(
                  '\$1000',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: defaultPadding,
            ),
            IconStepper(
              icons: [
                Icon(
                  Icons.person,
                  color: Colors.white70,
                ),
                Icon(
                  Icons.date_range,
                  color: Colors.white70,
                ),
                Icon(Icons.account_balance_wallet, color: Colors.white70),
              ],

              // activeStep property set to activeStep variable defined above.
              activeStep: activeStep,
              activeStepColor: Colors.blue.shade300,

              // This ensures step-tapping updates the activeStep.
              onStepReached: (index) {
                setState(() {
                  activeStep = index;
                });
              },
            ),
            SizedBox(
              height: defaultPadding,
            ),
            header(),
            SizedBox(
              height: defaultPadding,
            ),
            content(),
          ],
        ),
      ),
    );
  }

  Widget nextButton() {
    return ElevatedButton(
      onPressed: () {
        // Increment activeStep, when the next button is tapped. However, check for upper bound.
        if (activeStep < upperBound) {
          setState(() {
            activeStep++;
          });
        }
      },
      child: Text('Next'),
    );
  }

  /// Returns the previous button.
  Widget previousButton() {
    return ElevatedButton(
      onPressed: () {
        // Decrement activeStep, when the previous button is tapped. However, check for lower bound i.e., must be greater than 0.
        if (activeStep > 0) {
          setState(() {
            activeStep--;
          });
        }
      },
      child: Text('Prev'),
    );
  }

  /// Returns the header wrapping the header text.
  Widget header() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade300,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              headerText(),
              style: TextStyle(
                color: Colors.indigo.shade900,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget header1() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
          ),
        ],
      ),
    );
  }

// Returns the header text based on the activeStep.
  String headerText() {
    switch (activeStep) {
      case 1:
        return '2nd step'.tr;

      case 2:
        return '3rd step'.tr;

      default:
        return '1st step'.tr;
    }
  }

  Widget content() {
    switch (activeStep) {
      case 1:
        return Padding(
          padding: const EdgeInsets.fromLTRB(
              defaultPadding, 8, defaultPadding, defaultPadding),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: DateController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.calendar_month),
                      prefixStyle: TextStyle(color: Colors.black, fontSize: 15),
                      suffixIcon: DateController.text.isEmpty
                          ? Container(width: 0)
                          : IconButton(
                              icon: Icon(
                                Icons.close,
                                color: Colors.blue.shade300,
                              ),
                              onPressed: () => DateController.clear(),
                            ),
                      labelText: 'date picker'.tr,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: blueColor)),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(.3),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          width: 1.8,
                          color: Colors.blue.shade300,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade600),
                          borderRadius: BorderRadius.circular(15))),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(
                        () {
                          DateController.text =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                        },
                      );
                    }
                  },
                ),
                SizedBox(height: 15),
                FutureBuilder(
                  future: fetchExperts(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if(snapshot.hasData) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 12.0,
                            mainAxisSpacing: 12.0,
                            mainAxisExtent: 70,
                          ),
                          itemCount: snapshot.data['message'].length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () async {
                                await postRequest(
                                  "http://10.0.2.2:8000/api/reservation/1/1",
                                  {
                                    "day": snapshot.data['message'][index]
                                        ['day'],
                                    "date": DateController.text,
                                    "from": snapshot.data['message'][index]
                                        ['from']
                                  },
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    16.0,
                                  ),
                                  color: Colors.blue.shade300,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(16.0),
                                        topRight: Radius.circular(16.0),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data['message'][index]
                                                ['day'],
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.indigo.shade900,
                                                fontFamily: 'headLine'),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            snapshot.data['message'][index]
                                                ['from'],
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white70,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  return CircularProgressIndicator();
                  },
                ),
              ],
            ),
          ),
        );
      case 2:
        return SingleChildScrollView(
          child: Column(children: [
            Lottie.asset(
              'assets/gifs/payment.json',
              height: 345,
            ),
            SizedBox(height: 3),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: MaterialButton(
                onPressed: () async {
                  // var request = http.Request('POST', Uri.parse('http://10.0.2.2:8000/api/pay/1'));
                  // request.body = '''{\r\n    "email":"mohammed@gmail.com"\r\n}''';
                  //
                  // http.StreamedResponse response = await request.send();
                  //
                  // if (response.statusCode == 200) {
                  //   print(await response.stream.bytesToString());
                  //   print('success');
                  // }
                  // else {
                  //   print(response['message']);
                  // print(response.reasonPhrase);
                  // print(response.statusCode);
                  // }
                  await postRequest('http://10.0.2.2:8000/api/pay/1',
                      {"email": "mohammed@gmail.com"});
                },
                height: 40,
                minWidth: MediaQuery.of(context).size.width / 3,
                color: Colors.blue.shade300,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                splashColor: mintColor,
                child: Text(
                  'payment button'.tr,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70),
                ),
              ),
            )
          ]),
        );
      default:
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 36),
                TextFormField(
                  controller: firstNameController,
                  decoration: InputDecoration(
                      prefixText: ' Mr/Mrs. ',
                      prefixStyle: TextStyle(color: Colors.black, fontSize: 15),
                      suffixIcon: firstNameController.text.isEmpty
                          ? Container(width: 0)
                          : IconButton(
                              icon: Icon(
                                Icons.close,
                                color: Colors.blue.shade300,
                              ),
                              onPressed: () => firstNameController.clear(),
                            ),
                      labelText: '1st text field'.tr,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: blueColor)),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(.3),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          width: 1.8,
                          color: Colors.blue.shade300,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade600),
                          borderRadius: BorderRadius.circular(15))),
                  validator: usernameValidator,
                  onSaved: (address) => address = address!,
                ),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: AddressController,
                  decoration: InputDecoration(
                      prefixStyle: TextStyle(color: Colors.black, fontSize: 15),
                      suffixIcon: AddressController.text.isEmpty
                          ? Container(width: 0)
                          : IconButton(
                              icon: Icon(
                                Icons.close,
                                color: Colors.blue.shade300,
                              ),
                              onPressed: () => AddressController.clear(),
                            ),
                      labelText: '2nd text field'.tr,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: blueColor)),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(.3),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          width: 1.8,
                          color: Colors.blue.shade300,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade600),
                          borderRadius: BorderRadius.circular(15))),
                  validator: usernameValidator,
                ),
                SizedBox(
                  height: 25,
                ),
                InternationalPhoneNumberInput(
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
                      labelText: '3rd text field'.tr,
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
                          borderSide: BorderSide(color: Colors.grey.shade600),
                          borderRadius: BorderRadius.circular(15))),
                  validator: phoneValidator,
                ),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: AgeController,
                  decoration: InputDecoration(
                    prefixStyle: TextStyle(color: Colors.black, fontSize: 15),
                    suffixIcon: AgeController.text.isEmpty
                        ? Container(width: 0)
                        : IconButton(
                            icon: Icon(
                              Icons.close,
                              color: blueColor,
                            ),
                            onPressed: () => AgeController.clear(),
                          ),
                    labelText: '4th text field'.tr,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: blueColor)),
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
                  validator: usernameValidator,
                  onSaved: (age) => age = age!,
                ),
              ],
            ),
          ),
        );
    }
  }
}
