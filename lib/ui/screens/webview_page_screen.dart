import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/auth/auth_bloc.dart';
import 'package:flutter_app/data/api_token.dart';
import 'package:flutter_app/networking/api.dart';
import 'package:flutter_app/ui/widgets/loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPageScreen extends StatefulWidget {
  const WebViewPageScreen({Key? key}) : super(key: key);

  @override
  _WebViewPageScreenState createState() => _WebViewPageScreenState();
}

class _WebViewPageScreenState extends State<WebViewPageScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state.loading) {
        return LoadingWidget();
      }

      print('sessionId ${state.sessionId}');

      return WebView(
      initialUrl: 'https://www.themoviedb.org/authenticate/${state.token}',
      javascriptMode: JavascriptMode.unrestricted,
    );
    });
  }
}
