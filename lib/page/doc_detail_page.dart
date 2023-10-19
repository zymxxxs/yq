import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:yq/api/yq_api.dart';

class DocDetailPage extends StatefulWidget {
  @override
  DocDetailPageState createState() => DocDetailPageState();
}

class DocDetailPageState extends State<DocDetailPage> {
  String h5 = '';
  late WebViewController _webviewController;
  @override
  void initState() {
    super.initState();
    _requestHtml();
  }

  _requestHtml() async {
    Map value =
        await YqApi().doc.get(namespace: '126420', slug: 'grow-up-at-alibaba');
    String html = value['body_html'];
    h5 = Uri.dataFromString(
      html,
      mimeType: 'text/html',
      encoding: Encoding.getByName('utf-8'),
    ).toString();

    _webviewController = WebViewController()..loadHtmlString(h5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('yq'),
      ),
      body: WebViewWidget(controller: _webviewController),
    );
  }
}
