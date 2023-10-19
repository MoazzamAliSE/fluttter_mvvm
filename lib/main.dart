import 'package:flutter/material.dart';
import 'package:flutter_mvvm/ui/view/startup_view.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MVVM',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const StartUpView(),
    );
  }
}
