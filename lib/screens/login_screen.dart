import 'file:///D:/Projects/flutter/admin/lib/screens/MapScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../habeba/LogoStackWid.dart';
import '../habeba/myclipper.dart';
import '../habeba/otp_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: MainScreen()));
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final key = GlobalKey<FormState>();
  String phoneNo,verId,smsCode;
  bool codeSent =false;
  final _controller = TextEditingController();
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
                    padding: const EdgeInsets.all(5),
                    child: Text('مرحبا بك يا بطل ',
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
                      padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: TextFormField(
                            textAlign: TextAlign.right,
                            onChanged: (value) {
                              validateForm();
                              setState(() {
                                this.phoneNo=value;
                              });},
                            controller: _controller,
                            validator: (value) =>
                                value.length != 11 || value.substring(0, 2) != '01'
                                    ? 'Please Enter Correct Number'
                                    : null,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon:Image.asset("Images/egypt.png",width: 40,),
                              hintText: 'ادخل رقم الهاتف المحمول',hintStyle: TextStyle(

                            ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Center(
                     child: RaisedButton(onPressed:() async {

                       FirebaseAuth auth = FirebaseAuth.instance;

                       await auth.verifyPhoneNumber(
                         phoneNumber: '+20 $phoneNo',
                         verificationCompleted: (PhoneAuthCredential credential) async {
                         UserCredential cred=  await auth.signInWithCredential(credential);
                         print(cred.user.uid);
                         },

                         verificationFailed: (FirebaseAuthException e) {

                         },
                         codeSent: (String verificationId, int resendToken) {
                           verId=verificationId;
                           Navigator.push(
                             context,
                             MaterialPageRoute(builder: (context) => OTPScreen(verId:verId)),
                           );
                         },
                         codeAutoRetrievalTimeout: (String verificationId) {
                           verId=verificationId;
                           Navigator.push(
                           context,
                           MaterialPageRoute(builder: (context) => OTPScreen(verId:verId)),
                           );
                         },
                       );
                     },
                     child: Text('التالي',style: TextStyle(
                       color:Colors.white
                       ),
                       ),
                       color: Colors.blue,
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

                     ),
                   ),
                 ),
                 Center(
                     child: Text("By creating an account,you agree to our",
                         style: TextStyle (
                             color: Colors.black,
                             fontSize: 12,
                         )
                     ),
                 ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Center(
                      child: Text("Terms of Service and Privacy Policy",
                        style: TextStyle (
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.bold
                        )
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
