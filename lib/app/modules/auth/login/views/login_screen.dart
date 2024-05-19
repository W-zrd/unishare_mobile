import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:unishare/app/controller/auth_controller.dart';
import 'package:unishare/app/modules/homescreen/home_screen.dart';
import 'package:unishare/app/widgets/button/google_button.dart';
import 'package:unishare/app/widgets/button/primary_button.dart';
import 'package:unishare/app/modules/auth/register/views/register_screen.dart';
import 'package:unishare/app/modules/admin/dashboard/views/dashboard_admin.dart';

class LoginPage extends StatefulWidget {
  final AuthService? loginService;
  const LoginPage({super.key, this.loginService});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late final AuthService _loginService;
  final Logger _logger = Logger();

  @override
  void initState() {
    super.initState();
    _loginService = widget.loginService ??
        AuthService(); // Or provide your default RegisterService constructor
  }

  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      _logger.e("Email or password is empty");
      return;
    }

    final user =
        await _loginService.signInWithEmailAndPassword(email, password);
    if (user != null) {
      if (user.email != "admin@unishare.com") {
        _logger.i("Login successful");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        _logger.i("Login successful");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AdminHomePage()),
        );
      }
    } else {
      _logger.w("Login failed");
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
          'Masuk Akun',
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
                controller: _emailController,
                key: Key("email-field"),
                decoration: const InputDecoration(
                  labelText: 'Masukkan Email address',
                  border: UnderlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _passwordController,
                key: Key("password-field"),
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Masukkan Password',
                  border: UnderlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: false,
                        onChanged: (value) {},
                        checkColor: Colors.orange.shade700,
                      ),
                      const Text('Remember Password'),
                    ],
                  ),
                  Text(
                    'Lupa Password?',
                    style: TextStyle(
                        color: Colors.orange.shade700,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 40.0),
              Center(
                child: Column(
                  children: [
                    PrimaryButton("Masuk Akun", onPressed: _login),
                    const SizedBox(height: 20.0),
                    const Text(
                      'Atau masuk menggunakan',
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
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
                  const Text('Belum punya akun?'),
                  const SizedBox(width: 10.0),
                  GestureDetector(
                    key: Key("register-text-button"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Register!',
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
