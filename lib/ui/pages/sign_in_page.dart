import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketertelusuran_mobile/shared/global.dart';
import 'package:ketertelusuran_mobile/shared/theme.dart';
import 'package:ketertelusuran_mobile/ui/pages/home_page.dart';
import 'package:ketertelusuran_mobile/ui/pages/sign_up_page.dart';
import 'package:ketertelusuran_mobile/ui/widgets/buttons.dart';
import 'package:ketertelusuran_mobile/ui/widgets/forms.dart';
import 'package:http/http.dart' as http;

class SignInPage extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  SignInPage({Key? key});

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
                      Get.toNamed('/lupa-password');
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
                      _showSuccessSnackBar(context);
                      signIn();
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
              Get.toNamed(
                '/sign-up',
              );
            },
          ),
        ],
      ),
    );
  }

  // Fungsi untuk menampilkan notifikasi snack bar saat berhasil login
  void _showSuccessSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Berhasil Masuk!'),
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

  void signIn() async{
    String url = Global.serverUrl+Global.mobile+Global.signInPath;

    final Map<String, dynamic> queryParams = {
      "email" : _emailController,
      "password" : _passwordController,
    };

    try{
      http.Response response = await http.post(Uri.parse(url).replace(queryParameters: queryParams));
      if(response.statusCode == 200){
        var user = jsonDecode(response.body); //return type list<map>
        debugPrint(response.body);
      }else{
        debugPrint("Invalid email or password");
      }
    }catch(error){
      debugPrint('Gagal');
    }
  }
}
