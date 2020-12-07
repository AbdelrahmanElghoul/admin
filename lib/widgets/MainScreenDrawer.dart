import 'dart:io';

import 'package:admin/obj/admin.dart';
import 'package:admin/screens/driversScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreenDrawer extends StatelessWidget {
  final List driverList;
  final Function setBottomWidgetState;
  final Function onDriverSelected;
  MainScreenDrawer({this.driverList,this.setBottomWidgetState,this.onDriverSelected});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        // elevation: 5,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top:10, bottom:10, left:10, right:10),
                  child: SizedBox(
                      height: 50,
                      width: 50,
                      child: getAdminImage()),
                ), // Image
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good morning,',
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                      Text(
                        'ES ${Admin.firstName} ${Admin.lastName}',
                        style: TextStyle(color: Colors.grey[900], fontSize: 25,fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ), //logo
          Divider(),
          drawerText(context:context, text:'Profile',onTap: (){
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DriversScreen(
                      driverList: driverList,
                      setWidgetState: setBottomWidgetState,
                      onDriverSelected: onDriverSelected,
                    ),)
              );
          }),
          drawerText(context:context, text:'Truck List',onTap: (){
            Navigator.of(context).pop();
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DriversScreen(
                    driverList: driverList,
                    setWidgetState: setBottomWidgetState,
                    onDriverSelected: onDriverSelected,
                  ),)
            );
          }),
          drawerText(context:context, text:'Logout',onTap: (){
            Navigator.of(context).pop();
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DriversScreen(
                    driverList: driverList,
                    setWidgetState: setBottomWidgetState,
                    onDriverSelected: onDriverSelected,
                  ),)
            );
          }),
          //Logout
        ]),
      ),
    );
  }

  Widget getAdminImage(){
    if(Admin.profile==null)
      return Image.asset('images/hovo_white.png',height: 50,color: Colors.red,);
    else
      return ClipRRect(child: Image.network(Admin.profile,height: 50,),
      borderRadius: BorderRadius.circular(50),); //height 50
  }
  
  Widget drawerText({BuildContext context, String text, Function onTap}){
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding:EdgeInsets.only(top:15,left:25,bottom: 10),
        child: Text(text,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
      ),
    );
  }
}
