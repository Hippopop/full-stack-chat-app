import 'package:chat_client/src/services/theme/app_theme.dart';
import 'package:flutter/material.dart';

class FillOutlineButton extends StatelessWidget {
  const FillOutlineButton({
    super.key,
    this.isFilled = true,
    required this.press,
    required this.text,
  });

  final bool isFilled;
  final VoidCallback press;
  final String text;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: const BorderSide(color: Colors.white),
      ),
      elevation: isFilled ? 2 : 0,
      color: isFilled ? Colors.white : Colors.transparent,
      onPressed: press,
      child: Text(
        text,
        style: TextStyle(
          color: isFilled ? context.color.secondaryAccent : Colors.white,
          fontSize: 12,
        ),
      ),
    );
  }
}
