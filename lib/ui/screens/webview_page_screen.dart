import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/auth/auth_bloc.dart';
import 'package:flutter_app/data/favorite_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPageScreen extends StatelessWidget {
  final String token;

  const WebViewPageScreen({Key? key, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              BlocProvider.of<AuthBloc>(context).add(GetSessionIdEvent(
                  FavoriteRequest()));
              Navigator.pop(context);
            }),
      ),
      body: WebView(
        initialUrl: 'https://www.themoviedb.org/authenticate/$token',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
