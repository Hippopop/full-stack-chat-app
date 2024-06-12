import 'package:chat_client/src/utilities/animations/build_text_animation.dart';
import 'package:chat_client/src/utilities/dialogues/overlay_loader.dart';
import 'package:chat_client/src/utilities/extensions/size_utilities.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.endOfFrame.then((value) {
      context.overlay.show(
        text: "Hello World!",
        loaderBuilder: (size, text) => Center(
          child: ColoredBox(
            color: Colors.blue,
            child: AnimatedBuildText(text),
          ),
        ),
      );
    });

    Future.delayed(Duration(seconds: 2))
        .then((value) => context.overlay.hide());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "My Chat Page",
            ),
            12.height,
            ElevatedButton(
              onPressed: () async {
                final c = context.overlay;
                c.show(text: "Processing data...");
                await Future.delayed(Duration(seconds: 2));
                c.show(text: "Saving new data!");
                await Future.delayed(Duration(seconds: 2));
                c.hide();
                context.push("/");
              },
              child: Text("Start Processing"),
            ),
          ],
        ),
      ),
    );
  }
}
