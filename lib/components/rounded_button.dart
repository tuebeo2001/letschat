

import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback function;
  final String text;
  final Color colour;

  const RoundedButton({required this.text, required this.function, required this.colour});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: colour,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        side: const BorderSide(width: 1.0, color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),

      ),
      onPressed: () => function(),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18.0,
        ),
      ),
    );
  }
}
