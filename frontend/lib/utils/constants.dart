import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:page_transition/page_transition.dart';

const String authLogin = "/auth/login";
const String authRegister = "/auth/register";
const String apiPredict = "/api/predict";
const String authTokenKey = "auth_store";
const String authMe = "/auth/me";

late final String apiBaseUrl;

void setupEnv () {
  apiBaseUrl = dotenv.env['API_BASE_URL'] ?? "http://127.0.0.1:8000";
}


void nextPageAndBack(Widget page, BuildContext context) {
  Navigator.push(
    context,
    PageTransition(type: PageTransitionType.fade, child: page),
  );
}

// void nextPage(Widget page, BuildContext context) {
//   Navigator.pushAndRemoveUntil(
//     context,
//     MaterialPageRoute(builder: (BuildContext context) => page),
//     ModalRoute.withName('/'),
//   );
// }

void nextPage(Widget page, BuildContext context) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (BuildContext context) => page),
    (Route<dynamic> route) => false, // supprime tout
  );
}
