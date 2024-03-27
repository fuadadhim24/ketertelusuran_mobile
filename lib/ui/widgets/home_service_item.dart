import 'package:flutter/material.dart';
import 'package:ketertelusuran_mobile/shared/theme.dart';

class CustomHomeService extends StatelessWidget {
  final String title;
  final String iconUrl;
  final VoidCallback? onTap;

  const CustomHomeService({
    super.key,
    required this.title,
    required this.iconUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
        child: Container(
          width: (MediaQuery.of(context).size.width - 40) / 3,
          height: 101,
          decoration: BoxDecoration(
            color: whiteContainerColor,
            borderRadius: BorderRadius.circular(13),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                iconUrl,
                width: 52,
                height: 52,
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                title,
                style: BlackTextStyle.copyWith(
                  fontWeight: semiBold,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
    );
  }
}
