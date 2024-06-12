import 'package:chat_client/src/utilities/dialogues/overlay_loader.dart';
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
                final c = context.overlay;
                c.show(text: "Processing data...");
                await Future.delayed(Duration(seconds: 2));
                c.show(text: "Saving new data!");
                await Future.delayed(Duration(seconds: 2));
                // c.hide();
                context.push("/chat");
              },
              child: Text("Start Processing"),
            ),
          ],
        ),
      ),
    );
  }
}
