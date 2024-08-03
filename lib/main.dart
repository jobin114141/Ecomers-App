import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'loginpage.dart';
import 'models/cartmodel.dart';
// ignore: unused_import
import 'register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 58, 125, 183)),
          useMaterial3: true,
        ),
        home: MyLoginPage(),
      ),
    );
  }
}
