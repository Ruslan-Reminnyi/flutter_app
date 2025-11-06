import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/auth/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPageScreen extends StatelessWidget {
  static const routeName = '/authentication';
  final String token;

  const WebViewPageScreen({super.key, this.token = ''});

  @override
  Widget build(BuildContext context) {
    final webviewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse('https://www.themoviedb.org/authenticate/$token'),
      );

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            BlocProvider.of<AuthBloc>(context).add(GetSessionIdEvent());
            Navigator.pop(context);
          },
        ),
      ),
      body: WebViewWidget(controller: webviewController),
    );
  }
}
