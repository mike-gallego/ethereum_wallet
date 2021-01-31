import 'dart:developer';
import 'dart:math';

import 'package:ehtereum_wallet/app/screens/dashboard/blocs/theme/bloc/theme_bloc.dart';
import 'package:ehtereum_wallet/app/screens/transaction/blocs/timeline/bloc/timeline_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timelines/timelines.dart';

import 'widget.dart';

const kTileHeight = 50.0;

const completeColor = Color(0xff5e6172);
const inProgressColor = Color(0xff5ec792);
const todoColor = Color(0xffd1d2d7);

class ProcessTimelinePage extends StatefulWidget {
  @override
  _ProcessTimelinePageState createState() => _ProcessTimelinePageState();
}

class _ProcessTimelinePageState extends State<ProcessTimelinePage> {
  Color getColor(int index, int stateIndex) {
    if (index == stateIndex) {
      return inProgressColor;
    } else if (index < stateIndex) {
      return completeColor;
    } else {
      return todoColor;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimelineBloc, TimelineState>(
      builder: (context, state) {
        return Scaffold(
          body: Container(
            padding: const EdgeInsets.all(8.0),
            child: Timeline.tileBuilder(
              theme: TimelineThemeData(
                direction: Axis.horizontal,
                connectorTheme: ConnectorThemeData(
                  space: 30.0,
                  thickness: 5.0,
                ),
              ),
              builder: TimelineTileBuilder.connected(
                connectionDirection: ConnectionDirection.before,
                itemExtentBuilder: (_, __) =>
                    MediaQuery.of(context).size.width / _processes.length - 15,
                // oppositeContentsBuilder: (context, index) {
                //   return Padding(
                //     padding: const EdgeInsets.only(bottom: 15.0),
                //     child: Image.asset(
                //       'assets/coin.png',
                //       width: 50.0,
                //       color: getColor(index),
                //     ),
                //   );
                // },
                contentsBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Text(
                      _processes[index],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: getColor(index, state.index),
                      ),
                    ),
                  );
                },
                indicatorBuilder: (_, index) {
                  var color;
                  var child;
                  if (index ==
                      BlocProvider.of<TimelineBloc>(context).state.index) {
                    color = inProgressColor;
                    child = Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(
                        strokeWidth: 3.0,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    );
                  } else if (index < state.index) {
                    color = !BlocProvider.of<ThemeBloc>(context).state.isLight
                        ? Colors.blueGrey[400]
                        : completeColor;
                    child = Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 15.0,
                    );
                  } else {
                    color = todoColor;
                  }

                  if (index <= state.index) {
                    return Stack(
                      children: [
                        CustomPaint(
                          size: Size(30.0, 30.0),
                          painter: _BezierPainter(
                            color: color,
                            drawStart: index > 0,
                            drawEnd: index < state.index,
                          ),
                        ),
                        DotIndicator(
                          size: 30.0,
                          color: color,
                          child: child,
                        ),
                      ],
                    );
                  } else {
                    return Stack(
                      children: [
                        CustomPaint(
                          size: Size(15.0, 15.0),
                          painter: _BezierPainter(
                            color: color,
                            drawEnd: index < _processes.length - 1,
                          ),
                        ),
                        OutlinedDotIndicator(
                          borderWidth: 4.0,
                          color: color,
                        ),
                      ],
                    );
                  }
                },
                connectorBuilder: (_, index, type) {
                  if (index > 0) {
                    if (index == state.index) {
                      final prevColor = getColor(index - 1, state.index);
                      final color = getColor(index, state.index);
                      var gradientColors;
                      if (type == ConnectorType.start) {
                        gradientColors = [
                          Color.lerp(prevColor, color, 0.5),
                          color
                        ];
                      } else {
                        gradientColors = [
                          prevColor,
                          Color.lerp(prevColor, color, 0.5)
                        ];
                      }
                      return DecoratedLineConnector(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: gradientColors,
                          ),
                        ),
                      );
                    } else {
                      return SolidLineConnector(
                        color: getColor(index, state.index),
                      );
                    }
                  } else {
                    return null;
                  }
                },
                itemCount: _processes.length,
              ),
            ),
          ),
          floatingActionButton: state.index == 4 ? NeumorphicFloatingActionButton(
            
            style: NeumorphicStyle(
                shape: NeumorphicShape.concave,
                depth: 6.0,
                shadowLightColor:
                    BlocProvider.of<ThemeBloc>(context).state.isLight
                        ? Colors.grey[400]
                        : Colors.blueGrey[500]),
            onPressed: () {},
            mini: true,
            child: Center(
              child: NeumorphicIcon(
                MaterialCommunityIcons.file_pdf,
                style: NeumorphicStyle(
                  shape: NeumorphicShape.convex,
                  depth: 6,
                  shadowLightColor:
                      BlocProvider.of<ThemeBloc>(context).state.isLight
                          ? Colors.grey[400]
                          : Colors.blueGrey[600],
                  color: Colors.redAccent,
                ),
              ),
            ),
          ) : Container(height: 1, width: 1, color: Colors.transparent),
        );
      },
    );
  }
}

/// hardcoded bezier painter
/// TODO: Bezier curve into package component
class _BezierPainter extends CustomPainter {
  const _BezierPainter({
    @required this.color,
    this.drawStart = true,
    this.drawEnd = true,
  });

  final Color color;
  final bool drawStart;
  final bool drawEnd;

  Offset _offset(double radius, double angle) {
    return Offset(
      radius * cos(angle) + radius,
      radius * sin(angle) + radius,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    final radius = size.width / 2;

    var angle;
    var offset1;
    var offset2;

    var path;

    if (drawStart) {
      angle = 3 * pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);
      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(0.0, size.height / 2, -radius,
            radius) // TODO connector start & gradient
        ..quadraticBezierTo(0.0, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
    if (drawEnd) {
      angle = -pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);

      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(size.width, size.height / 2, size.width + radius,
            radius) // TODO connector end & gradient
        ..quadraticBezierTo(size.width, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_BezierPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.drawStart != drawStart ||
        oldDelegate.drawEnd != drawEnd;
  }
}

final _processes = [
  'Started',
  'In Progress',
  'Completed',
];
