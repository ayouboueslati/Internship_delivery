import 'dart:async';

import 'package:flutter/material.dart';

import '../../fitness_app/fitness_app_theme.dart';
import '../../pick.dart';
import '../widgets/display_image_widget.dart';
import '../user/user_data.dart';
import 'edit_email.dart';
import 'edit_image.dart';
import 'edit_name.dart';
import 'edit_phone.dart';
import '../../auth/signin/screens/login_screen.dart'; // Import the LoginScreen

// This class handles the Page to display the user's info on the "Edit Profile" Screen
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.animationController})
      : super(key: key);

  final AnimationController? animationController;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = UserData.myUser;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppBar(
            backgroundColor: FitnessAppTheme.white,
            automaticallyImplyLeading: false,
            elevation: 0.0,
            flexibleSpace: Column(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).padding.top),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      'Edit Profile',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: FitnessAppTheme.fontName,
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                        letterSpacing: 1.2,
                        color: FitnessAppTheme.darkerText,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () {
              navigateSecondPage(EditImagePage());
            },
            child: DisplayImage(
              imagePath: user.image,
              onPressed: () {},
            ),
          ),
          buildUserInfoDisplay(user.name, 'Name', EditNameFormPage()),
          buildUserInfoDisplay(user.phone, 'Phone', EditPhoneFormPage()),
          buildUserInfoDisplay(user.email, 'Email', EditEmailFormPage()),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: ElevatedButton(
              onPressed: () {
                navigateSecondPage(PickScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color.fromARGB(255, 77, 79, 192),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 22,
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 34),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                elevation: 8,
                shadowColor:
                    const Color.fromARGB(255, 21, 0, 255).withOpacity(0.6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.grid_view_rounded), // Icon added here
                  const SizedBox(
                      width:
                          15), // Adjust the spacing between the icon and text
                  const Text('Ajouter l\'identité'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10), // Spacer between buttons
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: ElevatedButton(
              onPressed: () {
                // Navigate back to the login screen
                Navigator.pushReplacementNamed(context, LoginScreen.id);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.white, // Use red color for logout button
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 34),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              child: const Text('Logout'),
            ),
          ),
          const Spacer(), // Ensures the logout button is at the bottom
        ],
      ),
    );
  }

  Widget buildUserInfoDisplay(String getValue, String title, Widget editPage) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 1),
            Container(
              width: 350,
              height: 40,
              decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.grey, width: 1)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        navigateSecondPage(editPage);
                      },
                      child: Text(
                        getValue,
                        style: const TextStyle(fontSize: 16, height: 1.4),
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey,
                    size: 40.0,
                  )
                ],
              ),
            ),
          ],
        ),
      );

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  void navigateSecondPage(Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then(onGoBack);
  }
}
