import 'package:flutter/material.dart';
import 'package:flutter_customizable_calendar/src/ui/themes/themes.dart';
import 'package:flutter_customizable_calendar/src/utils/utils.dart';

import 'current_time_mark_painter.dart';

/// It displays a time scale of a day view (with hours and minutes marks).
class EventAreaHourLinePainter extends StatefulWidget {
  /// Creates view of a time scale.
  const EventAreaHourLinePainter({
    super.key,
    this.theme = const TimeScaleTheme(),
  });

  /// Customization params for the view
  final TimeScaleTheme theme;

  @override
  State<EventAreaHourLinePainter> createState() => _EventAreaHourLinePainterState();
}

class _EventAreaHourLinePainterState extends State<EventAreaHourLinePainter> {
  final _clock = ClockNotifier.instance();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(
        MediaQuery.sizeOf(context).width,
        widget.theme.hourExtent * Duration.hoursPerDay,
      ),
      painter: _hourLinePainter,
      foregroundPainter: widget.theme.currentTimeMarkTheme.drawOnEventArea
          ? _currentTimeMark
          : null,
    );
  }

  @override
  void dispose() {
    _clock.dispose();
    super.dispose();
  }

  CustomPainter get _hourLinePainter => _HourLinePainter(
    dayDate: _clock.value,
    theme: widget.theme,
  );

  CustomPainter get _currentTimeMark => CurrentTimeMarkPainter(
    currentTime: _clock,
    theme: widget.theme.currentTimeMarkTheme,
  );
}

class _HourLinePainter extends CustomPainter {
  final TimeScaleTheme theme;
  final DateTime dayDate;

  _HourLinePainter({required this.theme, required this.dayDate});

  @override
  void paint(Canvas canvas, Size size) {
    final hourExtent = size.height / Duration.hoursPerDay;
    final quarterHeight = hourExtent / 4;

    for (var hour = 0; hour < Duration.hoursPerDay; hour++) {
      final hourOffset = hourExtent * hour;

      // Draw half-hour marks
      if (theme.drawHourMarks && theme.hourMarkTheme.drawOnEventArea) {
        final line = theme.hourMarkTheme;
        final dy = hourOffset - line.strokeWidth / 2;

        // Make sure the line has a start and end point that are different
        canvas.drawLine(
          Offset(0, dy), // Start point
          Offset(size.width, dy), // End point
          line.painter,
        );
      }

      // Draw half-hour marks
      if (theme.drawHalfHourMarks && theme.halfHourMarkTheme.drawOnEventArea) {
        final line = theme.halfHourMarkTheme;
        final dy = hourOffset + quarterHeight * 2 - line.strokeWidth / 2;

        canvas.drawLine(
          Offset(0, dy),
          Offset(size.width, dy),
          line.painter,
        );
      }

      if (theme.drawQuarterHourMarks && theme.quarterHourMarkTheme.drawOnEventArea) {
        final line = theme.quarterHourMarkTheme;
        final dy1 = hourOffset + quarterHeight - line.strokeWidth / 2;
        final dy2 = hourOffset + quarterHeight * 3 - line.strokeWidth / 2;

        canvas
          ..drawLine(
            Offset(0, dy1),
            Offset(0 + size.width, dy1),
            line.painter,
          )
          ..drawLine(
            Offset(0, dy2),
            Offset(0 + size.width, dy2),
            line.painter,
          );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
