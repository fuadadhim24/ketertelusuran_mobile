import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketertelusuran_mobile/shared/theme.dart';
import 'package:ketertelusuran_mobile/ui/pages/home_page.dart';
import 'package:ketertelusuran_mobile/ui/pages/sign_up_page.dart';
import 'package:ketertelusuran_mobile/ui/widgets/buttons.dart';
import 'package:ketertelusuran_mobile/ui/widgets/forms.dart';

class PasswordBaruPage extends StatelessWidget {
  const PasswordBaruPage({Key? key});

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordBaruController = TextEditingController();
    TextEditingController verifikasiPasswordBaruController =
        TextEditingController();

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
              'Buat Password Baru',
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
                // NOTE: PASSWORD BARU INPUT
                CustomFormField(
                  title: 'Password Baru',
                  typeFormField: 0,
                  controller: passwordBaruController,
                ),
                const SizedBox(
                  height: 36,
                ),
                // NOTE: VERIFIKASI PASSWORD BARU INPUT
                CustomFormField(
                  title: 'Verifikasi Password Baru',
                  obscureText: true,
                  typeFormField: 1,
                  controller: verifikasiPasswordBaruController,
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
                    String passwordBaru = passwordBaruController.text;
                    String verifikasiPasswordBaru =
                        verifikasiPasswordBaruController.text;

                    if (passwordBaru.isEmpty && verifikasiPasswordBaru.isEmpty) {
                      _showWarningSnackBar(context, 'Password Baru dan Verifikasi Password Baru belum terisi.');
                    } else if (passwordBaru.isEmpty) {
                      _showWarningSnackBar(context, 'Password Baru belum terisi.');
                    } else if (verifikasiPasswordBaru.isEmpty) {
                      _showWarningSnackBar(context, 'Verifikasi Password Baru belum terisi.');
                    } else if (passwordBaru != verifikasiPasswordBaru) {
                      _showWarningSnackBar(context, 'Password Baru dan Verifikasi Password Baru harus sama.');
                    } else {
                      _showSuccessSnackBar(context);
                      Get.toNamed('/sign-in');
                    }
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                CustomTextButton(
                  title: 'Kembali ke Halaman Login',
                  onPressed: () {
                    Get.toNamed('/sign-in');
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
      content: Text('Berhasil Membuat Password Baru! Silahkan Login Kembali'),
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
}
