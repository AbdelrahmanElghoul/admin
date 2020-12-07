import 'dart:ui';

import 'package:flutter/material.dart';

const DefaultText=TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black54);

const ScreenPercent=(2.5 / 11);

const RoundCorner=BorderRadius.only(
topLeft: Radius.circular(25.0),
topRight: Radius.circular(25.0),
);

const Map<String,String> trucksMap= {
  'طن و نص':'images/marker/1.5 ton.png',
  'طن و نصف مغلقة':'images/marker/1.5 ton closed.png',
  'سوزوكي':'images/marker/bolan.png',
  'عربية نقل':'images/marker/jumbo closed.png',
  'عربية نقل مفتوحة':'images/marker/jumbo.png',
  'دراجه':'images/marker/Bicycle2.png',
  'موتوسكل':'images/marker/Motorcycle.png',
  'رافي':'images/marker/ravi.png',
  'ونش':'images/marker/winch.png',
  'تريسيكل':'images/marker/tricycle.png',
};
