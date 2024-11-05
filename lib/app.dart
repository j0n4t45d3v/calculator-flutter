import 'package:calculator_app/screen/calculator.dart';
import 'package:flutter/material.dart';

const String _titleApp = 'Calculadora';

class CaculatorApp extends StatelessWidget {
  const CaculatorApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(_titleApp),
        ),
        body: const Calculator(),
      ),
    );
  }
}
