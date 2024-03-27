import 'package:flutter/material.dart';
import 'package:ketertelusuran_mobile/shared/theme.dart';
import 'package:ketertelusuran_mobile/ui/pages/home_page.dart';
import 'package:ketertelusuran_mobile/ui/pages/sign_up_page.dart';
import 'package:ketertelusuran_mobile/ui/widgets/buttons.dart';
import 'package:ketertelusuran_mobile/ui/widgets/forms.dart';
import 'package:page_transition/page_transition.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: whiteBackgroundColor,
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
            height: 30,
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
                // NOTE: EMAIL INPUT
                CustomFormField(
                  title: 'Alamat Email',
                  typeFormField: 0,
                  controller: emailController,
                ),
                const SizedBox(
                  height: 16,
                ),
                // NOTE: PASSWORD INPUT
                CustomFormField(
                  title: 'Password',
                  obscureText: true,
                  typeFormField: 1,
                  controller: passwordController,
                ),
                const SizedBox(
                  height: 8,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Lupa Password?',
                    style: greenTextStyle,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomFilledButton(
                  title: 'Masuk',
                  onPressed: () {
                    if (emailController.text.isEmpty &&
                        passwordController.text.isEmpty) {
                      _showWarningSnackBar(
                          context, 'Password dan alamat email belum terisi');
                    } else if (emailController.text.isEmpty) {
                      _showWarningSnackBar(context, 'Alamat email belum terisi');
                    } else if (passwordController.text.isEmpty) {
                      _showWarningSnackBar(context, 'Password belum terisi');
                    } else {
                      _showSuccessSnackBar(context);
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          duration: const Duration(milliseconds: 500),
                          child: HomePage(),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          CustomTextButton(
            title: 'Buat Akun Baru',
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  duration: const Duration(milliseconds: 500),
                  child: SignUpPage(),
                ),
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
}
