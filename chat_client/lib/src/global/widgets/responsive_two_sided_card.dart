import 'package:chat_client/src/constants/design/border_radius.dart';
import 'package:chat_client/src/constants/design/paddings.dart';
import 'package:chat_client/src/services/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ResponsiveTwoSidedCard extends StatelessWidget {
  const ResponsiveTwoSidedCard({
    super.key,
    required this.leftSideWidget,
    required this.rightSideWidget,
  });

  final Widget leftSideWidget;
  final Widget rightSideWidget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: horizontal24 + vertical24 + horizontal24,
      child: Card(
        clipBehavior: Clip.hardEdge,
        color: context.color.background,
        shape: const RoundedRectangleBorder(borderRadius: br12),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1050,
          ),
          child: IntrinsicHeight(
            child: IntrinsicWidth(
              child: Row(
                children: [
                  Expanded(
                    child: leftSideWidget,
                  ),
                  Expanded(
                    child: rightSideWidget,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
