import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketertelusuran_mobile/shared/theme.dart';
import 'package:ketertelusuran_mobile/ui/pages/detail_pengolahan.dart';
import 'package:ketertelusuran_mobile/ui/pages/grade_page.dart';
import 'package:ketertelusuran_mobile/ui/pages/home_page.dart';
import 'package:ketertelusuran_mobile/ui/pages/ketertelusuran.dart';
import 'package:ketertelusuran_mobile/ui/pages/password_baru.dart';
import 'package:ketertelusuran_mobile/ui/pages/read_more.dart';
import 'package:ketertelusuran_mobile/ui/pages/sign_in_page.dart';
import 'package:ketertelusuran_mobile/ui/pages/onboarding_page.dart';
import 'package:ketertelusuran_mobile/ui/pages/sign_up_page.dart';
import 'package:ketertelusuran_mobile/ui/pages/sign_up_set_ktp_page.dart';
import 'package:ketertelusuran_mobile/ui/pages/sign_up_set_profile_page.dart';
import 'package:ketertelusuran_mobile/ui/pages/sign_up_success.dart';
import 'package:ketertelusuran_mobile/ui/pages/splash_page.dart';
import 'package:ketertelusuran_mobile/ui/pages/varietas_padi_page.dart';
import 'package:ketertelusuran_mobile/ui/pages/lupa_password.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const SplashPage()),
        GetPage(name: '/onboarding', page: () => const OnBoardingPage()),
        GetPage(name: '/sign-in', page: () => const SignInPage()),
        GetPage(name: '/sign-up', page: () => const SignUpPage()),
        GetPage(name: '/sign-up-set-profile', page: () => const SignUpSetProfilePage()),
        GetPage(name: '/sign-up-set-ktp', page: () => const SignUpSetKtpPage()),
        GetPage(name: '/sign-up-success', page: () => const SignUpSuccessPage()),
        GetPage(name: '/home', page: () => const HomePage()),
        GetPage(name: '/grade', page: () => const GradePage()),
        GetPage(name: '/ketertelusuran', page: () => const KetertelusuranPage()),
        GetPage(name: '/varietas-padi', page: () => const VarietasPadiPage()),
        GetPage(name: '/lupa-password', page: () => const LupaPasswordPage()),
        GetPage(name: '/password-baru', page:() => const PasswordBaruPage()),
        GetPage(name: '/read-more', page:() => const ReadMorePage()),
      ],
    );
  }
}
