import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogoStack extends StatelessWidget {
  const LogoStack({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            height: 500, decoration: BoxDecoration(color: Colors.blue)),
        Positioned(
            child: Center(
          child: Opacity(
            opacity: 0.1,
            child: Image(
              height: 500,
              fit: BoxFit.fitHeight,
              image: AssetImage("images/Routes.jpg"),
            ),
          ),
        )),
        Positioned(
            child: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Center(
            child: Image(
              image: AssetImage("images/hovo_white.png"),
              height: 200,
            ),
          ),
        ),
        )

      ],
    );
  }
}
