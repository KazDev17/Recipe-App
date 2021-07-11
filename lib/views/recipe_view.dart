import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:recipeapp/Auth.dart';
import 'package:webview_flutter/webview_flutter.dart';
// import 'package:provider/provider.dart';

class RecipeView extends StatefulWidget {
  final String? postUrl;
  RecipeView({this.postUrl});

  @override
  _RecipeViewState createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  late String finalUrl;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  void initState() {
    if (widget.postUrl!.contains('http://')) {
      finalUrl = widget.postUrl!.replaceAll('http://', 'https://');
      //this is just simply saying if the url contains http then replace it with httpsecured
    } else {
      finalUrl = widget.postUrl!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container
//            SingleChildScrollView /*this made us not to see 'Kelvin's CookBook navigation bar*/
            (
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              // EdgeInsets.only deals mainlt with top left right and bottom padding
              padding: EdgeInsets.only(
                  top: Platform.isIOS ? 60 : 30,
                  right: 24,
                  left: 24,
                  bottom: 16),
              decoration: BoxDecoration(
                //this linear gradient is from top to bottom it'd fade into the next color
                gradient: LinearGradient(
                    colors: [const Color(0xff6c19b9), const Color(0xff300b51)]),
              ),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment:
                    kIsWeb ? MainAxisAlignment.start : MainAxisAlignment.center,
                //this is for web app dynamism, where 'kIsWeb ' means if it for a web use (?) ' MainAxisAlignment.start'
                //else (:) MainAxisAlignment.center
                children: <Widget>[
                  Text(
                    "Kelvin's ",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  Text(
                    "CookBook",
                    style: TextStyle(
                      color: Color(0xff1b062f),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // RaisedButton(
                  //   padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
                  //   onPressed: () {
                  //     context.read<AuthenticationService>().signOut();
                  //   },
                  //   child: Text('Sign Out'),
                  // ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 100,
              width: MediaQuery.of(context).size.width,
              child: WebView(
                  initialUrl: finalUrl,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    setState(() {
                      _controller.complete(webViewController);
                    });
                  }),
            )
          ],
        ),
      ),
    ));
  }
}
