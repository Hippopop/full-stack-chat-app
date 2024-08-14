import 'dart:async';
import 'package:flutter/material.dart';

import '../animations/build_text_animation.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    required this.size,
    required this.text,
    this.backgroundColor,
  });

  final Size size;
  final String text;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: size.width * 0.8,
          minWidth: size.width * 0.5,
          maxHeight: size.height * 0.8,
        ),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const CircularProgressIndicator(),
                const SizedBox(
                  height: 20,
                ),
                AnimatedBuildText(text),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

typedef CloseLoadingScreen = bool Function();
typedef UpdateLoadingScreen = bool Function(String text);
typedef LoadingWidgetBuilder = Widget Function(Size? size, String text);

@immutable
class _LoadingOverlayController {
  final CloseLoadingScreen close;
  final UpdateLoadingScreen update;
  const _LoadingOverlayController({
    required this.close,
    required this.update,
  });
}

extension ParentResponsiveStateGetter on BuildContext {
  LoadingOverlayState get overlay {
    final state = findAncestorStateOfType<LoadingOverlayState>();
    if (state == null) {
      throw UnimplementedError(
        "No parent [LoadingOverlayWrapper] "
        "widget found in the current widget tree!"
        "Please make sure you have a [LoadingOverlayWrapper] somewhere top in your widget tree!",
      );
    }
    return state;
  }
}

class LoadingOverlayWrapper {
  const LoadingOverlayWrapper._();

  static Widget local({
    required WidgetBuilder builder,
    LoadingWidgetBuilder? loaderBuilder,
  }) =>
      _LoadingOverlayWidget(
        builder: builder,
        loaderBuilder: loaderBuilder,
      );

  static Widget global({
    ThemeData? loaderTheme,
    required WidgetBuilder builder,
    LoadingWidgetBuilder? loaderBuilder,
  }) =>
      MaterialApp(
        theme: loaderTheme,
        debugShowCheckedModeBanner: false,
        home: Builder(builder: (context) {
          return _LoadingOverlayWidget(
            builder: builder,
            loaderBuilder: loaderBuilder,
          );
        }),
      );
}

class _LoadingOverlayWidget extends StatefulWidget {
  const _LoadingOverlayWidget({required this.builder, this.loaderBuilder});
  final WidgetBuilder builder;
  final LoadingWidgetBuilder? loaderBuilder;

  @override
  State<_LoadingOverlayWidget> createState() => LoadingOverlayState();
}

class LoadingOverlayState extends State<_LoadingOverlayWidget> {
  _LoadingOverlayController? _controller;

  void show({
    required String text,
    Color? overlayColor,
    LoadingWidgetBuilder? loaderBuilder,
  }) {
    final couldUpdateCurrentState = _controller?.update(text) ?? false;
    final mustBuildNew = loaderBuilder == null && overlayColor == null;

    if (!(couldUpdateCurrentState && mustBuildNew)) {
      _controller?.close();
      _controller = _showOverlay(
        text: text,
        builder: loaderBuilder,
      );
    }
  }

  void hide() {
    _controller?.close();
    _controller = null;
  }

  _LoadingOverlayController _showOverlay({
    required String text,
    Color? overlayColor,
    LoadingWidgetBuilder? builder,
  }) {
    final textStream = StreamController<String>()..add(text);

    final state = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    final overlay = OverlayEntry(
      builder: (context) {
        return Material(
          color: overlayColor ?? Colors.black.withAlpha(150),
          child: StreamBuilder<String>(
            initialData: text,
            stream: textStream.stream,
            builder: (context, snapshot) {
              final w = builder?.call(size, snapshot.data!) ??
                  widget.loaderBuilder?.call(size, snapshot.data!);
              return w ?? LoadingWidget(size: size, text: snapshot.data!);
            },
          ),
        );
      },
    );

    state.insert(overlay);

    return _LoadingOverlayController(
      update: (text) {
        textStream.add(text);
        return true;
      },
      close: () {
        textStream.close();
        overlay.remove();
        return true;
      },
    );
  }

  @override
  void dispose() {
    hide();
    super.dispose();
  }

  @override
  void deactivate() {
    hide();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: widget.builder,
    );
  }
}
