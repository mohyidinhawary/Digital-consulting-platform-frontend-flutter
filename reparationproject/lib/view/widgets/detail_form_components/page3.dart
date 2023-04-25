
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/constant.dart';

class Page3 extends StatefulWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  final format = DateFormat("HH:mm");
  TimeOfDay timeOfDay=TimeOfDay(hour: 8,minute: 30);
  void _showTimePicker(){
    showTimePicker(context: context, initialTime: TimeOfDay.now(),);
  }
  final DateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: defaultPadding),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blue.shade300,
                child: Text(
                  'S',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20,10, 0, 0),
                child:Container(
                  child:  DateTimeField(
                    decoration: InputDecoration(
                        labelText:"Start Time",
                        enabledBorder: OutlineInputBorder(
                            borderRadius:BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Colors.black38,
                                width:2
                            )
                        )
                    ),
                    format: format,
                    onShowPicker: (context, currentValue) async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                      );
                      return DateTimeField.convert(time);
                    },
                  ),
                  width: 120,
                  height:40,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10,10, 0, 0),
                child:Container(
                  child:  DateTimeField(
                    decoration: InputDecoration(
                        labelText:"End Time",
                        enabledBorder: OutlineInputBorder(
                            borderRadius:BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Colors.black38,
                                width:2
                            )
                        )
                    ),
                    format: format,
                    onShowPicker: (context, currentValue) async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                      );
                      return DateTimeField.convert(time);
                    },
                  ),
                  width: 120,
                  height:40,
                ),
              ),
            ],
          ),
          SizedBox(height:defaultPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blue.shade300,
                child: Text(
                  'M',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20,10, 0, 0),
                child:Container(
                  child:  DateTimeField(
                    decoration: InputDecoration(
                        labelText:"Start Time",
                        enabledBorder: OutlineInputBorder(
                            borderRadius:BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Colors.black38,
                                width:2
                            )
                        )
                    ),
                    format: format,
                    onShowPicker: (context, currentValue) async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                      );
                      return DateTimeField.convert(time);
                    },
                  ),
                  width: 120,
                  height:40,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10,10, 0, 0),
                child:Container(
                  child:  DateTimeField(
                    decoration: InputDecoration(
                        labelText:"End Time",
                        enabledBorder: OutlineInputBorder(
                            borderRadius:BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Colors.black38,
                                width:2
                            )
                        )
                    ),
                    format: format,
                    onShowPicker: (context, currentValue) async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                      );
                      return DateTimeField.convert(time);
                    },
                  ),
                  width: 120,
                  height:40,
                ),
              ),
            ],
          ),
          SizedBox(height:defaultPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blue.shade300,
                child: Text(
                  'T',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20,10, 0, 0),
                child:Container(
                  child:  DateTimeField(
                    decoration: InputDecoration(
                        labelText:"Start Time",
                        enabledBorder: OutlineInputBorder(
                            borderRadius:BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Colors.black38,
                                width:2
                            )
                        )
                    ),
                    format: format,
                    onShowPicker: (context, currentValue) async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                      );
                      return DateTimeField.convert(time);
                    },
                  ),
                  width: 120,
                  height:40,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10,10, 0, 0),
                child:Container(
                  child:  DateTimeField(
                    decoration: InputDecoration(
                        labelText:"End Time",
                        enabledBorder: OutlineInputBorder(
                            borderRadius:BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Colors.black38,
                                width:2
                            )
                        )
                    ),
                    format: format,
                    onShowPicker: (context, currentValue) async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                      );
                      return DateTimeField.convert(time);
                    },
                  ),
                  width: 120,
                  height:40,
                ),
              ),
            ],
          ),
          SizedBox(height:defaultPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blue.shade300,
                child: Text(
                  'W',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20,10, 0, 0),
                child:Container(
                  child:  DateTimeField(
                    decoration: InputDecoration(
                        labelText:"Start Time",
                        enabledBorder: OutlineInputBorder(
                            borderRadius:BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Colors.black38,
                                width:2
                            )
                        )
                    ),
                    format: format,
                    onShowPicker: (context, currentValue) async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                      );
                      return DateTimeField.convert(time);
                    },
                  ),
                  width: 120,
                  height:40,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10,10, 0, 0),
                child:Container(
                  child:  DateTimeField(
                    decoration: InputDecoration(
                        labelText:"End Time",
                        enabledBorder: OutlineInputBorder(
                            borderRadius:BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Colors.black38,
                                width:2
                            )
                        )
                    ),
                    format: format,
                    onShowPicker: (context, currentValue) async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                      );
                      return DateTimeField.convert(time);
                    },
                  ),
                  width: 120,
                  height:40,
                ),
              ),
            ],
          ),
          SizedBox(height:defaultPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blue.shade300,
                child: Text(
                  'T',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20,10, 0, 0),
                child:Container(
                  child:  DateTimeField(
                    decoration: InputDecoration(
                        labelText:"Start Time",
                        enabledBorder: OutlineInputBorder(
                            borderRadius:BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Colors.black38,
                                width:2
                            )
                        )
                    ),
                    format: format,
                    onShowPicker: (context, currentValue) async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                      );
                      return DateTimeField.convert(time);
                    },
                  ),
                  width: 120,
                  height:40,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10,10, 0, 0),
                child:Container(
                  child:  DateTimeField(
                    decoration: InputDecoration(
                        labelText:"End Time",
                        enabledBorder: OutlineInputBorder(
                            borderRadius:BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Colors.black38,
                                width:2
                            )
                        )
                    ),
                    format: format,
                    onShowPicker: (context, currentValue) async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                      );
                      return DateTimeField.convert(time);
                    },
                  ),
                  width: 120,
                  height:40,
                ),
              ),
            ],
          ),
          SizedBox(height:defaultPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blue.shade300,
                child: Text(
                  'F',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20,10, 0, 0),
                child:Container(
                  child:  DateTimeField(
                    decoration: InputDecoration(
                        labelText:"Start Time",
                        enabledBorder: OutlineInputBorder(
                            borderRadius:BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Colors.black38,
                                width:2
                            )
                        )
                    ),
                    format: format,
                    onShowPicker: (context, currentValue) async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                      );
                      return DateTimeField.convert(time);
                    },
                  ),
                  width: 120,
                  height:40,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10,10, 0, 0),
                child:Container(
                  child:  DateTimeField(
                    decoration: InputDecoration(
                        labelText:"End Time",
                        enabledBorder: OutlineInputBorder(
                            borderRadius:BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Colors.black38,
                                width:2
                            )
                        )
                    ),
                    format: format,
                    onShowPicker: (context, currentValue) async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                      );
                      return DateTimeField.convert(time);
                    },
                  ),
                  width: 120,
                  height:40,
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
