import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../services/auth_service.dart';

class LoginContent extends StatefulWidget {
  const LoginContent({super.key});

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();
  
  String errorMsg = '';
  bool loading = false;
  Map<String, String> fieldErrors = {};

  bool validatePhone(String phone) {
    final phoneRegex = RegExp(r'^[0-9]{10,11}$');
    return phoneRegex.hasMatch(phone);
  }

  bool validateForm() {
    Map<String, String> errors = {};
    
    if (phoneCtrl.text.trim().isEmpty) {
      errors['phone'] = "Số điện thoại không được để trống";
    } else if (!validatePhone(phoneCtrl.text)) {
      errors['phone'] = "Số điện thoại phải có 10-11 chữ số";
    }
    
    if (passCtrl.text.trim().isEmpty) {
      errors['password'] = "Mật khẩu không được để trống";
    } else if (passCtrl.text.length < 6) {
      errors['password'] = "Mật khẩu phải có ít nhất 6 ký tự";
    }
    
    setState(() {
      fieldErrors = errors;
    });
    return errors.isEmpty;
  }

  Future<void> handleLogin() async {
    setState(() {
      errorMsg = '';
      fieldErrors = {};
    });

    if (!validateForm()) return;

    setState(() => loading = true);

    try {
      final result = await AuthService.login(
        phoneNumber: phoneCtrl.text.trim(),
        password: passCtrl.text.trim(),
      );

      if (result['success']) {
        Fluttertoast.showToast(
          msg: result['message'],
          backgroundColor: Colors.green,
        );

        await Future.delayed(const Duration(milliseconds: 1200));
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/');
        }
      } else {
        setState(() {
          errorMsg = result['message'];
        });
        Fluttertoast.showToast(
          msg: result['message'],
          backgroundColor: Colors.red,
        );
      }
    } catch (err) {
      print('Lỗi đăng nhập: $err');
      setState(() {
        errorMsg = 'Lỗi hệ thống. Vui lòng thử lại sau!';
      });
      Fluttertoast.showToast(
        msg: 'Lỗi hệ thống. Vui lòng thử lại sau!',
        backgroundColor: Colors.red,
      );
    } finally {
      if (mounted) {
        setState(() => loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo
                  Container(
                    margin: const EdgeInsets.only(bottom: 32),
                    child: Column(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                            color: Color(0xFF223a66),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Chào mừng trở lại!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF223a66),
                          ),
                        ),
                        const Text(
                          'Đăng nhập để tiếp tục',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Error message
                  if (errorMsg.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.red.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.error, color: Colors.red, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              errorMsg,
                              style: const TextStyle(color: Colors.red, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),

                  // Phone field
                  TextFormField(
                    controller: phoneCtrl,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Số điện thoại',
                      prefixIcon: const Icon(Icons.phone),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      errorText: fieldErrors['phone'],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Password field
                  TextFormField(
                    controller: passCtrl,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Mật khẩu',
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      errorText: fieldErrors['password'],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Login button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: loading ? null : handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF223a66),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: loading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Đăng nhập',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Register link
                  TextButton(
                    onPressed: () {
                      // TODO: Navigate to register page
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Trang đăng ký đang phát triển')),
                      );
                    },
                    child: const Text('Chưa có tài khoản? Đăng ký ngay'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    phoneCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }
}
