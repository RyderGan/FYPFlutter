import 'dart:convert';
import 'dart:ui';
import 'dart:math';
import 'package:fitnessapp/fitness_app/controllers/Admin/editSetPathsController.dart';
import 'package:fitnessapp/fitness_app/models/Admin/pathModel.dart';
import 'package:fitnessapp/fitness_app/views/Admin/path_search_page.dart';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:animated_list_plus/transitions.dart';
import 'package:fitnessapp/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:http/http.dart' as http;

class EditSetPathsPage extends StatefulWidget {
  const EditSetPathsPage({Key? key}) : super(key: key);

  @override
  _EditSetPathsPageState createState() => _EditSetPathsPageState();
}

class _EditSetPathsPageState extends State<EditSetPathsPage>
    with SingleTickerProviderStateMixin {
  final _editSetPathsController = Get.put(editSetPathsController());
  var arguments = Get.arguments;
  Future<List<PathModel>> futureCurrentPathList = Get.arguments[1];
  List<PathModel> currentPathList = <PathModel>[].obs;

  bool inReorder = false;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    futureCurrentPathList.then((value) => currentPathList = value);
    super.initState();
  }

  void onReorderFinished(List<PathModel> newItems) {
    scrollController.jumpTo(scrollController.offset);
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        inReorder = false;
        currentPathList
          ..clear()
          ..addAll(newItems);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
        future: Future.wait([futureCurrentPathList]),
        builder: (context, constraints) {
          return ResponsivePadding(
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Get.back(),
                ),
                title: const Text("Edit Set Information"),
              ),
              backgroundColor: Colors.white,
              body: ListView(
                controller: scrollController,
                // Prevent the ListView from scrolling when an item is
                // currently being dragged.
                padding: const EdgeInsets.only(bottom: 24),
                children: <Widget>[
                  _buildVerticalPathList(),
                  const SizedBox(height: 50),
                  InkWell(
                    onTap: () {
                      _editSetPathsController.updateSetPaths(
                          currentPathList, arguments[0]);
                    },
                    child: updateSetPathsButton(),
                  ),
                ],
              ),
            ),
          );
        });
  }

  // * An example of a vertically reorderable list.
  Widget _buildVerticalPathList() {
    final theme = Theme.of(context);

    Reorderable buildReorderable(
      PathModel path,
      Widget Function(Widget tile) transition,
    ) {
      return Reorderable(
        key: ValueKey(path),
        builder: (context, dragAnimation, inDrag) {
          final tile = Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildTile(path),
              const Divider(height: 0),
            ],
          );

          return AnimatedBuilder(
            animation: dragAnimation,
            builder: (context, _) {
              final t = dragAnimation.value;
              final color = Color.lerp(Colors.white, Colors.grey.shade100, t);

              return Material(
                color: color,
                elevation: lerpDouble(0, 8, t)!,
                child: transition(tile),
              );
            },
          );
        },
      );
    }

    return ImplicitlyAnimatedReorderableList<PathModel>(
      items: currentPathList,
      shrinkWrap: true,
      reorderDuration: const Duration(milliseconds: 200),
      liftDuration: const Duration(milliseconds: 300),
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      areItemsTheSame: (oldItem, newItem) => oldItem == newItem,
      onReorderStarted: (item, index) => setState(() => inReorder = true),
      onReorderFinished: (movedLanguage, from, to, newItems) {
        // Update the underlying data when the item has been reordered!
        onReorderFinished(newItems);
      },
      itemBuilder: (context, itemAnimation, lang, index) {
        return buildReorderable(lang, (tile) {
          return SizeFadeTransition(
            sizeFraction: 0.7,
            curve: Curves.easeInOut,
            animation: itemAnimation,
            child: tile,
          );
        });
      },
      updateItemBuilder: (context, itemAnimation, lang) {
        return buildReorderable(lang, (tile) {
          return FadeTransition(
            opacity: itemAnimation,
            child: tile,
          );
        });
      },
      footer: _buildFooter(context, theme.textTheme),
    );
  }

  Widget _buildTile(PathModel path) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final List<Widget> actions = [
      SlideAction(
        closeOnTap: true,
        color: Colors.redAccent,
        onTap: () => setState(() => currentPathList.remove(path)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Icon(
                Icons.delete,
                color: Colors.white,
              ),
              const SizedBox(height: 4),
              Text(
                'Delete',
                style: textTheme.bodyText2?.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    ];

    return Slidable(
      actionPane: const SlidableBehindActionPane(),
      actions: actions,
      secondaryActions: actions,
      child: Container(
        alignment: Alignment.center,
        // For testing different size item. You can comment this line
        padding: EdgeInsets.zero,
        child: ListTile(
          title: Text(
            path.name,
            style: textTheme.bodyText2?.copyWith(
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            path.points.toString(),
            style: textTheme.bodyText1?.copyWith(
              fontSize: 15,
            ),
          ),
          leading: SizedBox(
            width: 36,
            height: 36,
            child: Center(
              child: Text(
                '${currentPathList.indexOf(path) + 1}',
                style: textTheme.bodyText2?.copyWith(
                  color: theme.highlightColor,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          trailing: const Handle(
            delay: Duration(milliseconds: 0),
            capturePointer: true,
            child: Icon(
              Icons.drag_handle,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context, TextTheme textTheme) {
    return Box(
      color: Colors.white,
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PathSearchPage(type: arguments[0].type),
          ),
        );

        if (result != null && !currentPathList.contains(result)) {
          setState(() {
            currentPathList.add(result);
          });
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: const SizedBox(
              height: 36,
              width: 36,
              child: Center(
                child: Icon(
                  Icons.add,
                  color: Colors.grey,
                ),
              ),
            ),
            title: Text(
              'Add a Path',
              style: textTheme.bodyText1?.copyWith(
                fontSize: 16,
              ),
            ),
          ),
          const Divider(height: 0),
        ],
      ),
    );
  }

  Container updateSetPathsButton() {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [fourthColor, thirdColor]),
          borderRadius: BorderRadius.circular(30)),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.arrow_forward_sharp,
            color: white,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            "Save Path Order",
            style: TextStylePreset.btnSmallText,
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
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
