import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketertelusuran_mobile/services/sessionManager.dart';
import 'package:ketertelusuran_mobile/shared/theme.dart';
import 'package:ketertelusuran_mobile/ui/pages/detail_pengolahan.dart';
import 'package:ketertelusuran_mobile/ui/pages/detail_produksi.dart';
import 'package:ketertelusuran_mobile/ui/pages/panen_page.dart';
import 'package:ketertelusuran_mobile/ui/pages/penanaman_page.dart';
import 'package:ketertelusuran_mobile/ui/pages/perawatan_page.dart';
import 'package:ketertelusuran_mobile/ui/pages/home_page.dart';
import 'package:ketertelusuran_mobile/ui/pages/analisis_spk_page.dart';
import 'package:ketertelusuran_mobile/ui/pages/notifikasi_page.dart';
import 'package:ketertelusuran_mobile/ui/pages/password_baru.dart';
import 'package:ketertelusuran_mobile/ui/pages/pilih_lokasi_page.dart';
import 'package:ketertelusuran_mobile/ui/pages/read_spk.dart';
import 'package:ketertelusuran_mobile/ui/pages/read_more.dart';
import 'package:ketertelusuran_mobile/ui/pages/riwayat_produksi.dart';
import 'package:ketertelusuran_mobile/ui/pages/sign_in_page.dart';
import 'package:ketertelusuran_mobile/ui/pages/onboarding_page.dart';
import 'package:ketertelusuran_mobile/ui/pages/sign_up_page.dart';
import 'package:ketertelusuran_mobile/ui/pages/sign_up_success.dart';
import 'package:ketertelusuran_mobile/ui/pages/splash_page.dart';
import 'package:ketertelusuran_mobile/ui/pages/tambah_lahan_page.dart';
import 'package:ketertelusuran_mobile/ui/pages/penyemaian_page.dart';
import 'package:ketertelusuran_mobile/ui/pages/varietas_padi_page.dart';
import 'package:ketertelusuran_mobile/ui/pages/lupa_password.dart';
import 'package:ketertelusuran_mobile/ui/widgets/map.dart';
import 'package:ketertelusuran_mobile/ui/pages/analisis_spk_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final String? savedEmail = await SessionManager.getEmail();

  runApp(MyApp(initialRoute: savedEmail != null ? '/home' : '/'));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      getPages: [
        GetPage(name: '/', page: () => const SplashPage()),
        GetPage(name: '/onboarding', page: () => const OnBoardingPage()),
        GetPage(name: '/sign-in', page: () => SignInPage()),
        GetPage(name: '/sign-up', page: () => const SignUpPage()),
        GetPage(
            name: '/sign-up-success', page: () => const SignUpSuccessPage()),
        GetPage(name: '/home', page: () => const HomePage()),
        GetPage(name: '/penanaman', page: () => const PenanamanPage()),
        GetPage(name: '/perawatan', page: () => const PerawatanPage()),
        GetPage(name: '/analisis-spk', page: () => const AnalisisSpkPage()),
        GetPage(name: '/varietas-padi', page: () => const VarietasPadiPage()),
        GetPage(name: '/lupa-password', page: () => const LupaPasswordPage()),
        GetPage(name: '/password-baru', page: () => const PasswordBaruPage()),
        GetPage(name: '/read-more', page: () => ReadMorePage()),
        GetPage(name: '/notifikasi', page: () => const NotifikasiPage()),
        GetPage(name: '/tambah-lahan', page: () => const TambahLahanPage()),
        GetPage(
            name: '/tambah-varietas-padi', page: () => const PenyemaianPage()),
        GetPage(
            name: '/pilih-titik-lokasi-lahan',
            page: () => const PilihLokasiPage()),
        GetPage(name: '/panen', page: () => PanenPage()),
        GetPage(
            name: '/riwayat-produksi', page: () => const RiwayatProduksiPage()),
        GetPage(
            name: '/detail-produksi', page: () => const DetailProduksiPage()),
        GetPage(name: '/read-spk', page: () => const ReadSPK()),
      ],
    );
  }
}
