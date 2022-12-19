import 'dart:html';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:libly/constants.dart';
import 'package:libly/pages/createAccount.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

//note: for the login box for ui/ux add padding to make it look better
//note: make sure to adjust button style as well. much needed

class LogCreate extends StatefulWidget {
  @override
  _LogCreateState createState() => _LogCreateState();
}

class _LogCreateState extends State<LogCreate> {
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 80,
            ),
            Image.asset(logo),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 480,
              width: 325,
              decoration: BoxDecoration(
                color: thirdColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'User Login',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: controllerUsername,
                    enabled: !isLoggedIn,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.none,
                    autocorrect: false,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        labelText: 'Username'),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: controllerPassword,
                    enabled: !isLoggedIn,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.none,
                    autocorrect: false,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        labelText: 'Password'),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: 50,
                    child: TextButton(
                      child: const Text('Login'),
                      onPressed: isLoggedIn ? null : () => doUserLogin(),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  //this container allows you to head to the create an account page
                  Container(
                    child: TextButton(
                      child: const Text('Dont have an account? Click here.'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CreateAccount();
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: 50,
                    child: TextButton(
                      child: const Text('Logout'),
                      onPressed: !isLoggedIn ? null : () => doUserLogout(),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  } //widget build

  void showSuccess(String message) {
    showDialog(
      context: this.context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Success!"),
          content: Text(message),
          actions: <Widget>[
            new TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showError(String errorMessage) {
    showDialog(
      context: this.context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error!"),
          content: Text(errorMessage),
          actions: <Widget>[
            new TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void doUserLogin() async {
    final username = controllerUsername.text.trim();
    final password = controllerPassword.text.trim();

    final user = ParseUser(username, password, null);

    var response = await user.login();

    if (response.success) {
      showSuccess("User was successfully login!");
      setState(() {
        isLoggedIn = true;
      });
    } else {
      showError(response.error!.message);
    }
  }

  void doUserLogout() async {
    final user = await ParseUser.currentUser() as ParseUser;
    var response = await user.logout();

    if (response.success) {
      showSuccess("User was successfully logout!");
      setState(() {
        isLoggedIn = false;
      });
    } else {
      showError(response.error!.message);
    }
  }
} //homepage
