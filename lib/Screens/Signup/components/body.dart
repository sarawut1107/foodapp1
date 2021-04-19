import 'package:flutter/material.dart';
import 'package:foodapp1/Screens/Login/login_screen.dart';
import 'package:foodapp1/Screens/Signup/components/background.dart';
import 'package:foodapp1/Screens/Signup/components/or_divider.dart';
import 'package:foodapp1/Screens/Signup/components/social_icon.dart';
import 'package:foodapp1/components/already_have_an_account_acheck.dart';
import 'package:foodapp1/components/rounded_button.dart';
import 'package:foodapp1/components/rounded_input_field.dart';
import 'package:foodapp1/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0),
            Positioned(
            top: 40,
            left: 30,
            child: Image.asset(
              "assets/images/logo.png",
              width: size.width * 0.80,
            ),
          ),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "SIGNUP",
              color: Colors.red.shade700,
              press: () {},
            ),
            SizedBox(height: size.height * 0.01),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
          ],
        ),
      ),
    );
  }
}
