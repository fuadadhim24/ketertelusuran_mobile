import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketertelusuran_mobile/shared/theme.dart';
import 'package:ketertelusuran_mobile/ui/pages/home_page.dart';
import 'package:ketertelusuran_mobile/ui/pages/sign_up_page.dart';
import 'package:ketertelusuran_mobile/ui/widgets/buttons.dart';
import 'package:ketertelusuran_mobile/ui/widgets/forms.dart';

class LupaPasswordPage extends StatelessWidget {
  const LupaPasswordPage({Key? key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

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
          Center( // Menggunakan Center untuk posisi teks di tengah
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
                      _showVerificationSnackbar(context, emailController, passwordController);
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
                  controller: passwordController,
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
                        passwordController.text.isEmpty) {
                      _showWarningSnackBar(context,
                          'Alamat Email dan Kode Verifikasi Email belum terisi');
                    } else if (emailController.text.isEmpty) {
                      _showWarningSnackBar(
                          context, 'Alamat Email belum terisi');
                    } else if (passwordController.text.isEmpty) {
                      _showWarningSnackBar(context,
                          'Harap Isi Kode Verifikasi Email terlebih dahulu');
                    } else {
                      _showSuccessSnackBar(context);
                      Get.toNamed(
                        '/password-baru',
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                CustomTextButton(
                  title: 'Kembali ke Halaman Login',
                  onPressed: () {
                    Get.toNamed(
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
  void _showSuccessSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Berhasil Verifikasi Email, Silahkan Buat Password Baru!'),
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
      BuildContext context, TextEditingController emailController, TextEditingController passwordController) {
    if (emailController.text.isEmpty) {
      _showWarningSnackBar(
          context, 'Harap isi Alamat Email Anda terlebih dahulu');
    } else {
      final snackBar = SnackBar(
        content: Text('Kode Verifikasi Email telah dikirim ke Gmail Anda!'),
        duration: Duration(seconds: 5), // Durasi notifikasi
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
      passwordController.clear(); // Menghapus teks pada kotak kode verifikasi email
    }
  }
}