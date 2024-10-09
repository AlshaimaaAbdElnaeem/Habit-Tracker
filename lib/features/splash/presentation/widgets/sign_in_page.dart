import 'package:flutter/material.dart';
import 'package:task_project/features/home/presentation/views/home_page.dart';



// SignInPage widget with enhanced design and image usage
class SignInPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Custom AppBar with gradient and new font style
      appBar: AppBar(
        title: Text(
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
          // Adding a background image for aesthetic appeal
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Adding a logo or another image at the top
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/log.jpg'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Welcome Back!',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      ),
                    ),
                    SizedBox(height: 20),
                    // Updated Username and Password Fields with custom design
                    _buildTextField(
                      'Username',
                      false,
                      _usernameController,
                          (value) {
                        if (value == null || value.isEmpty) {
                          return 'Username is required';
                        }
                        if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                          return 'Username must not contain numbers';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
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
                    SizedBox(height: 30),
                    // Styled login button with gradient background
                    InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          // Navigate to the HomePage on successful login
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        }
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue[900]!,
                              Colors.orange[300]!,
                            ], // Gradient colors
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                          constraints: BoxConstraints(
                            maxWidth: double.infinity,
                            minHeight: 50,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Custom text field builder with enhanced style and visibility
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
