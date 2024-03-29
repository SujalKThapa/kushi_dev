import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kushi_3/components/mybutton.dart';
import 'package:kushi_3/components/sign_in_with.dart';
import 'package:kushi_3/components/textfield.dart';
import 'package:kushi_3/pages/otp.dart';
import 'package:kushi_3/pages/selectGender.dart';
import 'package:kushi_3/pages/selectWeight.dart';
import 'package:kushi_3/service/auth_service.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {

  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phonenNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  void signUp(BuildContext context) async{
    final _authService = Provider.of<AuthService>(context,listen:false);
    try{
      await _authService.signUpWithEmailandPassword(_emailController.text, _passwordController.text,_fullnameController.text,_phonenNumberController.text);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SelectWeight()));
    }catch(e){

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 25,),
            const Text(
              "Sign Up",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black,
                fontSize: 29,
              ),
            ),
            const SizedBox(height: 25,),
            MyTextField(
              hintText: "Full Name",
              obscureText: false,
              controller: _fullnameController,

            ),
            const SizedBox(height: 25,),
            MyTextField(
              hintText: "Email",
              obscureText: false,
              controller: _emailController,


            ),
            const SizedBox(height: 25,),
            MyTextField(
              hintText: "Phone Number",
              obscureText: false,
              controller: _phonenNumberController,

            ),
            const SizedBox(height: 25,),
            MyTextField(
              hintText: "Password",
              obscureText: true,
              controller: _passwordController,

            ),
            const SizedBox(height: 10,),
            Text("By continuing you accept our Privacy Policy",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            const SizedBox(height: 10,),
            MyButton(text: "Sign Up", onTap:() =>signUp(context),
            ),
            const SizedBox(height: 15,),
            const SizedBox(height:50,),
            const Text("Sign In With", style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 25,
            ),),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SquareTile(imagePath: 'assets/icons/google.png',),
                SizedBox(width: 10,),
                SquareTile(imagePath: 'assets/icons/apple.png',)
              ],
            ),
          ],
        ),
      ),
    );
  }
}