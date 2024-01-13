import 'dart:convert';
import 'dart:math';
import 'package:fitnessapp/fitness_app/models/Admin/checkpointModel.dart';
import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:animated_list_plus/transitions.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:http/http.dart' as http;

class CheckpointSearchPage extends StatefulWidget {
  const CheckpointSearchPage({Key? key}) : super(key: key);

  @override
  _CheckpointSearchPageState createState() => _CheckpointSearchPageState();
}

class _CheckpointSearchPageState extends State<CheckpointSearchPage> {
  List<CheckpointModel> allCheckpointList = <CheckpointModel>[].obs;
  List<CheckpointModel> currentCheckpointList = <CheckpointModel>[].obs;

  Future getAllCheckpoints() async {
    try {
      var res = await http.get(
        Uri.parse(Api.getcheckpointList),
      );

      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);
        if (resBodyOfLogin['success']) {
          allCheckpointList = [];
          currentCheckpointList = [];
          List<CheckpointModel> checkpoints =
              await resBodyOfLogin["checkpointList"]
                  .map<CheckpointModel>(
                      (json) => CheckpointModel.fromJson(json))
                  .toList();
          for (CheckpointModel checkpoint in checkpoints) {
            allCheckpointList.add(checkpoint);
            currentCheckpointList.add(checkpoint);
          }
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getAllCheckpoints();
  }
  //methods

  late final _controller = TextEditingController()
    ..addListener(
      _onQueryChanged,
    );

  String get text => _controller.text.trim();

  void _onQueryChanged() {
    currentCheckpointList.clear();

    if (text.isEmpty) {
      currentCheckpointList
        ..clear()
        ..addAll(allCheckpointList);

      setState(() {});

      return;
    }

    final query = text.toLowerCase();
    for (final checkpoint in allCheckpointList) {
      final name = checkpoint.name.toLowerCase();
      final location = checkpoint.location.toLowerCase();
      final startsWith = name.startsWith(query) || location.startsWith(query);

      if (startsWith) {
        currentCheckpointList.add(checkpoint);
      }
    }

    for (final checkpoint in allCheckpointList) {
      final name = checkpoint.name.toLowerCase();
      final location = checkpoint.location.toLowerCase();
      final contains = name.contains(query) || location.contains(query);

      if (contains && !currentCheckpointList.contains(checkpoint)) {
        currentCheckpointList.add(checkpoint);
      }
    }

    setState(() {});
  }

  Widget _buildItem(CheckpointModel checkpoint) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Box(
      border: Border(
        bottom: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),
      color: Colors.white,
      onTap: () => Navigator.pop(context, checkpoint),
      child: ListTile(
        title: HighlightText(
          query: text,
          text: checkpoint.name,
          style: textTheme.bodyText2?.copyWith(
            fontSize: 16,
          ),
          activeStyle: textTheme.bodyText2?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w900,
          ),
        ),
        subtitle: HighlightText(
          query: text,
          text: checkpoint.location,
          style: textTheme.bodyText1?.copyWith(
            fontSize: 15,
          ),
          activeStyle: textTheme.bodyText1?.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final padding = MediaQuery.of(context).viewPadding.top;

    return FutureBuilder(
        future: Future.wait([getAllCheckpoints()]),
        builder: (context, constraints) {
          return Scaffold(
            appBar: _buildAppBar(padding, theme, textTheme),
            body: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: currentCheckpointList.isNotEmpty
                  ? _buildList()
                  : _buildNoCheckpointModelsPlaceholder(),
            ),
          );
        });
  }

  Widget _buildList() {
    return ImplicitlyAnimatedList<CheckpointModel>(
      items: currentCheckpointList,
      updateDuration: const Duration(milliseconds: 400),
      areItemsTheSame: (a, b) => a == b,
      itemBuilder: (context, animation, checkpoint, _) {
        return SizeFadeTransition(
          sizeFraction: 0.7,
          curve: Curves.easeInOut,
          animation: animation,
          child: _buildItem(checkpoint),
        );
      },
      updateItemBuilder: (context, animation, checkpoint) {
        return FadeTransition(
          opacity: animation,
          child: _buildItem(checkpoint),
        );
      },
    );
  }

  PreferredSize _buildAppBar(
      double padding, ThemeData theme, TextTheme textTheme) {
    return PreferredSize(
      preferredSize: Size.fromHeight(56 + padding),
      child: Box(
        height: 56 + padding,
        width: double.infinity,
        color: theme.highlightColor,
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.2),
        child: Column(
          children: <Widget>[
            SizedBox(height: padding),
            Expanded(
              child: Row(
                children: <Widget>[
                  const BackButton(
                    color: Colors.white,
                  ),
                  Expanded(
                    child: TextField(
                      autofocus: true,
                      controller: _controller,
                      textInputAction: TextInputAction.search,
                      style: textTheme.bodyText2?.copyWith(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        hintText: 'Search for a Checkpoint',
                        hintStyle: textTheme.bodyText2?.copyWith(
                          color: Colors.grey.shade200,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 350),
                    opacity: text.isEmpty ? 0.0 : 1.0,
                    child: IconButton(
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.white,
                      ),
                      onPressed: () => _controller.text = '',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoCheckpointModelsPlaceholder() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const <Widget>[
          Icon(
            Icons.translate,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            'No Checkpoints found!',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

enum ShadowDirection {
  topLeft,
  top,
  topRight,
  right,
  bottomRight,
  bottom,
  bottomLeft,
  left,
  center,
}

class Box extends StatelessWidget {
  final double borderRadius;
  final double elevation;
  final double? height;
  final double? width;
  final Border? border;
  final BorderRadius? customBorders;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Widget? child;
  final Color color;
  final Color shadowColor;
  final List<BoxShadow>? boxShadows;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onDoubleTap;
  final BoxShape boxShape;
  final AlignmentGeometry? alignment;
  final ShadowDirection shadowDirection;
  final Color? splashColor;
  final Duration? duration;
  final BoxConstraints? constraints;
  const Box({
    Key? key,
    this.child,
    this.border,
    this.color = Colors.transparent,
    this.borderRadius = 0.0,
    this.elevation = 0.0,
    this.splashColor,
    this.shadowColor = Colors.black12,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.height,
    this.width,
    this.margin,
    this.customBorders,
    this.alignment,
    this.boxShadows,
    this.constraints,
    this.duration,
    this.boxShape = BoxShape.rectangle,
    this.shadowDirection = ShadowDirection.bottomRight,
    this.padding = const EdgeInsets.all(0),
  }) : super(key: key);

  static const wrap = -1;

  bool get circle => boxShape == BoxShape.circle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final w = width;
    final h = height;
    final br = customBorders ??
        BorderRadius.circular(
          boxShape == BoxShape.rectangle
              ? borderRadius
              : w != null
                  ? w / 2.0
                  : h != null
                      ? h / 2.0
                      : 0,
        );

    Widget content = Padding(
      padding: padding ?? EdgeInsets.zero,
      child: child,
    );

    if (boxShape == BoxShape.circle ||
        (customBorders != null || borderRadius > 0.0)) {
      content = ClipRRect(
        borderRadius: br,
        child: content,
      );
    }

    if (onTap != null || onLongPress != null || onDoubleTap != null) {
      content = Material(
        color: Colors.transparent,
        type: MaterialType.transparency,
        shape: circle
            ? const CircleBorder()
            : RoundedRectangleBorder(borderRadius: br),
        child: InkWell(
          splashColor: splashColor ?? theme.splashColor,
          highlightColor: theme.highlightColor,
          hoverColor: theme.hoverColor,
          focusColor: theme.focusColor,
          customBorder: circle
              ? const CircleBorder()
              : RoundedRectangleBorder(borderRadius: br),
          onTap: onTap,
          onLongPress: onLongPress,
          onDoubleTap: onDoubleTap,
          child: content,
        ),
      );
    }

    final List<BoxShadow>? boxShadow = boxShadows ??
        ((elevation > 0 && (shadowColor.opacity > 0))
            ? [
                BoxShadow(
                  color: shadowColor,
                  offset: _getShadowOffset(min(elevation / 5.0, 1.0)),
                  blurRadius: elevation,
                  spreadRadius: 0,
                ),
              ]
            : null);

    final boxDecoration = BoxDecoration(
      color: color,
      borderRadius: circle || br == BorderRadius.zero ? null : br,
      shape: boxShape,
      boxShadow: boxShadow,
      border: border,
    );

    return duration != null
        ? AnimatedContainer(
            height: h,
            width: w,
            margin: margin,
            alignment: alignment,
            duration: duration!,
            decoration: boxDecoration,
            constraints: constraints,
            child: content,
          )
        : Container(
            height: h,
            width: w,
            margin: margin,
            alignment: alignment,
            decoration: boxDecoration,
            constraints: constraints,
            child: content,
          );
  }

  Offset _getShadowOffset(double ele) {
    final ym = 5 * ele;
    final xm = 2 * ele;
    switch (shadowDirection) {
      case ShadowDirection.topLeft:
        return Offset(-1 * xm, -1 * ym);
      case ShadowDirection.top:
        return Offset(0, -1 * ym);
      case ShadowDirection.topRight:
        return Offset(xm, -1 * ym);
      case ShadowDirection.right:
        return Offset(xm, 0);
      case ShadowDirection.bottomRight:
        return Offset(xm, ym);
      case ShadowDirection.bottom:
        return Offset(0, ym);
      case ShadowDirection.bottomLeft:
        return Offset(-1 * xm, ym);
      case ShadowDirection.left:
        return Offset(-1 * xm, 0);
      default:
        return Offset.zero;
    }
  }
}

class HighlightText extends StatefulWidget {
  final TextStyle? activeStyle;
  final TextStyle? style;
  final String query;
  final String text;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final bool softWrap;
  final TextOverflow overflow;
  final double textScaleFactor;
  final int? maxLines;
  const HighlightText({
    Key? key,
    this.activeStyle,
    this.style,
    this.query = '',
    this.text = '',
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.softWrap = true,
    this.overflow = TextOverflow.ellipsis,
    this.textScaleFactor = 1.0,
    this.maxLines,
  }) : super(key: key);

  @override
  _HighlightTextState createState() => _HighlightTextState();
}

class _HighlightTextState extends State<HighlightText> {
  TextStyle get style => widget.style ?? Theme.of(context).textTheme.bodyText2!;
  TextStyle get activeStyle =>
      widget.activeStyle ?? style.copyWith(fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    final idxs = getQueryHighlights(widget.text, widget.query);

    return RichText(
      textAlign: widget.textAlign,
      maxLines: widget.maxLines,
      overflow: widget.overflow,
      softWrap: widget.softWrap,
      textDirection: widget.textDirection,
      textScaleFactor: widget.textScaleFactor,
      text: TextSpan(
        children: idxs.map((idx) {
          return TextSpan(
            text: widget.text.substring(idx.first, idx.second),
            style: idx.third ? activeStyle : style,
          );
        }).toList(),
      ),
    );
  }
}

String replaceLast(String source, String matcher, String replacement) {
  final index = source.lastIndexOf(matcher);
  return source.replaceRange(index, index + matcher.length, replacement);
}

List<Triplet<int, int, bool>> getQueryHighlights(String text, String query) {
  final t = text.toLowerCase();
  final q = query.toLowerCase();

  if (t.isEmpty || q.isEmpty || !t.contains(q))
    return [Triplet(0, t.length, false)];

  List<Triplet<int, int, bool>> idxs = [];

  var w = t;
  do {
    final i = w.lastIndexOf(q);
    final e = i + q.length;
    if (i != -1) {
      w = replaceLast(w, q, '');
      idxs.insert(0, Triplet(i, e, true));
    }
  } while (w.contains(q));

  if (idxs.isEmpty) {
    idxs.add(Triplet(0, t.length, false));
  } else {
    final List<Triplet<int, int, bool>> result = [];
    Triplet<int, int, bool>? last;

    for (final idx in idxs) {
      final isLast = idx == idxs.last;
      if (last == null) {
        if (idx.first == 0) {
          result.add(idx);
        } else {
          result
            ..add(Triplet(0, idx.first, false))
            ..add(idx);
        }
      } else if (last.second == idx.first) {
        result.add(idx);
      } else {
        result
          ..add(Triplet(last.second, idx.first, false))
          ..add(idx);
      }

      if (isLast && idx.second != t.length) {
        result.add(Triplet(idx.second, t.length, false));
      }

      last = idx;
    }

    idxs = result;
  }

  return idxs;
}

class Triplet<A, B, C> {
  A first;
  B second;
  C third;
  Triplet(
    this.first,
    this.second,
    this.third,
  );

  Triplet copyWith({
    A? first,
    B? second,
    C? third,
  }) {
    return Triplet(
      first ?? this.first,
      second ?? this.second,
      third ?? this.third,
    );
  }

  @override
  String toString() => 'Triple first: $first, second: $second, third: $third';

  @override
  bool operator ==(Object o) {
    return o is Triplet &&
        o.first == first &&
        o.second == second &&
        o.third == third;
  }

  @override
  int get hashCode {
    return hashList([
      first,
      second,
      third,
    ]);
  }
}
