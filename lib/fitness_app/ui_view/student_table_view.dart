import 'package:fitnessapp/fitness_app/fitness_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:fitnessapp/fitness_app/models/rankings.dart';
import 'package:fitnessapp/fitness_app/services/remote_service.dart';

class StudentTableView extends StatefulWidget {
  final String titleTxt;
  final String subTxt;
  final AnimationController? animationController;
  final Animation<double>? animation;

  StudentTableView(
      {Key? key,
      this.titleTxt: "",
      this.subTxt: "",
      this.animationController,
      this.animation})
      : super(key: key);

  @override
  State<StudentTableView> createState() => _StudentTableViewState();
}

class _StudentTableViewState extends State<StudentTableView> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animation!,
          child: Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.animation!.value), 0.0),
            child: Container(
              child: FutureBuilder(
                  future: RemoteService().getStudentRankings(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Rankings>?> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return Container(
                          padding: const EdgeInsets.all(5),
                          child: DataClass(
                              datalist: snapshot.data as List<Rankings>));
                    }
                  }),
            ),
          ),
        );
      },
    );
  }
}

class DataClass extends StatelessWidget {
  const DataClass({Key? key, required this.datalist}) : super(key: key);
  final List<Rankings> datalist;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        // Using scrollView for scrolling and formating
        scrollDirection: Axis.vertical,
        // using FittedBox for fitting complte table in screen horizontally.
        child: FittedBox(
            child: DataTable(
          sortColumnIndex: 1,
          showCheckboxColumn: false,
          border: TableBorder.all(width: 1.0),
          // Data columns as required by APIs data.
          columns: const [
            DataColumn(
                label: Text(
              "ID",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            )),
            DataColumn(
                label: Text(
              "Name",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            )),
            DataColumn(
                label: Text(
              "Points",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            )),
          ],
          // Main logic and code for geting data and shoing it in table rows.
          rows: datalist
              .map(
                  //maping each rows with datalist data
                  (data) => DataRow(cells: [
                        DataCell(
                          Text(data.id,
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w500)),
                        ),
                        DataCell(Text(data.name.toString(),
                            style: const TextStyle(
                                fontSize: 26, fontWeight: FontWeight.w500))),
                        DataCell(
                          Text(data.userPoints.toString(),
                              style: const TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.w500)),
                        ),
                      ]))
              .toList(), // converting at last into list.
        )));
  }
}
