part of 'timeline_theme.dart';

/// Wrapper for the TimeMark view customization parameters
class TimeMarkTheme extends Equatable {
  /// Customize the TimeMark with the parameters
  const TimeMarkTheme({
    required this.length,
    this.color = Colors.grey,
    this.strokeWidth = 2,
    this.strokeCap = StrokeCap.square,
    this.drawOnEventArea = false
  });

  /// Length of the line on the time scale
  final double length;

  /// Color of the line
  final Color color;

  /// Thickness of the line
  final double strokeWidth;

  /// The kind of finish to place on the end of line
  final StrokeCap strokeCap;

  /// Enable the mark on the event area
  final bool drawOnEventArea;

  /// A painter which contains the given parameters
  Paint get painter => Paint()
    ..color = color
    ..strokeWidth = strokeWidth
    ..strokeCap = strokeCap;

  @override
  List<Object?> get props => [
        length,
        color,
        strokeWidth,
        strokeCap,
      ];

  /// Creates a copy of this theme but with the given fields replaced with
  /// the new values
  TimeMarkTheme copyWith({
    double? length,
    Color? color,
    double? strokeWidth,
    StrokeCap? strokeCap,
    bool? drawOnEventArea,
  }) {
    return TimeMarkTheme(
      length: length ?? this.length,
      color: color ?? this.color,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      strokeCap: strokeCap ?? this.strokeCap,
      drawOnEventArea: drawOnEventArea ?? this.drawOnEventArea,
    );
  }
}
