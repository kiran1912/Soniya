import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:demo/page/home_page.dart';
import 'package:demo/utils.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
  Utils.read("start");
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  // ignore: prefer_const_declarations
  static String title = 'soniya';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.orange),
        home: HomePage(),
      );
}
