import 'package:flutter/material.dart';
import 'package:uandi/app/const/color_palette.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({Key? key}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController controller;

  final homeUrl = 'https://trite-dugout-647.notion.site/6f5c6a391c57447ca6254ac3e37b1c32';

  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.black,
        elevation: 0.0,
        title: Text(
          '개인정보 처리방침',
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          WebView(
            onWebViewCreated: (WebViewController controller) {
              this.controller = controller;
            },
            initialUrl: homeUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (finish) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          isLoading ? const Center(child: CircularProgressIndicator()) : Stack()
        ],
      ),
    );
  }
}
