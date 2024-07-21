import 'package:flutter/material.dart';
import '../../../controller/auth_controller.dart';
import '../../widgets/glitch.dart';
import '../../widgets/text_input.dart';

class SignUpScreen extends StatelessWidget {

  SignUpScreen({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _setPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 100),
          alignment: Alignment.center,
          //const - Constant - Value - String , Int  - Fix Rahega  - Use Karna
          child : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GlithEffect(child: const Text("Welcome To TikTok" ,style: TextStyle(fontWeight: FontWeight.w900 , fontSize: 30),)),
              const SizedBox(height: 25,),
              InkWell(
                onTap: () {
                  AuthController.instance.imagePicker();
                },
                child: Stack(
                  children: [
                    const CircleAvatar(backgroundImage: NetworkImage("https://st3.depositphotos.com/1767687/16607/v/450/depositphotos_166074422-stock-illustration-default-avatar-profile-icon-grey.jpg"), radius: 60,),
                    Positioned( bottom: 0, right: 0, child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50)
                        ),
                        child: const Icon(Icons.edit , size: 20,color: Colors.black,)))
                  ],
                ),
              ),
              const SizedBox(height: 25,),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: _emailController,
                  myLabelText: "Email",
                  myIcon: Icons.email,
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: _setPasswordController,
                  myLabelText: "Set Password",
                  myIcon: Icons.lock,
                  toHide: true,
                ),
              ),

              const SizedBox(height: 20,),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: _confirmPasswordController,
                  myLabelText: "Confirm Password",
                  myIcon: Icons.lock,
                  toHide: true,
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: _usernameController,
                  myLabelText: "Username",
                  myIcon: Icons.person,
                ),
              ),
              const SizedBox(height: 30,),
              ElevatedButton(onPressed: (){

                AuthController.instance.signUp(_usernameController.text, _emailController.text,_setPasswordController.text, AuthController.instance.proImg);
              }, child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50 , vertical: 10),

                  child: const Text("Sign Up")))
            ],
          ),

        ),
      ),
    );
  }
}