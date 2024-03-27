import 'package:flutter/material.dart';
import 'package:ketertelusuran_mobile/shared/theme.dart';

class GradePage extends StatelessWidget {
  const GradePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBackgroundColor,
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
        ),
        children: [
          buildGradeHeading(),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

   Widget buildGradeHeading() {
    return Container(
      margin: const EdgeInsets.only(
        top: 64,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 24,
                width: 24,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/ic_back.png'),
                  ),
                ),
              ),
              Text(
                'Grade',
                textAlign: TextAlign.center,
                style: BlackTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: semiBold,
                ),
              ),
              Container(
                height: 24,
                width: 24,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/ic_notification.png',
                    ),
                  ),
                ),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: 11,
                    height: 11,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: RedColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildFormContent(){
    return Container(
      margin: const EdgeInsets.only(
        top: 36,
      ),
      child: Column(
        children: [

        ],
      ),
    );
  }
}
