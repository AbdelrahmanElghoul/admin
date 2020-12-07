//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

import 'file:///D:/Projects/flutter/admin/lib/widgets/DriverWidget.dart';
import 'file:///D:/Projects/flutter/admin/lib/widgets/DriverDetails.dart';
import 'package:admin/obj/Driver.dart';
import 'package:admin/obj/admin.dart';
import 'package:admin/screens/driversScreen.dart';
import 'package:admin/util/cont.dart';
import 'package:admin/widgets/MainScreenDrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MaterialApp(home: MainScreen()));
// }

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Driver driver;
  DriverWidgetState bottomWidgetState = DriverWidgetState.idle;
  List<Driver> driverList = [];
  Map<String, LatLng> driverMap = {};
  GoogleMapController mapController;
  DatabaseReference locationReference =
      FirebaseDatabase.instance.reference().child("Location");
  DatabaseReference informationReference =
      FirebaseDatabase.instance.reference().child("Information");
  // Location location = new Location();
  LocationData locationData;
  LocationResult locationResult;

  void moveCamera(LatLng direction) {
    mapController.moveCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: direction, zoom: 100)));
  }

  @override
  void initState() {
    super.initState();
    locationReference.onChildAdded.listen((event) {
        print('MapScreen mDebug: event1=${event.toString()}');
        print('MapScreen mDebug: event2=${event.snapshot.key}');
        print('MapScreen mDebug: event3=${event.snapshot.value}');
        print('MapScreen mDebug: event4=${event.snapshot.value.toString()}');
        print('MapScreen mDebug: event5=${event.snapshot.value['CurrentLocation']['lat']}');

      LatLng loc = LatLng(double.parse(event.snapshot.value['CurrentLocation']['lat']),
          double.parse(event.snapshot.value['CurrentLocation']['lat']));
      driverMap[event.snapshot.key] = loc;
      drawMark(event.snapshot.key);
    });

    locationReference.onChildChanged.listen((event) {

      print('MapScreen mDebug: event1=${event.toString()}');
      print('MapScreen mDebug: event2=${event.snapshot.key}');
      print('MapScreen mDebug: event3=${event.snapshot.value}');
      print('MapScreen mDebug: event4=${event.snapshot.value.toString()}');
      print('MapScreen mDebug: event5=${event.snapshot.value['CurrentLocation']['lat']}');

      LatLng loc = LatLng(double.parse(event.snapshot.value['CurrentLocation']['lat']),
          double.parse(event.snapshot.value['CurrentLocation']['lat']));
      driverMap[event.snapshot.key] = loc;
      drawMark(event.snapshot.key);
    });

    informationReference.onChildAdded.listen((event) {
      print('mDebug: User1${event.snapshot.value}');
      Driver driver = Driver();
      var data = event.snapshot.value;
      driver.id = event.snapshot.key;
      driver.firstName = data['FirstName'];
      driver.lastName = data['Lastname'];
      driver.mobile = data['MobilePhone'];
      driver.truckType = data['TruckName'];
      driver.company = data['CompanyName'];
      driver.profile = data['Profile'];
      driverList.add(driver);
      print('mDebug: user2=${driverList.length}');
      // driverMap[event.snapshot.key] = loc;
      drawMark(event.snapshot.key);
    });
  }

  Set<Marker> markers = {};
