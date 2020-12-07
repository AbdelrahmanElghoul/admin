import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'LogoStackWid.dart';
import 'myclipper.dart';

class OTPScreen extends StatefulWidget {
 final String verId ;

  const OTPScreen({Key key, this.verId}) : super(key: key);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: key,
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                 ClipPath(clipper: MyClipper(),child: LogoStack(),),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text('ادخل رقم التاكيد المرسل اليك',
                    style: TextStyle(
                      backgroundColor: Colors.white,
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            onChanged: (value) async{
                              print(widget.verId);
                              validateForm();
                              if(value.length==6){
                                PhoneAuthCredential credential =
                                PhoneAuthProvider.credential(
                                    smsCode: value, verificationId: widget.verId);
                                await FirebaseAuth.instance
                                    .signInWithCredential(credential);
                                // if(FirebaseAuth.instance.currentUser!=null)
                                      // Navigator.push(
                                      // context,
                                      // MaterialPageRoute(builder: (context) => RegisterScreen()),
                                      //      );
                              }
                              },

                            validator: (value) =>
                                value.length != 6 ? 'Please Enter Correct Number' : null,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              // suffixIcon: Container(
                              //   padding: EdgeInsets.all(8.0),
                              //     decoration: BoxDecoration(color: Colors.blue,shape: BoxShape.circle),
                              //     child: InkWell(onTap: (){
                              //       Navigator.push(
                              //       context,
                              //       MaterialPageRoute(builder: (context) => RegisterScreen()),
                              //            );
                              //
                              //     },
                              //
                              //         child: Icon(Icons.arrow_right_alt,color: Colors.white,))
                              // ),
                              hintText: 'ادخل الكود',hintStyle: TextStyle(
                            ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: FlatButton(onPressed: (){},
                       child: Text ("اعاده ارسال الكود",
                           style: TextStyle (
                           color: Colors.black,
                           fontSize: 15,
                           fontWeight: FontWeight.bold
                           ),
                           ),
                       ),
                ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool validateForm() {
    if (key.currentState.validate()) return true;
    return false;
  }
}
