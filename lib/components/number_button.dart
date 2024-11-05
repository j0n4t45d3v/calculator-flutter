import 'package:flutter/material.dart';

class NumberButton extends StatelessWidget {
  final String number;
  final void Function(String value) buttonAction;
  const NumberButton(
      {super.key, required this.number, required this.buttonAction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () => buttonAction(number),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            padding: const EdgeInsets.all(32.0)),
        child: Text(number, style: const TextStyle(fontSize: 32)),
      ),
    );
  }
}
