import 'package:admin/obj/Driver.dart';
import 'package:admin/widgets/DriverDetails.dart';
import 'package:admin/widgets/DriverWidget.dart';
import 'package:flutter/material.dart';

class DriversScreen extends StatelessWidget {
  final List driverList;
  final Function setWidgetState;
  final Function onDriverSelected;
  DriversScreen({@required this.driverList,this.setWidgetState,this.onDriverSelected});

  List<Widget> getDriverWidget() {
    List<Widget> widgetList = [];
    driverList.forEach((element) {

      widgetList.add(DriverWidget(
        driver: element,
        onTap: onDriverSelected,
      ));
      widgetList.add(Divider(thickness: 1,));
    });
    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Drivers List'),),
      body: ListView(
       children: getDriverWidget(),
      )
    );
  }


}
