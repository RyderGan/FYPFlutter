import 'package:fitnessapp/fitness_app/fitness_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:fitnessapp/fitness_app/models/visceralFats.dart';
import 'package:fitnessapp/fitness_app/services/remote_service.dart';
import 'package:intl/intl.dart';

class VisceralFatView extends StatelessWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const VisceralFatView({Key? key, this.animationController, this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 16, bottom: 18),
              child: Container(
                  //Future Builder
                  child: FutureBuilder(
                      future: RemoteService().getVisceralFat(),
                      builder: (BuildContext context,
                          AsyncSnapshot<VisceralFats?> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return Container(
                              padding: const EdgeInsets.all(5),
                              child: DataClass(
                                  datalist: snapshot.data as VisceralFats));
                        }
                      })),
            ),
          ),
        );
      },
    );
  }
}

class DataClass extends StatelessWidget {
  const DataClass({Key? key, required this.datalist}) : super(key: key);
  final VisceralFats datalist;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FitnessAppTheme.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8.0),
            bottomLeft: Radius.circular(8.0),
            bottomRight: Radius.circular(8.0),
            topRight: Radius.circular(68.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: FitnessAppTheme.grey.withOpacity(0.2),
              offset: const Offset(1.1, 1.1),
              blurRadius: 10.0),
        ],
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 16, right: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(left: 4, bottom: 8, top: 16),
                  child: Text(
                    'Visceral Fat',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: FitnessAppTheme.fontName,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        letterSpacing: -0.1,
                        color: FitnessAppTheme.darkText),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 4, bottom: 3),
                          child: Text(
                            datalist.visceralFat.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: FitnessAppTheme.fontName,
                              fontWeight: FontWeight.w600,
                              fontSize: 28,
                              color: FitnessAppTheme.nearlyDarkBlue,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 8, bottom: 8),
                          child: Text(
                            '%',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: FitnessAppTheme.fontName,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              letterSpacing: -0.2,
                              color: FitnessAppTheme.nearlyDarkBlue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.access_time,
                              color: FitnessAppTheme.grey.withOpacity(0.5),
                              size: 16,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text(
                                DateFormat('yyyy-MM-dd')
                                    .format(datalist.updatedAt),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: FitnessAppTheme.fontName,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  letterSpacing: 0.0,
                                  color: FitnessAppTheme.grey.withOpacity(0.5),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          const Padding(
              padding: EdgeInsets.only(
                  left: 24, right: 24, top: 8, bottom: 8)),
        ],
      ),
    );
  }
}
