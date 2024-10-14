import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_project/features/auth/data/auth_cubit/auth_cubit.dart';
import 'package:task_project/features/auth/data/auth_cubit/auth_states.dart';
import 'package:task_project/features/auth/presentation/model_view/users_model.dart';

import '../../../../core/functions/show_snack_bar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../home/presentation/views/home_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isRePasswordVisible = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    super.dispose();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (BuildContext context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          isLoading = false;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        } else if (state is RegisterFailure) {
          isLoading = false;
          showSnackBar(context, state.errorMessages);
        }
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
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
                          const SizedBox(height: 50),
                          const Text(
                            'Create an Account',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 30),
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
                          _buildPasswordField('Password', _passwordController, (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            }
                            if (value.length < 8) {
                              return 'Password must be at least 8 characters long';
                            }
                            return null;
                          }),
                          const SizedBox(height: 20),
                          _buildRePasswordField('Re-Password', _rePasswordController, (value) {
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
                            backgroundColor: Colors.grey,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final userdata = UserModel(
                                  _nameController.text.trim(),
                                  _emailController.text.trim(),
                                  _passwordController.text.trim(),
                                );
                                _registerUser(userdata); // تعديل دالة التسجيل
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
        ),
      ),
    );
  }

  Widget _buildTextField(String label, bool isObscure, TextEditingController controller, String? Function(String?) validator) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.black,
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

  Widget _buildPasswordField(String label, TextEditingController controller, String? Function(String?) validator) {
    return TextFormField(
      controller: controller,
      obscureText: !_isPasswordVisible,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        filled: true,
        fillColor: Colors.blue[700]!.withOpacity(0.8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.black,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
      ),
      validator: validator,
    );
  }

  Widget _buildRePasswordField(String label, TextEditingController controller, String? Function(String?) validator) {
    return TextFormField(
      controller: controller,
      obscureText: !_isRePasswordVisible,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        filled: true,
        fillColor: Colors.blue[700]!.withOpacity(0.8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _isRePasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.black,
          ),
          onPressed: () {
            setState(() {
              _isRePasswordVisible = !_isRePasswordVisible;
            });
          },
        ),
      ),
      validator: validator,
    );
  }

  Future<void> _registerUser(UserModel userdata) async {
    try {
      // التسجيل باستخدام Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userdata.email,
        password: userdata.password,
      );

      // حفظ الاسم والبريد الإلكتروني في Firestore
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'name': userdata.userName,
        'email': userdata.email,
      });

      // عرض رسالة نجاح وتوجيه المستخدم إلى الصفحة الرئيسية
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } catch (e) {
      print('Error: $e');
    }
  }
}
