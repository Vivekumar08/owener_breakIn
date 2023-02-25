import 'package:flutter/material.dart' hide Router;
import 'src/router/router.dart';
import '../src/style/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: theme,
      debugShowCheckedModeBanner: true,
      routerConfig: router,
    );
  }
}
