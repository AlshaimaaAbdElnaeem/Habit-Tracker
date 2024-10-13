import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:task_project/features/auth/data/auth_cubit/auth_cubit.dart';
import 'package:task_project/features/home/presentation/views/home_page.dart';

import '../../../../core/functions/show_snack_bar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../data/auth_cubit/auth_states.dart';

// SignInPage widget with email and password fields
class SignInPage extends StatefulWidget {
  @override
  State<SignInPage> createState() => _SignInPageState();

}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

bool isLoading = false ;
@override
void dispose() {
  _emailController.dispose();
  _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
        listener: (BuildContext context, AuthStates state) {
          if (state is LoginLoading) {
            isLoading = true;
          } else if (state is LoginSuccess) {
            isLoading = false;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) =>const HomePage()),
            );
          } else if (state is LoginFailure) {
            isLoading = false;
            showSnackBar(context, state.errorMessage);
          }
        }, builder: (context, state) {
    return ModalProgressHUD(
      inAsyncCall :isLoading,
      child: Scaffold(
        appBar: AppBar(
          title:const Text(
            'Sign In',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Pacifico',
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.blue[900],
          elevation: 0,
          centerTitle: true,
        ),
        body: Stack(
          children: [
            // Background image
            // Container(
            //   decoration: const BoxDecoration(
            //     image: DecorationImage(
            //       image: AssetImage('assets/images/background.jpg'),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo or image
                      Container(
                        height: 150,
                        width: 150,
                        decoration:const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/log.jpg'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                     const SizedBox(height: 20),
                      Text(
                        'Welcome Back!',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[900],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Email field
                      _buildTextField(
                        'Email',
                        false,
                        _emailController,
                            (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                     const SizedBox(height: 20),
                      // Password field
                      _buildTextField(
                        'Password',
                        true,
                        _passwordController,
                            (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';

                          }
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters long';
                          }
                          return null;
                        },
                      ),
                     const SizedBox(height: 30),
                      // Sign In button using CustomButton
                      CustomButton(
                        text: 'Login',
                        backgroundColor: Colors.blue[900]!, // Gradient colors
                        textColor: Colors.white,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Navigate to the HomePage on successful login
                          BlocProvider.of<AuthCubit>(context).loginUser(email: _emailController.text.trim(), password: _passwordController.text.trim(),);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
    );}

  // Custom text field builder
  Widget _buildTextField(String label, bool isObscure,
      TextEditingController controller, String? Function(String?) validator) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white.withOpacity(0.8),
        labelStyle: TextStyle(color: Colors.blue[900]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.blue[900]!, // Border color
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.blue[400]!, // Enabled border color
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.orange[300]!, // Focused border color
            width: 2,
          ),
        ),
      ),
      validator: validator,
    );
  }
}