// List<Marker>

  void drawMark(String userID) async {
    print('mDebug: truck pre list=${driverList.length}');
    String truck;

    print('MapScreen mDebug: userID=$userID');
    // print('MapScreen mDebug: userID=${driverMap[userID]}');

    if (driverMap[userID] == null) return;
    driverList.forEach((element) {
      if (element.id == userID) {
        truck = element.truckType;
        print(
            'mDebug: if(${element.id} == ${userID}  then ${element.truckType}');
        return;
      }
    });

    print('mDebug: truck=$truck');

    var marker = await getMarker(truck) ??
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
    print('mDebug: marker=${marker.toString()}');
    setState(() {
      markers.add(Marker(
        markerId: MarkerId(userID),
        position:
            LatLng(driverMap[userID].latitude, driverMap[userID].longitude),
        // driverMap[userID].lat as double,driverMap[userID].lat as double
        icon: marker,
        // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        onTap: () {
          print('mDebug: $userID');
          onMarkerTap(userID);
        },
      ));
      // print('mDebug: marked');
    });
  }

  Future<BitmapDescriptor> getMarker(String truck) {
    if (truck == null) return null;
    String marker = trucksMap[truck];
    // String x='images/marker/$marker.png';
    print('mDebug: markerFun=$marker');
    return BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 1, size: Size(24, 24)),
        trucksMap[truck]);
  }

  void onMarkerTap(String userID) {
    for (int i = 0; i < driverList.length; i++) {
      if (driverList[i].id == userID) {
        var tmp = driverList[i];
        driverList.removeAt(i);
        driverList.insert(0, tmp);
        break;
      }
    }

    setState(() {
      bottomWidgetState = DriverWidgetState.single;
      print('mDebug: ${bottomWidgetState}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      drawer: MainScreenDrawer(
        driverList: driverList,
        setBottomWidgetState: setBottomWidgetState,
        onDriverSelected: selectDriverNonMapScreen,
      ),
      appBar: AppBar(
        title: Text('Map'),
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              GoogleMap(
                onTap: (latLng)  {
                  // getLocation(latLng);
                  print('mDebug: map pressed:${latLng}');
                },
                  onMapCreated: (GoogleMapController controller) {
                    print('mDebug:controller $controller');
                    mapController = controller;
                  },
                  markers: markers,
                  mapToolbarEnabled: true,
                  minMaxZoomPreference: MinMaxZoomPreference(0, 10000),
                  zoomGesturesEnabled: true,
                  zoomControlsEnabled: true,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                      bearing: 30,
                      zoom: 15,
                      // target: LatLng(30.0409126, 31.209564))),
                      target: LatLng(30.0409126, 31.209564))),
              GestureDetector(
                  onPanUpdate: (detail) {
                    print('mDebug: ${detail.delta.dy}');
                    if (detail.delta.dy < 0) {
                      if (driverList.length == 1) return;
                      setBottomWidgetState(DriverWidgetState.list);
                    } else {
                      if (bottomWidgetState == DriverWidgetState.list)
                        setBottomWidgetState(DriverWidgetState.single);
                      else
                        setBottomWidgetState(DriverWidgetState.idle);
                    }
                  },
                  child: AnimatedContainer(
                      duration: Duration(seconds: 10),
                      curve: Curves.elasticInOut,
                      child: showDriverDetails())),
            ],
          ),
        ),
      ),
    );
  }

  void selectDriverNonMapScreen(String id, BuildContext mContext) {
    Navigator.pop(mContext);
    onDriverSelected(id);
  }

  void onDriverSelected(String id) {
    setState(() {
      onMarkerTap(id);
      // camera=LatLng(double.parse(driverMap[id].lat),double.parse(driverMap[id].long));
      moveCamera(LatLng(driverMap[id].latitude, driverMap[id].longitude));
      print(
          'mDebug: latLng=${LatLng(driverMap[id].latitude, driverMap[id].longitude)}');
    });
  }

  void setBottomWidgetState(DriverWidgetState driverWidgetState) {
    setState(() {
      this.bottomWidgetState = driverWidgetState;
    });
  }

  Widget showDriverDetails() {
    print('mDebug: ${bottomWidgetState}');
    if (bottomWidgetState == DriverWidgetState.list)
      return DriverListBottomSheet(
        driverList: driverList,
        setWidgetState: setBottomWidgetState,
        onDriverSelected: onDriverSelected,
      );
    else if (bottomWidgetState == DriverWidgetState.idle)
      return Container();
    else
      return DriverWidget(driver: driverList[0]);
  }


}

enum DriverWidgetState { idle, single, list }
