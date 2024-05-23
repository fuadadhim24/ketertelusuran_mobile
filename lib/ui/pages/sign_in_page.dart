import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getX;
import 'package:ketertelusuran_mobile/services/auth.dart';
import 'package:ketertelusuran_mobile/shared/global.dart';
import 'package:ketertelusuran_mobile/shared/theme.dart';
import 'package:ketertelusuran_mobile/ui/pages/home_page.dart';
import 'package:ketertelusuran_mobile/ui/pages/sign_up_page.dart';
import 'package:ketertelusuran_mobile/ui/widgets/buttons.dart';
import 'package:ketertelusuran_mobile/ui/widgets/forms.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ketertelusuran_mobile/services/auth.dart';

class SignInPage extends StatefulWidget {
  static String? idUser;
  SignInPage({Key? key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with SingleTickerProviderStateMixin {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final dio = Dio();
  List<dynamic> userList = [];

  late AnimationController _animationController;
  late Animation<Color?> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Auth authOption = Auth();
    authOption.endSession();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500), // Durasi animasi
    );
    _animation = ColorTween(begin: Colors.white, end: Colors.black)
        .animate(_animationController)
      ..addListener(() {
        setState(
            () {}); // Untuk membangunkan tampilan ketika nilai animasi berubah
      });
  }

  void dispose() {
    _animationController.dispose();
    super.dispose();
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
              bottom: 100,
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
            'Masuk &\nTingkatkan Pelayanan Kamu\nLebih Baik',
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
                // NOTE: EMAIL INPUT
                CustomFormField(
                  title: 'Alamat Email',
                  typeFormField: 0,
                  controller: _emailController,
                ),
                const SizedBox(
                  height: 36,
                ),
                // NOTE: PASSWORD INPUT
                CustomFormField(
                  title: 'Password',
                  obscureText: true,
                  typeFormField: 1,
                  controller: _passwordController,
                ),
                const SizedBox(
                  height: 16,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      getX.Get.toNamed('/lupa-password');
                    },
                    child: Text(
                      'Lupa Password?',
                      style: greenTextStyle,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 24,
                ),
                CustomFilledButton(
                  title: 'Masuk',
                  onPressed: () {
                    if (_emailController.text.isEmpty &&
                        _passwordController.text.isEmpty) {
                      _showWarningSnackBar(
                          context, 'Alamat Email dan Password belum terisi');
                    } else if (_emailController.text.isEmpty) {
                      _showWarningSnackBar(
                          context, 'Alamat Email belum terisi');
                    } else if (_passwordController.text.isEmpty) {
                      _showWarningSnackBar(context, 'Password belum terisi');
                    } else {
                      signIn(
                        context,
                        _emailController.text.toString(),
                        _passwordController.text.toString(),
                      );
                      // Get.toNamed(
                      //   '/home',
                      // );
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
            title: 'Buat Akun Baru',
            onPressed: () {
              getX.Get.toNamed(
                '/sign-up',
              );
            },
          ),
        ],
      ),
    );
  }

  // Fungsi untuk menampilkan notifikasi snack bar saat berhasil
  void _showSuccessSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(Icons.check,
              color: _animation.value), // Ikon centang dengan animasi warna
          SizedBox(width: 10),
          Text(
            'Berhasil Masuk!',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      duration: Duration(seconds: 2),
      backgroundColor: greenColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Fungsi untuk menampilkan notifikasi snack bar peringatan jika alamat email atau password kosong
  void _showWarningSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2), // Durasi notifikasi
      backgroundColor: Colors.red, // Warna latar belakang notifikasi
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

  void signIn(context, String email, password) async {
    final url = Global.serverUrl + Global.signInPath;
    final finalUrl = url + '?email=' + email + '&password=' + password;
    Response response;
    response = await dio.get(finalUrl);
    final body = response.data;
    var stringResponse = body.toString();
    var responseData = stringResponse.replaceAll('{', '').replaceAll('}', '');
    if (response.statusCode == 200) {
      if (body.containsKey('data')) {
        saveSession(email);
        userList = body['data'];
        String id = userList[0]['id'];
        SignInPage.idUser = id;
        _showSuccessSnackBar(context);
        getX.Get.offNamed('/home');
      } else {
        _showWarningSnackBar(context, responseData);
      }
    } else {
      _showWarningSnackBar(context, responseData);
    }
  }

  saveSession(String email) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("email", email);
    await pref.setBool("is_signIn", true);
  }
}
