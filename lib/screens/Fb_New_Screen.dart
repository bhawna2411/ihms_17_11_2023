import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ihms/apiconfig/apiConnections.dart';
import 'package:ihms/models/SocialModel.dart';
import 'package:ihms/models/WhatsNewResponseModel.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FbNewScreen extends StatefulWidget {
  @override
  _WhatsNewScreenState createState() => _WhatsNewScreenState();
}

class _WhatsNewScreenState extends State<FbNewScreen> {
  WhatsNewResponseModel whatsNewResponseModel;
  bool _isLoading = false;
  SocialModel socialModel;
  loadevents() {
    setState(() {
      socialurl().then((value) {
        socialModel = value;
        setState(() {
          _isLoading = false;
        });
      });
    });
  }

  @override
  void initState() {
    _isLoading = true;
    loadevents();
    super.initState();
  }

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    print("BUILD $_isLoading");

    return SafeArea(
      child: Scaffold(
        body: _isLoading == true
            ? Center(child: CircularProgressIndicator())
            : WebView(
                initialUrl: // whatsNewResponseModel.data,
                    socialModel.data[0].facebook,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                },
              ),
      ),
    );
  }
}
