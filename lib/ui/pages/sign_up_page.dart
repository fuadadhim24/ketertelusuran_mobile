import 'package:flutter/material.dart';
import 'package:ketertelusuran_mobile/shared/theme.dart';
import 'package:ketertelusuran_mobile/ui/widgets/buttons.dart';
import 'package:ketertelusuran_mobile/ui/widgets/forms.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController fullNameController = TextEditingController();
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
                // NOTE: Nama INPUT
                CustomFormField(
                  title: 'Nama Lengkap',
                  typeFormField: 0,
                  controller: fullNameController,
                ),
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
                  height: 30,
                ),
                CustomFilledButton(
                  title: 'Berikutnya',
                  onPressed: () {
                    if (fullNameController.text.isEmpty &&
                        emailController.text.isEmpty &&
                        passwordController.text.isEmpty) {
                      _showWarningSnackBar(context,
                          'Nama lengkap, alamat email, dan password belum terisi');
                    } else if (fullNameController.text.isEmpty &&
                        emailController.text.isEmpty) {
                      _showWarningSnackBar(
                          context, 'Nama lengkap dan alamat email belum terisi');
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
                    } else {
                      Navigator.pushNamed(context, '/sign-up-set-profile');
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
            title: 'Masuk',
            onPressed: () {
              Navigator.pushNamed(context, '/sign-in');
            },
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
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
}
