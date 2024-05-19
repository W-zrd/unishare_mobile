import 'package:flutter/material.dart';
import 'package:unishare/app/controller/auth_controller.dart';
import 'package:unishare/app/modules/homescreen/home_screen.dart';
import 'package:unishare/app/widgets/button/primary_button.dart';
import 'package:unishare/app/modules/auth/login/views/login_screen.dart';
import 'package:unishare/app/widgets/button/google_button.dart';
import 'package:logger/logger.dart';

class RegisterPage extends StatefulWidget {
  final AuthService? registerService;

  const RegisterPage({super.key, this.registerService});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  final Logger _logger = Logger();
  late final AuthService _registerService;

  @override
  void initState() {
    super.initState();
    _registerService = widget.registerService ??
        AuthService(); // Or provide your default RegisterService constructor
  }

  Future<void> _register() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final displayName = _nameController.text.trim();

    if (email.isEmpty || password.isEmpty || displayName.isEmpty) {
      _logger.e("Email, password, or display name is empty");
      return;
    }

    // Call the registerUser method and await for the result
    final user =
        await _registerService.registerUser(email, password, displayName);

    // Check if the user is not null (registration successful)
    if (user != null) {
      _logger.i("Register successful");

      // Navigate to the HomeScreen using a MaterialPageRoute
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } else {
      _logger.w("Register failed");

      // Show an error message or handle the registration failure
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration failed. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Daftar Akun',
          style: TextStyle(
            fontFamily: 'Rubik',
            fontWeight: FontWeight.w500,
            fontSize: 20.0,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20.0),
              const Image(
                // Centered Image
                image: AssetImage('assets/img/unishare_text.png'),
                height: 200.0,
              ),
              const SizedBox(height: 40.0),
              TextField(
                key: const Key("fullname-field"),
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Masukkan Nama Lengkap',
                  border: UnderlineInputBorder(),
                ),
              ),
              const SizedBox(height: 40.0),
              TextField(
                key: const Key("email-field"),
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Masukkan Email Address',
                  border: UnderlineInputBorder(),
                ),
              ),
              const SizedBox(height: 40.0),
              TextField(
                key: const Key("password-field"),
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Masukkan Password',
                  border: UnderlineInputBorder(),
                ),
              ),
              const SizedBox(height: 40.0),
              Center(
                child: Column(
                  children: [
                    PrimaryButton("Daftar Akun", onPressed: _register),
                    const SizedBox(height: 20.0),
                    const Text(
                      'Atau daftar menggunakan',
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const GoogleButton(),
                  ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(150.0, 50.0),
                    ),
                    icon: const Icon(Icons.facebook),
                    label: const Text('Facebook'),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Sudah punya akun?'),
                  const SizedBox(width: 10.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Login!',
                      style: TextStyle(
                        color: Colors.orange.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
