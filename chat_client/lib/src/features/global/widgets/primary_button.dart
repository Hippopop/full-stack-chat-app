import 'package:flutter/material.dart';
import 'package:chat_client/src/constants/design/paddings.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.color,
    required this.text,
    required this.press,
    this.padding = const EdgeInsets.all(defaultPaddingSpace * 0.75),
  });

  final String text;
  final Color? color;
  final VoidCallback press;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      color: color,
      onPressed: press,
      padding: padding,
      minWidth: double.infinity,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
