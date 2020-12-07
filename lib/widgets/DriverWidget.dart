import 'package:admin/obj/Driver.dart';
import 'package:admin/util/Keys.dart';
import 'package:admin/util/cont.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import 'DriverDetails.dart';

class DriverWidget extends StatelessWidget {
  final Driver driver;
  final Function onTap;
  final bool fromMainScreen;
  DriverWidget({@required this.driver, this.onTap, this.fromMainScreen = true});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap == null)
          return null;
        else
          return onTap(driver.id, context);
      },
      child: Container(
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: RoundCorner,
        ),
        // duration: Duration(seconds: 2),
        // curve: Curves.fastOutSlowIn,
        height: MediaQuery.of(context).size.height * ScreenPercent,
        // color: Colors.white,
        padding: EdgeInsets.all(10),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          // crossAxisAlignment: CrossAxisAlignment.s
          children: [
            Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        // border: Border.all(width: 2, color: Colors.grey),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          "https://media.istockphoto.com/photos/close-up-profile-of-handsome-young-black-man-against-isolated-white-picture-id1142003969?k=6&m=1142003969&s=612x612&w=0&h=MVrt_NzuYzUJY1R2Jt8-kmd1xIGkls8adI35YUpq3CI=",
                          // height:
                          //     MediaQuery.of(context).size.height * (1 / ScreenPercent),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Center(
                      child: DriverTextWidget(
                          '${driver.firstName} ${driver.lastName}'),
                    ),
                    Center(
                      child: DriverTextWidget('${driver.truckType}'),
                    )
                  ],
                )),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                width: 1,
                child: Container(
                  color: Colors.grey[300],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex:1,
                          child: IconsWidget(
                            driver: driver,
                            icon: Icons.phone,
                            onTap: () {
                              print('mDebug: clicked2');
                              UrlLauncher.launch("tel:${driver.mobile}");
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconsWidget(
                            driver: driver,
                            icon: Icons.message,
                            onTap: () {},
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconsWidget(
                              driver: driver,
                              icon: Icons.location_on,
                              onTap: () {}),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      width: double.infinity,
                      child: FlatButton(
                        padding: EdgeInsets.all(15),
                        color: Colors.blueAccent,
                        onPressed: () async {
                          LocationResult result = await showLocationPicker(
                              context, API_KEY,
                              initialCenter: LatLng(31.1975844, 29.9598339),
                              automaticallyAnimateToCurrentLocation: true,
                              myLocationButtonEnabled: true,
                              layersButtonEnabled: true,
                              countries: ['EG'],
                              language: 'AR');
                          print('mDebug: result latlng: ${result.latLng}');
                          setDestination(result.latLng);
                          print('mDebug: result=$result');
                        },
                        child: Text(
                          'set destination',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void setDestination(LatLng latLng) {
    Map<String, String> map = {};
    map['lat'] = latLng.latitude.toString();
    map['long'] = latLng.longitude.toString();
    FirebaseDatabase.instance
        .reference()
        .child("Location")
        .child(driver.id)
        .child('destination')
        .set(map);
  }
}

class IconsWidget extends StatelessWidget {
  final Driver driver;
  final IconData icon;
  final Function onTap;
  IconsWidget({this.driver, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      // color: Colors.yellow,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: Container(
        padding: EdgeInsets.all(5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.grey[500], borderRadius: BorderRadius.circular(50)),
        child: Icon(
          icon,
          color: Colors.white,
          // size: 50,
        ),
      ),
      onPressed: onTap,
    );
  }
}
