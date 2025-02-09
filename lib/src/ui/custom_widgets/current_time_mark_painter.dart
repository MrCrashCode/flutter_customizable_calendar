import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_customizable_calendar/src/ui/themes/themes.dart';

class CurrentTimeMarkPainter extends CustomPainter {
  const CurrentTimeMarkPainter({
    required this.currentTime,
    required this.theme,
  }) : super(repaint: currentTime);

  final ValueListenable<DateTime> currentTime;

  final TimeMarkTheme theme;

  @override
  void paint(Canvas canvas, Size size) {
    final secondExtent = size.height / Duration.secondsPerDay;
    final dayDate = DateUtils.dateOnly(currentTime.value);
    final timeDiff = currentTime.value.difference(dayDate);
    final currentTimeOffset = timeDiff.inSeconds * secondExtent;
    final dy = currentTimeOffset - theme.strokeWidth / 2;
    final lineLength = theme.drawOnEventArea ? size.width : theme.length;

    canvas.drawLine(
      Offset(0, dy),
      Offset(lineLength, dy),
      theme.painter,
    );
  }

  @override
  bool shouldRepaint(covariant CurrentTimeMarkPainter oldDelegate) =>
      theme != oldDelegate.theme || currentTime != oldDelegate.currentTime;
}