import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'user_list_screen.dart';
import 'clipper.dart';

const cardWidthPercent = 0.85;
const innerElementsWidthPercent = 0.7;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool emailOk = false;
  bool passwordOk = false;
  bool enableButton = false;
  final validPasswordChars = RegExp(r'^[a-zA-Z0-9]+$');
  final emailTextController = TextEditingController();
  final passwordTextCotroller = TextEditingController();
  final storage = GetStorage();

  onLogInButton(BuildContext context) {
    storage.write('userLogin', {
      'email': emailTextController.text,
      'password': passwordTextCotroller.text
    });
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return const UserListScreen();
    }));
  }

  checkButtonState() {
    final bool mustEnable = (passwordOk && emailOk);
    if (mustEnable != enableButton) {
      setState(() {
        enableButton = !enableButton;
      });
    }
  }

  onEmailChange(String emailText) {
    if (emailText.contains('@')) {
      emailOk = true;
    } else {
      emailOk = false;
    }
    checkButtonState();
  }

  onPasswordChange(String passwordText) {
    passwordOk =
        (passwordText.length == 8 && validPasswordChars.hasMatch(passwordText));
    checkButtonState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cardWidth = size.width * cardWidthPercent;
    final innerElementsWidth = size.width * innerElementsWidthPercent;

    return Scaffold(
      body: Stack(
        children: [
          ClipPath(
            child: Container(color: Theme.of(context).primaryColor),
            clipper: DiagonalClip(),
            clipBehavior: Clip.antiAlias,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: const Text(
                    'Вход',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  width: cardWidth,
                  alignment: Alignment.centerLeft,
                  // height: 20,
                ),
                Card(
                  elevation: 10,
                  child: SizedBox(
                    height: 250,
                    width: cardWidth,
                    // decoration: const BoxDecoration(
                    //   borderRadius: BorderRadius.all(Radius.circular(10)),
                    //   color: Colors.amber,
                    // ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: innerElementsWidth,
                          child: TextField(
                            decoration: const InputDecoration(
                                hintText: 'Email',
                                hintStyle: TextStyle(color: Colors.grey)),
                            controller: emailTextController,
                            onChanged: onEmailChange,
                          ),
                        ),
                        SizedBox(
                          width: innerElementsWidth,
                          child: TextField(
                            decoration: const InputDecoration(
                                hintText: 'Пароль',
                                hintStyle: TextStyle(color: Colors.grey)),
                            controller: passwordTextCotroller,
                            onChanged: onPasswordChange,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: enableButton
                              ? () {
                                  onLogInButton(context);
                                }
                              : null,
                          child: const Text('Войти'),
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(innerElementsWidth, 30.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              )),
                        )
                      ],
                    ),
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
