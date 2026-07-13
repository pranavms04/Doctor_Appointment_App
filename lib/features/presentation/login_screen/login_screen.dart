import 'package:flutter/material.dart';
import 'package:doctor_appointment_app/features/core/theme/theme_constants.dart';
import 'package:doctor_appointment_app/features/presentation/home_screen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConstants.backgroundColor, // Applied constant global theme canvas color
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Hero(
                    tag: "logo",
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        color: ThemeConstants.primaryColor.withAlpha(25), // Tinted branding profile bubble
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.medical_services,
                        color: ThemeConstants.primaryColor,
                        size: 60,
                      ),
                    ),
                  ),

                  const SizedBox(height: 35),

                  const Text(
                    "Welcome Back",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: ThemeConstants.textMainColor),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Login to continue as Doctor",
                    style: TextStyle(color: ThemeConstants.textMutedColor, fontSize: 16),
                  ),

                  const SizedBox(height: 45),

                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: ThemeConstants.textMainColor),
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: const TextStyle(color: ThemeConstants.textMutedColor),
                      prefixIcon: const Icon(Icons.email_outlined, color: ThemeConstants.textMutedColor),
                      filled: true,
                      fillColor: ThemeConstants.inputFillColor,
                      border: OutlineInputBorder(
                        borderRadius: ThemeConstants.inputRadius,
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email required";
                      }

                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return "Invalid email";
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  TextFormField(
                    controller: passwordController,
                    obscureText: obscure,
                    style: const TextStyle(color: ThemeConstants.textMainColor),
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: const TextStyle(color: ThemeConstants.textMutedColor),
                      prefixIcon: const Icon(Icons.lock_outline, color: ThemeConstants.textMutedColor),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscure = !obscure;
                          });
                        },
                        icon: Icon(
                          obscure ? Icons.visibility : Icons.visibility_off,
                          color: ThemeConstants.textMutedColor,
                        ),
                      ),
                      filled: true,
                      fillColor: ThemeConstants.inputFillColor,
                      border: OutlineInputBorder(
                        borderRadius: ThemeConstants.inputRadius,
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password required";
                      }

                      if (value.length < 6) {
                        return "Minimum 6 characters";
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 15),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(foregroundColor: ThemeConstants.primaryColor),
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeConstants.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: ThemeConstants.inputRadius, // Unified element alignment bounds
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HomeScreen(),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        "LOGIN",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 35),

                  Row(
                    children: [
                      const Expanded(child: Divider(color: Colors.black12)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          "OR",
                          style: TextStyle(color: ThemeConstants.textMutedColor.withAlpha(200), fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Expanded(child: Divider(color: Colors.black12)),
                    ],
                  ),

                  const SizedBox(height: 30),

                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(55),
                      foregroundColor: ThemeConstants.textMainColor,
                      side: const BorderSide(color: Colors.black12),
                      shape: RoundedRectangleBorder(
                        borderRadius: ThemeConstants.inputRadius,
                      ),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.g_mobiledata, size: 30, color: ThemeConstants.primaryColor),
                    label: const Text(
                      "Continue with Google",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
