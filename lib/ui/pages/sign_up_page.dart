import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketertelusuran_mobile/shared/global.dart';
import 'package:ketertelusuran_mobile/shared/theme.dart';
import 'package:ketertelusuran_mobile/ui/widgets/buttons.dart';
import 'package:ketertelusuran_mobile/ui/widgets/forms.dart';
import 'package:dio/dio.dart' as dioP;

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
  final dio = dioP.Dio();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    // createusers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        children: [
          Container(
            width: 155,
            height: 50,
            margin: const EdgeInsets.only(
              top: 100,
              bottom: 65,
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/ic_logo_2.png',
                ),
              ),
            ),
          ),
          Text(
            'Bergabung untuk\nMeningkatkan Pelayanan\nLebih Baik',
            style: BlackTextStyle.copyWith(
              fontSize: 20,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(
            height: 52,
          ),
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: whiteContainerColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 16,
                ),
                // NOTE: Nama INPUT
                CustomFormField(
                  title: 'Nama Lengkap',
                  typeFormField: 0,
                  controller: fullNameController,
                ),
                const SizedBox(
                  height: 36,
                ),
                // NOTE: EMAIL INPUT
                CustomFormField(
                  title: 'Alamat Email',
                  typeFormField: 0,
                  controller: emailController,
                ),
                const SizedBox(
                  height: 36,
                ),
                // NOTE: PASSWORD INPUT
                CustomFormField(
                  title: 'Password',
                  obscureText: true,
                  typeFormField: 1,
                  controller: passwordController,
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomFilledButton(
                  title: 'Sign Up',
                  onPressed: () {
                    if (fullNameController.text.isEmpty &&
                        emailController.text.isEmpty &&
                        passwordController.text.isEmpty) {
                      _showWarningSnackBar(context,
                          'Nama lengkap, alamat email, dan password belum terisi');
                    } else if (fullNameController.text.isEmpty &&
                        emailController.text.isEmpty) {
                      _showWarningSnackBar(context,
                          'Nama lengkap dan alamat email belum terisi');
                    } else if (fullNameController.text.isEmpty &&
                        passwordController.text.isEmpty) {
                      _showWarningSnackBar(
                          context, 'Nama lengkap dan password belum terisi');
                    } else if (emailController.text.isEmpty &&
                        passwordController.text.isEmpty) {
                      _showWarningSnackBar(
                          context, 'Alamat email dan password belum terisi');
                    } else if (fullNameController.text.isEmpty) {
                      _showWarningSnackBar(
                          context, 'Nama lengkap belum terisi');
                    } else if (emailController.text.isEmpty) {
                      _showWarningSnackBar(
                          context, 'Alamat email belum terisi');
                    } else if (passwordController.text.isEmpty) {
                      _showWarningSnackBar(context, 'Password belum terisi');
                    } else if (!_validateEmail(emailController.text)) {
                      _showWarningSnackBar(context,
                          'Alamat email harus berakhir dengan @gmail.com');
                    } else if (!_validatePassword(passwordController.text)) {
                      _showWarningSnackBar(context,
                          'Password harus terdiri dari kombinasi huruf dan angka dengan panjang minimal 6 karakter');
                    } else {
                      createUsers(fullNameController.text, emailController.text,
                          passwordController.text);
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          CustomTextButton(
            title: 'Kembali ke Halaman Login',
            onPressed: () {
              Get.offNamed('/sign-in');
            },
          ),
          const SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }

  // Fungsi untuk memvalidasi email
  bool _validateEmail(String email) {
    return email.endsWith('@gmail.com');
  }

  // Fungsi untuk memvalidasi password
  bool _validatePassword(String password) {
    final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,99}$');
    return passwordRegex.hasMatch(password);
  }

  // Fungsi untuk menampilkan notifikasi snack bar peringatan
  void _showWarningSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showSuccessSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2), // Durasi notifikasi
      backgroundColor: greenColor, // Warna latar belakang notifikasi
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Jari-jari border radius
      ),
      behavior: SnackBarBehavior.floating, // Snackbar akan mengambang
      margin: EdgeInsets.symmetric(
          vertical: 20, horizontal: 60), // Menerapkan margin
    );
    ScaffoldMessenger.of(context)
        .showSnackBar(snackBar); // Menampilkan notifikasi
  }

  void createUsers(name, email, password) async {
    final url = Global.serverUrl + Global.signUpPath;
    final headers = {'Content-Type': 'application/json'};
    final data = {"name": name, "email": email, "password": password};
    try {
      final response = await dioP.Dio().post(
        url,
        data: jsonEncode(data),
        options: dioP.Options(headers: headers),
      );

      debugPrint(response.toString());

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData.containsKey('success')) {
          _showSuccessSnackBar(context, 'Akun berhasil dibuat!');
          Get.offNamed('/sign-up-success');
        } else {
          _showWarningSnackBar(context, responseData);
        }
      } else {
        _showWarningSnackBar(context, 'Gagal Membuat Akun!');
      }
    } catch (e) {
      _showWarningSnackBar(context, 'Error $e');
    }
  }
}
