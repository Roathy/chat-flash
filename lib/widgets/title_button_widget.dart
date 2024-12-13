import 'package:flutter/material.dart';

class TitleNavButton extends StatelessWidget {
  final String title;
  final String routeName;
  final Color fillColor;
  final VoidCallback onPressed;
  const TitleNavButton({
    required this.title,
    required this.routeName,
    required this.fillColor,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: fillColor,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
          ),
        ),
      ),
    );
  }
}
