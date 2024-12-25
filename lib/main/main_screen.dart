import 'package:flutter/material.dart';
import 'package:submission_dicoding/main/components/list_of_email.dart';
import 'package:submission_dicoding/email/email_screen.dart';
import 'package:submission_dicoding/models/email.dart';
import 'package:submission_dicoding/responsive.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Email? selectedEmail; 

  @override
  void initState() {
    super.initState();
    selectedEmail = emails[0]; 
  }

  void updateSelectedEmail(Email email) {
    setState(() {
      selectedEmail = email;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
        mobile: ListOfEmails(onEmailSelected: updateSelectedEmail),
        tablet: Row(
          children: [
            Expanded(
              flex: 6,
              child: ListOfEmails(onEmailSelected: updateSelectedEmail),
            ),
            Expanded(
              flex: 9,
              child: EmailScreen(
                email: selectedEmail ?? emails[0], 
              ),
            ),
          ],
        ),
        desktop: Row(
          children: [
            Expanded(
              flex: size.width > 1340 ? 3 : 5,
              child: ListOfEmails(onEmailSelected: updateSelectedEmail),
            ),
            Expanded(
              flex: size.width > 1340 ? 8 : 10,
              child: EmailScreen(
                email: selectedEmail ?? emails[0], 
              ),
            ),
          ],
        ),
      ),
    );
  }
}
