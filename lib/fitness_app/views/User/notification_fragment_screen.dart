import 'package:fitnessapp/fitness_app/controllers/User/notificationController.dart';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:fitnessapp/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../preferences/current_user.dart';

class NotificationsFragmentScreen extends StatefulWidget {
  const NotificationsFragmentScreen({Key? key}) : super(key: key);

  @override
  _NotificationsFragmentScreenState createState() =>
      _NotificationsFragmentScreenState();
}

class _NotificationsFragmentScreenState
    extends State<NotificationsFragmentScreen> {
  final _notificationController = Get.put(notificationController());
  CurrentUser _currentUser = Get.put(CurrentUser());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ResponsivePadding(
      child: Scaffold(
        backgroundColor: white,
        body: SafeArea(child: getBody()),
      ),
    );
  }

  Widget getBody() {
    return LayoutBuilder(builder: (context, constraints) {
      return ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: constraints.maxWidth,
          ),
          child: SingleChildScrollView(
              child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  "Notifications",
                  style: TextStylePreset.bigTitle,
                ),
                SizedBox(
                  height: 15,
                ),
                refreshButton(),
                SizedBox(
                  height: 15,
                ),
                displayUserNotifications(),
              ],
            ),
          )));
    });
  }

  MaterialButton refreshButton() {
    return MaterialButton(
      minWidth: double.infinity,
      height: 50,
      color: secondary,
      child: new Text('Refresh',
          style: new TextStyle(fontSize: 20, color: Colors.white)),
      onPressed: () {
        _notificationController.refreshList();
      },
    );
  }

  Obx displayUserNotifications() {
    return Obx(() => ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: _notificationController.allNotifications.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Card(
              color: primary,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Text(
                          _notificationController.allNotifications[index].msg,
                          style: (_notificationController
                                      .allNotifications[index].hasRead ==
                                  0)
                              ? TextStylePreset.bigWhiteBoldText
                              : TextStylePreset.bigWhiteText,
                        )),
                        (_notificationController
                                    .allNotifications[index].hasRead ==
                                0)
                            ? Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                    onPressed: () {
                                      _notificationController.markAsRead(
                                          _notificationController
                                              .allNotifications[index]
                                              .notifyID);
                                    },
                                    icon: Icon(Icons.mark_email_read)))
                            : Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                    onPressed: () {
                                      _notificationController.unmarkAsRead(
                                          _notificationController
                                              .allNotifications[index]
                                              .notifyID);
                                    },
                                    icon: Icon(Icons.mark_email_unread))),
                        Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                                onPressed: () {
                                  _notificationController
                                      .deleteUserNotification(
                                          _notificationController
                                              .allNotifications[index]
                                              .notifyID);
                                },
                                icon: Icon(Icons.delete))),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
