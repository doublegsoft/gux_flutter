/*
** ──────────────────────────────────────────────────
** ─██████████████─██████──██████─████████──████████─
** ─██░░░░░░░░░░██─██░░██──██░░██─██░░░░██──██░░░░██─
** ─██░░██████████─██░░██──██░░██─████░░██──██░░████─
** ─██░░██─────────██░░██──██░░██───██░░░░██░░░░██───
** ─██░░██─────────██░░██──██░░██───████░░░░░░████───
** ─██░░██──██████─██░░██──██░░██─────██░░░░░░██─────
** ─██░░██──██░░██─██░░██──██░░██───████░░░░░░████───
** ─██░░██──██░░██─██░░██──██░░██───██░░░░██░░░░██───
** ─██░░██████░░██─██░░██████░░██─████░░██──██░░████─
** ─██░░░░░░░░░░██─██░░░░░░░░░░██─██░░░░██──██░░░░██─
** ─██████████████─██████████████─████████──████████─
** ──────────────────────────────────────────────────
*/
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '/styles.dart' as styles;

class TermsAndConditionsPage extends StatefulWidget {
  @override
  TermsAndConditionsPageState createState() => TermsAndConditionsPageState();
}

class TermsAndConditionsPageState extends State<TermsAndConditionsPage> {

  late WebViewController _controller;

  bool _isAgreed = false;

  @override
  Widget build(BuildContext context) {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://flutter.dev'));

    final appbar = AppBar(
      title: Text('同意条款'),
    );

    final mediaQueryData = MediaQuery.of(context);
    final screenHeight = mediaQueryData.size.height;
    final webViewHeight = screenHeight - appbar.preferredSize.height - mediaQueryData.padding.top - mediaQueryData.padding.bottom - 36;
    final bottomHeight = mediaQueryData.padding.bottom + 36;
    return Scaffold(
        appBar: appbar,
        body: Column(
          children: [
            Container(
              height: webViewHeight,
              child: WebViewWidget(
                controller: _controller,
              ),
            ),
            Container(
              height: bottomHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(width: styles.padding),
                      StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return Checkbox(
                            value: _isAgreed,
                            onChanged: (bool? newValue) {
                              setState(() {
                                _isAgreed = newValue!;
                              });
                            },
                          );
                        },
                      ),
                      Text(
                        '我已阅读并且同意上述条款',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {

                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: styles.padding),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // No border radius
                      ),
                      minimumSize: Size(120, bottomHeight),
                    ),
                    child: Text('同意', style: TextStyle(fontSize: 20)),
                  )
                ],
              ),
            ),
          ],
        ),
    );
  }
}
