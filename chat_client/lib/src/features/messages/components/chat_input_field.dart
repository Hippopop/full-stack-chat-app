import 'package:chat_client/src/constants/design/paddings.dart';
import 'package:chat_client/src/services/socket_connection/data/personal_message_provider.dart';
import 'package:chat_client/src/services/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatInputField extends StatefulWidget {
  const ChatInputField({
    super.key,
    required this.uuid,
  });

  final String uuid;

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  late final TextEditingController _tc = TextEditingController();
  late final FocusNode _fn = FocusNode();
  bool hasFocus = false;
  @override
  void initState() {
    super.initState();
    _fn.addListener(() {
      setState(() {
        hasFocus = _fn.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _tc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 32,
            color: const Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPaddingSpace,
          vertical: defaultPaddingSpace / 2,
        ),
        child: Consumer(builder: (context, ref, child) {
          return SafeArea(
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.mic,
                    color: context.color.primary,
                  ),
                ),
                Expanded(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: context.color.primary.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.sentiment_satisfied_alt_outlined,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .color!
                                  .withOpacity(0.64),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: _tc,
                              focusNode: _fn,
                              onSubmitted: (value) {
                                if (_tc.text.trim().isNotEmpty) {
                                  final controller = ref.read(
                                      userMessagesProvider(widget.uuid)
                                          .notifier);
                                  controller.sendTextMessage(_tc.text.trim());
                                  _tc.clear();
                                  _fn.unfocus();
                                }
                              },
                              onTapOutside: (event) {
                                _fn.unfocus();
                              },
                              decoration: const InputDecoration(
                                hintText: "Type message",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          AnimatedCrossFade(
                            crossFadeState: hasFocus || _tc.text.isNotEmpty
                                ? CrossFadeState.showSecond
                                : CrossFadeState.showFirst,
                            duration: Durations.medium2,
                            layoutBuilder: (topChild, topChildKey, bottomChild,
                                    bottomChildKey) =>
                                Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                Positioned(
                                  top: 0,
                                  key: bottomChildKey,
                                  child: bottomChild,
                                ),
                                Positioned(
                                  key: topChildKey,
                                  child: topChild,
                                ),
                              ],
                            ),
                            secondChild: IconButton(
                              onPressed: () {
                                if (_tc.text.trim().isNotEmpty) {
                                  final controller = ref.read(
                                      userMessagesProvider(widget.uuid)
                                          .notifier);
                                  controller.sendTextMessage(_tc.text.trim());
                                  _tc.clear();
                                  _fn.unfocus();
                                }
                              },
                              icon: Icon(
                                Icons.send,
                                color: context.color.primary,
                              ),
                            ),
                            firstChild: AnimatedSize(
                              duration: Durations.medium2,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.attach_file,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color!
                                          .withOpacity(0.64),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.camera_alt_outlined,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color!
                                          .withOpacity(0.64),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
