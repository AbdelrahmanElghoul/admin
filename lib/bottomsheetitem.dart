import 'package:flutter/material.dart';

class BottomSheetItem extends StatelessWidget {
  final String imagePath, percentage, title;

  BottomSheetItem({this.imagePath, this.percentage, this.title});



  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath),
          SizedBox(height: 8),
          Text('$percentage', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text(title)
        ],
      ),
    );
  }
}
