import 'package:chat_client/src/services/theme/app_theme.dart';
import 'package:chat_client/src/utilities/extensions/size_utilities.dart';
import 'package:chat_client/src/utilities/tools/form_validator_helper.dart';
import 'package:flutter/material.dart';

class CustomTitledTextFormField extends StatelessWidget {
  const CustomTitledTextFormField({
    super.key,
    required this.title,
    this.isObscured = false,
    this.hintText,
    this.focus,
    this.nextFocus,
    this.submit,
    this.validators,
    this.controller,
    this.initialValue,
    this.onChange,
    this.prefixIcon,
    this.suffixIcon,
    this.inputType,
    this.replacementFunction,
  });

  final String title;
  final bool isObscured;
  final String? hintText;
  final String? initialValue;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? inputType;
  final FocusNode? focus;
  final FocusNode? nextFocus;
  final List<Validation>? validators;
  final ValueChanged<String>? submit;
  final ValueChanged<String>? onChange;
  final TextEditingController? controller;
  final VoidCallback? replacementFunction;

  @override
  Widget build(BuildContext context) {
    Widget formField = TextFormField(
      focusNode: focus,
      obscureText: isObscured,
      onChanged: onChange,
      controller: controller,
      style: context.textTheme.labelMedium,
      onFieldSubmitted: (value) {
        nextFocus?.requestFocus();
        submit?.call(value);
      },
      keyboardType: inputType,
      initialValue: initialValue,
      decoration: InputDecoration(
        hintText: hintText ?? title,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      validator: FieldValidator.validate(name: title, validators ?? []),
    );
    if (replacementFunction != null) {
      formField = InkWell(
        onTap: replacementFunction,
        child: AbsorbPointer(
          absorbing: true,
          child: formField,
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        4.height,
        Text(
          title,
          style: context.textTheme.labelMedium?.copyWith(
            color: context.color.text,
          ),
        ),
        4.height,
        formField,
      ],
    );
  }
}
