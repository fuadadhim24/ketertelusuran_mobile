import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketertelusuran_mobile/shared/global.dart';
import 'package:ketertelusuran_mobile/shared/theme.dart';
import 'package:ketertelusuran_mobile/ui/pages/home_page.dart';
import 'package:ketertelusuran_mobile/ui/pages/password_baru.dart';
import 'package:ketertelusuran_mobile/ui/pages/sign_up_page.dart';
import 'package:ketertelusuran_mobile/ui/widgets/buttons.dart';
import 'package:ketertelusuran_mobile/ui/widgets/forms.dart';

class LupaPasswordPage extends StatelessWidget {
  const LupaPasswordPage({Key? key});

  @override
  Widget build(BuildContext context) {
    EmailOTP myAuth = EmailOTP();
    TextEditingController emailController = TextEditingController();
    TextEditingController otpController = TextEditingController();

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
          Center(
            // Menggunakan Center untuk posisi teks di tengah
            child: Text(
              'Lupa Password',
              style: BlackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: semiBold,
              ),
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
                  controller: emailController,
                ),
                const SizedBox(
                  height: 36,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      _showVerificationSnackbar(
                          context, emailController, otpController, myAuth);
                    },
                    child: Text(
                      'Verifikasi Alamat Email',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          greenColor, // Warna latar belakang tombol
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10), // Jari-jari border radius
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 36,
                ),
                // NOTE: PASSWORD INPUT
                CustomFormField(
                  title: 'Kode Verifikasi Email',
                  obscureText: true,
                  typeFormField: 1,
                  controller: otpController,
                  textInputType: TextInputType.number,
                ),
                const SizedBox(
                  height: 16,
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomFilledButton(
                  title: 'Buat Password Baru',
                  onPressed: () {
                    if (emailController.text.isEmpty &&
                        otpController.text.isEmpty) {
                      _showWarningSnackBar(context,
                          'Alamat Email dan Kode Verifikasi Email belum terisi');
                    } else if (emailController.text.isEmpty) {
                      _showWarningSnackBar(
                          context, 'Alamat Email belum terisi');
                    } else if (otpController.text.isEmpty) {
                      _showWarningSnackBar(context,
                          'Harap Isi Kode Verifikasi Email terlebih dahulu');
                    } else {
                      verifikasiEmail(
                          emailController, myAuth, otpController, context);
                    }
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                CustomTextButton(
                  title: 'Kembali ke Halaman Login',
                  onPressed: () {
                    Get.offNamed(
                      '/sign-in',
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  // Fungsi untuk menampilkan notifikasi snack bar saat berhasil login
  void _showSuccessSnackBar(BuildContext context, title) {
    final snackBar = SnackBar(
      content: Text(title),
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

  // Fungsi untuk menampilkan notifikasi snack bar verifikasi email telah dikirim
  void _showVerificationSnackbar(
      BuildContext context,
      TextEditingController emailController,
      TextEditingController otpController,
      myAuth) {
    if (emailController.text.isEmpty) {
      _showWarningSnackBar(
          context, 'Harap isi Alamat Email Anda terlebih dahulu');
    } else {
      sendOtpEmail(emailController, context, myAuth);
      otpController.clear(); // Menghapus teks pada kotak kode verifikasi email
    }
  }

  Future<void> sendOtpEmail(email, context, myAuth) async {
    myAuth.setConfig(
        appEmail: "jejakpadi@gmail.com",
        appName: "JejakPadi",
        userEmail: email.text,
        otpLength: 6,
        otpType: OTPType.digitsOnly);
    myAuth.setSMTP(
        host: "smtp.gmail.com",
        auth: true,
        username: "jejakpadi@gmail.com",
        password: "dfsanyhascpgtmfu",
        secure: "TLS",
        port: 587);
    var template =
        'Terimakasih telah memilih {{app_name}}. Berikut kode OTP anda {{otp}}.';
    myAuth.setTemplate(render: template);
    if (await myAuth.sendOTP() == true) {
      _showSuccessSnackBar(context, 'OTP telah dikirimkan');
    } else {
      _showWarningSnackBar(context, 'Oops, OTP tidak berasil dikirimkan');
    }
  }

  void verifikasiEmail(email, myAuth, otp, context) async {
    if (await myAuth.verifyOTP(otp: otp.text) == true) {
    PasswordBaruPage.email = email.text;
      _showSuccessSnackBar(context, 'Berhasil memverifikasi anda');
      Get.toNamed(
        '/password-baru',
      );
      _showSuccessSnackBar(context, 'Silakan memperbarui password anda');
    } else {
      _showWarningSnackBar(context, 'Kode OTP anda masukkan salah');
    }
  }
}
