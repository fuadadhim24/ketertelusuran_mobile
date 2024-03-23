import 'package:flutter/material.dart';
import 'package:ketertelusuran_mobile/shared/theme.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteContainerColor,
      body: Center(
        child: Container(
          height: 50,
          width: 51.56,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/ic_logo_1.png',
              )
            )
          ),
        ),
      ),
    );
  }
}