import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_strategy/url_strategy.dart';
import 'Pages/App.dart';
import 'Utils/InitAll.dart';


void main() async {
  await InitializeAll().initAll();
  setPathUrlStrategy();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}