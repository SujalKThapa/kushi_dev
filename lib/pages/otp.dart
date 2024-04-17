import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kushi_3/components/mybutton.dart';
import 'package:kushi_3/pages/selectGender.dart';
import 'package:kushi_3/pages/signin.dart';
import 'package:pinput/pinput.dart';

class OTPVerificationPage extends StatefulWidget {


  OTPVerificationPage({
    super.key,

  });

  @override
  _OTPVerificationPageState createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  late List<TextEditingController> _controllers;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(6, (index) => TextEditingController());
  }

  @override
  void dispose() {
    _controllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  void _verifyOTP() async{
    try{

    }catch(ex){

    }

  }

  @override
  Widget build(BuildContext context) {
    var code ="";
    final String data = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                child: Column(
                  children: [
                    Text(
                      "Phone Verification",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      "We sent a code to your number ",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 100),
                      child: Row(
                        children: [
                          Text(
                            data,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                "Change",
                                style: TextStyle(
                                  color : Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  decoration: TextDecoration.underline,
                                  decorationThickness: 1.0,

                                ),
                              )
                          )
                        ],
                      ),
                    ),
                  ],
                )),
            Pinput(
              length:6,
              showCursor:true,
              onChanged: (value){
                  code = value;
              },

            ),
            SizedBox(height: 20.0),
            MyButton(text: "Verify OTP", onTap: ()async{
              try{
                PhoneAuthCredential credential =  PhoneAuthProvider.credential(verificationId: SignIn.verify, smsCode: code);
                await auth.signInWithCredential(credential);
                Navigator.pushNamedAndRemoveUntil(context, '/test_page',(route) => false);
              }catch(e){
                  print("wrong otp");
              }


            })
          ],
        ),
      ),
    );
  }
}