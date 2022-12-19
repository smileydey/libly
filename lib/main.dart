import 'package:flutter/material.dart';
import 'package:libly/pages/logcreate.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final keyApplicationId = 'p3X2xxBd0NbPdyb2MujgfoMPi2yoV2BMfssIRo3n';
  final keyClientKey = 'Cazylr3X7GC2dKBMMDgMQVOjKmpIF355N8RC65Nv';
  final keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);

  runApp(MyApp());
}

//this runs the root of the app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This where i will put the home page 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // I can add a theme here
      debugShowCheckedModeBanner: false,
      home: LogCreate(),
    );
  }
}
