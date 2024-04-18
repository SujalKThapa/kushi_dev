import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kushi_3/components/mybutton.dart';
import 'package:kushi_3/components/sign_in_with.dart';
import 'package:kushi_3/components/textfield.dart';
import 'package:kushi_3/pages/mainactivity.dart';
import 'package:kushi_3/pages/otp.dart';
import 'package:kushi_3/pages/selectGender.dart';
import 'package:kushi_3/pages/signup.dart';
import 'package:kushi_3/service/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:kushi_3/model/globals.dart' as globals;


class SignIn extends StatefulWidget {

  SignIn({super.key});

  static String verify = "";

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final TextEditingController countryCode = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  Country selectedCountry = Country(
      phoneCode: "91",
      countryCode: "IN",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "India",
      example: "India",
      displayName: "India",
      displayNameNoCountryCode: "IN",
      e164Key: ""
  );


  @override
  void initState() {
    countryCode.text = "+91";
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .background,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const SizedBox(height: 230,),

              const Text(
                "Phone Verification",
                style: TextStyle(
                  fontWeight: FontWeight.w700,

                  color: Colors.black,
                  fontSize: 29,
                ),
              ),

              const SizedBox(height: 25,),
              Container(
                height: 55,
                margin: EdgeInsets.only(left: 30, right: 30),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),

                    Expanded(

                      child: TextField(
                        controller: phoneNumber,
                        keyboardType: TextInputType.phone,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                          // Limit to 10 characters
                          _PhoneNumberFormatter(),
                          // Custom input formatter for phone number
                        ],
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Phone",

                            prefixIcon: Container(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  showCountryPicker(context: context, onSelect:(value){
                                    setState(() {
                                      selectedCountry= value;
                                    });
                                  });
                                },
                                child: Text(
                                  "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )


                        ),

                      ),
                    )
                  ],
                ),
              ),


              SizedBox(height: 50,),
              MyButton(text: "Send the code", onTap: () async {
                await FirebaseAuth.instance.verifyPhoneNumber(
                  phoneNumber: '${countryCode.text} ${phoneNumber.text}',
                  verificationCompleted: (PhoneAuthCredential credential) {},
                  verificationFailed: (FirebaseAuthException e) {},
                  codeSent: (String verificationId, int? resendToken) {
                    SignIn.verify = verificationId;
                    Navigator.pushNamed(
                        context,
                        '/OTPPage',
                        arguments: "${countryCode.text} ${phoneNumber.text}"
                    );
                  },
                  codeAutoRetrievalTimeout: (String verificationId) {},

                );
              }
              ),
              const SizedBox(height: 15,),

              const SizedBox(height: 50,),

              const Text("Sign In With", style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 25,
              ),),
              Row(

                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => AuthService().signInWithGoogle(context),
                    child: SquareTile(imagePath: 'assets/icons/google.png'),
                  ),
                  // SquareTile(imagePath: 'assets/icons/google.png',),
                  SizedBox(width: 10,),
                  SquareTile(imagePath: 'assets/icons/apple.png',)


                ],
              ),


            ],
          ),
        ),
      ),
    );
  }
}

class _PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue,
      TextEditingValue newValue) {
    if (newValue.text.length == 1) {
      return newValue.copyWith(
        text: '${newValue.text}', // Automatically add '+' at the beginning
        selection: TextSelection.collapsed(offset: newValue.text.length),
      );
    } else {
      return newValue;
    }
  }
}
