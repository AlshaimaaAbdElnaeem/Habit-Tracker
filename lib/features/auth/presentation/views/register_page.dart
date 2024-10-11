import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_button.dart';
class RegisterPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const  Text(
          'Register',
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Pacifico',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[900]!, Colors.blue[100]!],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    const   SizedBox(height: 50),
                     const  Text(
                        'Create an Account',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                     const  SizedBox(height: 30),
                      _buildTextField('Name', false, _nameController, (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name is required';
                        }
                        if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                          return 'Name must contain only letters';
                        }
                        return null;
                      }),
                     const SizedBox(height: 20),
                      _buildTextField('Email', false, _emailController, (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      }),
                     const SizedBox(height: 20),
                      _buildTextField('Password', true, _passwordController, (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        if (value.length < 8) {
                          return 'Password must be at least 8 characters long';
                        }
                        return null;
                      }),
                     const SizedBox(height: 20),
                      _buildTextField('Re-Password', true, _rePasswordController, (value) {
                        if (value == null || value.isEmpty) {
                          return 'Re-Password is required';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        if (value.length < 8) {
                          return 'Re-Password must be at least 8 characters long';
                        }
                        return null;
                      }),
                     const SizedBox(height: 40),
                      CustomButton(
                        text: 'Register',
                        backgroundColor: Colors.orange,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Registering...')),
                            );
                            Navigator.pop(context);
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

  Widget _buildTextField(
      String label, bool isObscure, TextEditingController controller, String? Function(String?) validator) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.orange,
          fontWeight: FontWeight.bold,
        ),
        filled: true,
        fillColor: Colors.blue[700]!.withOpacity(0.8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
      validator: validator,
    );
  }
}
