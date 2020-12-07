import 'dart:ffi';
import 'dart:math';

import 'file:///D:/Projects/flutter/admin/lib/widgets/DriverWidget.dart';
import 'file:///D:/Projects/flutter/admin/lib/screens/MapScreen.dart';
import 'package:admin/util/cont.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import '../obj/Driver.dart';

class DriverListBottomSheet extends StatefulWidget {
  final List driverList;
  final Function setWidgetState;
  final Function onDriverSelected;
  DriverListBottomSheet(
      {@required this.driverList, @required this.setWidgetState, this.onDriverSelected});

  @override
  _DriverListBottomSheetState createState() => _DriverListBottomSheetState();
}

class _DriverListBottomSheetState extends State<DriverListBottomSheet> {
  List<Widget> getDriverWidget() {
    List<Widget> widgetList = [];
    widget.driverList.forEach((element) {

      widgetList.add(DriverWidget(
        driver: element,
        onTap: widget.onDriverSelected,
      ));
      widgetList.add(Divider());
    });
    return widgetList;
  }

  ScrollController _scrollController;
  @override
  Widget build(BuildContext context) {
      return Scaffold(
      body: InkWell(
        onTap: (){
          widget.setWidgetState(DriverWidgetState.idle);
        },
        // onPanUpdate: (details) {
        //   widget.setWidgetState(DriverWidgetState.idle);
        // },
        child: Container(
          margin: EdgeInsets.only(top: 50),
          // color: Colors.red,
          alignment: Alignment.topCenter,
          child: Container( decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(width: 1, color: Colors.white)),child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(Icons.close,size: 30,color: Colors.white,),
              )),
        ),
      ),
      // floatingActionButton: ,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      backgroundColor: Color(0xA6000000),
      bottomSheet: Container(
        color: Color(0xA6000000),
        child: Container(
          padding: EdgeInsets.only(top: 10),
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: RoundCorner,
          ),
          height: getListHeight(context),
          child: ListView(
            children: getDriverWidget(),
          ),
        ),
      ),
    );
  }

  double getListHeight(BuildContext context) {
    print('mDebug: list length=${widget.driverList.length}');
    return min(
        ((MediaQuery.of(context).size.height *  ScreenPercent) *
                widget.driverList.length) +40,
        (MediaQuery.of(context).size.height * (3 / 4)));
  }
}

class DriverTextWidget extends StatelessWidget {
  final String text;
  DriverTextWidget(@required this.text);
  @override
  Widget build(BuildContext context) {
    return Text('${this.text}', style: DefaultText,textAlign: TextAlign.center,);
  }
}
