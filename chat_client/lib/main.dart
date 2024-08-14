import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat_client/src/services/initializer/root.dart';

void main() {
  runApp(const ProviderScope(child: AppRoot()));
}
