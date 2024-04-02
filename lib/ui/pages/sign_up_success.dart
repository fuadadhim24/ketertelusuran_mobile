import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketertelusuran_mobile/shared/theme.dart';
import 'package:ketertelusuran_mobile/ui/widgets/buttons.dart';

class SignUpSuccessPage extends StatefulWidget {
  const SignUpSuccessPage({Key? key}) : super(key: key);

  @override
  _SignUpSuccessPageState createState() => _SignUpSuccessPageState();
}

class _SignUpSuccessPageState extends State<SignUpSuccessPage> {
  bool _showCheckmark = false;

  @override
  void initState() {
    super.initState();
    // Delaying the appearance of the checkmark for demonstration purposes
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _showCheckmark = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Akun Berhasil\nTerdaftar',
              style: BlackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: semiBold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 8,
            ),
            AnimatedOpacity(
              opacity: _showCheckmark ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),
              child: Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 64.0,
              ),
            ),
            const SizedBox(
              height: 26,
            ),
            Text(
              'Tingkatkan optimalisasi ketertelusuran\nanda bersama kami',
              style: greenTextStyle.copyWith(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 50,
            ),
            CustomFilledButton(
              width: 183,
              title: 'Mulai Sekarang',
              onPressed: _showCheckmark
                  ? () {
                      _showSuccessSnackBar(context);
                      Get.off('/home');
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk menampilkan notifikasi snack bar saat berhasil Daftar
  void _showSuccessSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Berhasil Daftar! Selamat Datang'),
      duration: Duration(seconds: 2), // Durasi notifikasi
      backgroundColor: greenColor, // Warna latar belakang notifikasi
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Jari-jari border radius
      ),
      behavior: SnackBarBehavior.floating, // Snackbar akan mengambang
      margin: EdgeInsets.symmetric(
          vertical: 20, horizontal: 60), // Menerapkan margin
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar); // Menampilkan notifikasi
  }
}
