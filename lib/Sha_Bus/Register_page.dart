import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Login_page.dart';
class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // 🔹 تسجيل المستخدم الجديد
  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();
      String fullName = _fullNameController.text.trim();
      String phone = _phoneController.text.trim();

      try {
        // 🔍 التحقق مما إذا كان الحساب مسجلًا بالفعل
        var userExists = await _firestore.collection('users').doc(email).get();
        if (userExists.exists) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('الحساب موجود بالفعل، الرجاء تسجيل الدخول')),
          );
          return;
        }

        // ✅ إنشاء الحساب في Firebase Authentication
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // 🔹 حفظ بيانات المستخدم في Firestore
        await _firestore.collection('users').doc(email).set({
          'fullName': fullName,
          'email': email,
          'phone': phone,
          'createdAt': DateTime.now(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('تم التسجيل بنجاح! يمكنك تسجيل الدخول الآن')),
        );

        // 🔄 إعادة توجيه المستخدم إلى صفحة تسجيل الدخول
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 50),
              Center(
                child: Text(
                  'Register',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Color(0xff205599)),
                ),
              ),
              SizedBox(height: 20),
              _buildTextField(_fullNameController, 'Full Name', Icons.person, 'Please enter your full name'),
              SizedBox(height: 10),
              _buildTextField(_emailController, 'Email', Icons.email, 'Please enter a valid email'),
              SizedBox(height: 10),
              _buildTextField(_phoneController, 'Phone Number', Icons.phone, 'Please enter a valid phone number'),
              SizedBox(height: 10),
              _buildPasswordField(_passwordController, 'Password', _obscurePassword, () {
                setState(() => _obscurePassword = !_obscurePassword);
              }),
              SizedBox(height: 10),
              _buildPasswordField(_confirmPasswordController, 'Confirm Password', _obscureConfirmPassword, () {
                setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
              }),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _signUp,
                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xff205599), foregroundColor: Colors.white),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    child: Text('Register', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text.rich(
                    TextSpan(
                      text: 'Already Have An Account? ',
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'Log in',
                          style: TextStyle(color: Color(0xff1976D2), fontWeight: FontWeight.bold),
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
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, String errorText) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.black),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
      validator: (value) => value!.isEmpty ? errorText : null,
    );
  }

  Widget _buildPasswordField(TextEditingController controller, String label, bool obscureText, VoidCallback onPressed) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(Icons.lock, color: Colors.black),
        suffixIcon: IconButton(
          icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility, color: Colors.grey[600]),
          onPressed: onPressed,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
      validator: (value) {
        if (value!.isEmpty) return 'Please enter your password';
        if (label == 'Confirm Password' && value != _passwordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
    );
  }
}