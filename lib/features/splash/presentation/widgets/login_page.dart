import 'package:flutter/material.dart';
import 'package:task_project/features/splash/presentation/widgets/custom_button.dart';
import 'package:task_project/features/splash/presentation/widgets/register_page.dart';
import 'package:task_project/features/splash/presentation/widgets/sign_in_page.dart';
import 'package:task_project/features/splash/presentation/widgets/custom_button.dart'; // Import the button

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Welcome to Habit Tracker',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Pacifico',
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  image: DecorationImage(
                    image: AssetImage('assets/images/h2.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 30),
              CustomButton(
                text: 'Sign In',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInPage()),
                  );
                },
              ),
              SizedBox(height: 20),
              CustomButton(
                text: 'Register',
                backgroundColor: Colors.white, // Outline button style
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
