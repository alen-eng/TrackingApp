//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auth/Screens/Home/home_page_token.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/authentication/authFunctions.dart';
import 'package:flutter_auth/providers/authListener.dart';
import 'package:provider/provider.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../../responsive.dart';
import 'package:flutter_auth/Screens/Welcome/components/welcome_image.dart';
// import '../../Home/home_page_token.dart';
// import '../../Signup/components/sign_up_top_image.dart';
// import '../../Signup/components/signup_form.dart';
// import '../../Signup/signup_screen.dart';

class TokenCopyForm extends StatefulWidget {
  TokenCopyForm({
    Key? key,
    required this.gentoken,
  }) : super(key: key);
  final gentoken;
  TokenCopyState createState() => new TokenCopyState(gentoken);
}

class TokenCopyState extends State<TokenCopyForm> {
  TokenCopyState(
    this.gentoken,
  );
  TextEditingController Tokencontroller = new TextEditingController();
  final gentoken;
  bool _enabled = false;
  ontokenCopy() {
    //String s = "Hello, world! i am 'foo'";
//String p =((value.replaceAll(new RegExp(r'[^\w\s]+'),"")));
    var value = ClipboardData(text: gentoken);
    var tok = value.toString();
    tok.replaceAll('"', '');
    var token = ClipboardData(text: tok);
    Clipboard.setData(token);
    print(token);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: new AppBar(
        title: new Text('TrackApp'),
      ),
      // floatingActionButton: new FloatingActionButton(
      //     child: new Icon(Icons.token),
      //     onPressed: () {
      //       setState(() {
      //         _enabled = !_enabled;
      //       });
      //     }),
      // ignore: unnecessary_new
      body: new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(10.0),
              child: _enabled
                  ? new TextFormField(
                      initialValue: gentoken,
                      readOnly: true,
                      //controller: Tokencontroller,
                    )
                  : new FocusScope(
                      node: new FocusScopeNode(),
                      // ignore: unnecessary_new
                      child: new TextFormField(
                          initialValue: gentoken,
                          readOnly: true,
                          style: theme.textTheme.subtitle1!.copyWith(
                            color: theme.disabledColor,
                          ),
                          decoration: new InputDecoration(
                              labelText: "Token",
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 5.0),
                              ))),
                    ),
            ),
            ElevatedButton(
              onPressed: () {
                ontokenCopy();
              },
              child: const Text("Copy"),
            ),
          ],
        ),
      ),
    );
  }
}
