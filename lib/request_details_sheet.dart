import 'package:flutter/material.dart';

import 'widgets/DriverDetails.dart';

class RequestDetailsSheet extends StatelessWidget {
  final String cost, distance, rate, time, pickupAddress, dropAdress;

  const RequestDetailsSheet(
      {Key key,
      @required this.cost,
      @required this.distance,
      @required this.rate,
      @required this.time,
      @required this.pickupAddress,
      @required this.dropAdress})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('$time min',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('\$' + cost,
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                  Text('$distance km',
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                  Text(rate,
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                ]),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.blue)),
                SizedBox(width: 8),
                Text(pickupAddress)
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(color: Colors.green),
                ),
                SizedBox(width: 8),
                Text(dropAdress)
              ],
            ),
            InkWell(
              onTap: () {
                showBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) => DriverListBottomSheet());
              },
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Center(
                  child: Text('Tap To Accept',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Center(
                child: Text('Tap To Cancel',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
