import 'package:chat_client/src/utilities/extensions/size_utilities.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "My Homepage",
            ),
            12.height,
            ElevatedButton(
              onPressed: () async {
                context.push("/chat");
              },
              child: const Text("Start Processing"),
            ),
          ],
        ),
      ),
    );
  }
}
