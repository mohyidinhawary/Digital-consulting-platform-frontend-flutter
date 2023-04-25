import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../screens/c_compose_email_screen.dart';
import '../../screens/mail_detailed_screen.dart';
import '../../screens/temporary_data.dart';

class EMail extends StatefulWidget {
  EMail({Key? key}) : super(key: key);

  @override
  _EMailState createState() => _EMailState();
}

class _EMailState extends State<EMail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _selectedItem = 0;

  fetchExpertInbox() async {
    var response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/get_expert_inbox/1'),
    );
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      print(response.body);
      print('success');
      return responseBody;
      // var request = http.Request(
      //     'GET', Uri.parse('http://10.0.2.2:8000/api/get'));
      // http.StreamedResponse response = await request.send();
      // if (response.statusCode == 200) {
      //   print(await response.stream.bytesToString());
      //   print('success');
      //   print();
      // } else {
      //   print(response.reasonPhrase);
      // }

    } else {
      print('failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    MySize = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      key: _scaffoldKey,
      drawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: kPadding),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Mail',
                    style: TextStyle(
                      fontSize: kPadding - 2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: kPadding - 10),
                Divider(
                  height: 2,
                  color: Colors.black54,
                ),
                SizedBox(height: kPadding - 10),
                buildDrawerItem(Icons.inbox, 'All Inbox', 0),
                SizedBox(height: kPadding - 10),
                Divider(
                  height: 2,
                  color: Colors.black54,
                ),
                buildDrawerItem(Icons.email_outlined, 'Primary', 1),
                buildDrawerItem(Icons.person, 'Social', 2),
                buildDrawerItem(Icons.tag, 'Promotion', 3),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('ALL LABLES',
                      style: TextStyle(
                          fontSize: kPadding - 5, fontWeight: FontWeight.w600)),
                ),
                buildDrawerItem(Icons.star_rate_outlined, 'Starred', 4),
                buildDrawerItem(Icons.history_toggle_off, 'Snoozed', 5),
                buildDrawerItem(Icons.drafts, 'Drafts', 6),
                buildDrawerItem(Icons.bug_report_outlined, 'Spam', 7),
                buildDrawerItem(Icons.delete, 'Bin', 8),
                buildDrawerItem(Icons.send, 'Sent', 9),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('OTHER APPS',
                      style: TextStyle(
                          fontSize: kPadding - 5, fontWeight: FontWeight.w600)),
                ),
                buildDrawerItem(Icons.calendar_today, 'Calender', 10),
                buildDrawerItem(Icons.contacts, 'Contact', 11),
                buildDrawerItem(Icons.settings, 'Settings', 12),
                buildDrawerItem(Icons.help_outline, 'Help and feedback', 13),
              ],
            ),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: kPadding - 15),
              //------------Header
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Colors.black26,
                      offset: Offset(2, 0),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.menu,
                        size: 24,
                        color: Colors.black54,
                      ),
                      onPressed: () {
                        _scaffoldKey.currentState!.openDrawer();
                      },
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search here',
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            isDense: false,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => buildAccountSetting(),
                        );
                      },
                      child: CircleAvatar(
                        radius: 18,
                      ),
                    ),
                    SizedBox(width: kPadding - 15),
                  ],
                ),
              ),
              SizedBox(height: kPadding - 8),
              //------------Heading title
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'PRIMARY MAILS',
                  style: TextStyle(
                    color: Colors.black54,
                    wordSpacing: 3,
                  ),
                ),
              ),
              SizedBox(height: kPadding - 10),
              //------------Content/Mails
              Expanded(
                child: FutureBuilder(
                  future: fetchExpertInbox(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data['inbox'].length,
                      itemBuilder: (context, index) {
                        print(snapshot.data['inbox'][index]["subject"]);
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return MailDetailScreen(
                                    heading: snapshot.data['inbox'][index]["subject"],
                                    mail: snapshot.data['inbox'][index]["description"],
                                    time: mailList[index].time,
                                  );
                                },
                              ),
                            );
                          },
                          child: MailItemWidget(
                            title:snapshot.data['inbox'][index]["subject"],
                            content: mailList[index].content,
                            description: snapshot.data['inbox'][index]["description"],
                            time: mailList[index].time,
                            isRead: mailList[index].isRead,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CComposeScreen(),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: kPadding - 8, vertical: kPadding - 12),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                color: Colors.black26,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.edit,
                color: Colors.white,
                size: 24,
              ),
              SizedBox(width: kPadding - 10),
              Text(
                'Compose',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAccountSetting() {
    return Dialog(
      elevation: 15,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: kPadding - 10),
                AccountWidget(
                  name: 'Gautam Singh',
                  mail: 'gautam@p.com',
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: kPadding - 8,
                    vertical: kPadding - 15,
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: kPadding,
                    vertical: kPadding - 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Colors.black26,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text('Manage your account',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700])),
                ),
                Divider(height: 2, color: Colors.black45),
                SizedBox(height: kPadding - 15),
                AccountWidget(
                  name: 'Kalpna Chawla',
                  mail: 'kalpna@kp.com',
                ),
                AccountWidget(
                  name: 'Parsuram',
                  mail: 'solid@bro.com',
                ),
                AccountWidget(
                  name: 'Alexendor DD',
                  mail: 'dummy@comp.com',
                ),
                SizedBox(height: kPadding - 10),
                Container(
                  margin: EdgeInsets.only(
                    left: kPadding + 5,
                    bottom: kPadding - 10,
                  ),
                  child: Row(children: [
                    Icon(Icons.person_add, size: 24, color: Colors.grey[600]),
                    SizedBox(width: kPadding - 15),
                    Text('Add another account',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[700])),
                  ]),
                ),
                Divider(height: 2, color: Colors.black45),
                SizedBox(height: kPadding - 15),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: kPadding,
                    vertical: kPadding - 10,
                  ),
                  child: Text('Sign out all accounts',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87.withOpacity(0.8))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDrawerItem(IconData icon, String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedItem = index;
        });
      },
      child: Container(
        padding:
        EdgeInsets.symmetric(horizontal: kPadding, vertical: kPadding - 10),
        margin: EdgeInsets.only(right: kPadding),
        decoration: BoxDecoration(
          color: index == _selectedItem ? Colors.blue.withOpacity(0.2) : null,
          borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 24),
            SizedBox(width: kPadding),
            Text(title, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class AccountWidget extends StatelessWidget {
  const AccountWidget({
    this.name,
    this.mail,
    this.imgPath,
    Key? key,
  }) : super(key: key);
  final String? name, mail, imgPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: kPadding - 8,
        vertical: kPadding - 15,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: kPadding,
        vertical: kPadding - 15,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.black26,
            offset: Offset(2, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 17,
            backgroundImage: AssetImage(imgPath!),
          ),
          SizedBox(width: kPadding - 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name!,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              Text(mail!,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }
}

class MailItemWidget extends StatelessWidget {
  const MailItemWidget({
    this.title,
    this.description,
    this.content,
    this.time,
    this.isRead,
    Key? key,
  }) : super(key: key);
  final String? title, description, content, time;
  final bool? isRead;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: kPadding - 16),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.black26,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Expanded(
        flex: 1,
        child: Row(
          children: [
            CircleAvatar(
              child: Text(title!.substring(0, 1)),
            ),
            SizedBox(width: kPadding - 12),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          title!,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight:
                            isRead! ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                      ),
                      Text(
                        time!,
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                  Text(
                    description!,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isRead! ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                  Text(
                    content!,
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
