import 'package:flutter/material.dart';
import 'package:get_x_tutorial/controller/auth_controller.dart';
import 'package:get_x_tutorial/view/widgets/glitch.dart';
import 'package:get_x_tutorial/view/widgets/text_input.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GlithEffect(child: const Text("Tiktok Clone", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),)),
            const SizedBox(height: 25,),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(controller: _emailController, myIcon: Icons.email, myLabelText: "Email"),
            ),
            const SizedBox(height: 20,),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(controller: _passwordController, myIcon: Icons.lock, myLabelText: "Password", toHide: true,)
            ),
            const SizedBox(height: 30,),
            ElevatedButton(onPressed: () {

              AuthController.instance.userLogin(_emailController.text, _passwordController.text);
            }, child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: const Text("Login"))
            ),
          ],
        ),
      ),
    );
  }
}
