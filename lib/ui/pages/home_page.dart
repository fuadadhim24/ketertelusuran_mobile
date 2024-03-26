import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ketertelusuran_mobile/shared/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBackgroundColor,
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
        ),
        children: [
          buildHomeHeading(),
          buildCultivation(),
          buildServices(context),
          buildNotes(),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget buildHomeHeading() {
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
                    image: AssetImage('assets/ic_menu.png'),
                  ),
                ),
              ),
              Text(
                'Sawah A',
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

  Widget buildCultivation() {
    return Container(
      margin: EdgeInsets.only(
        top: 36,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 199,
                  decoration: BoxDecoration(
                    color: whiteContainerColor,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sumbersari, Jember',
                        style: BlackTextStyle.copyWith(
                          fontSize: 15,
                          fontWeight: semiBold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Container(
                        width: 63,
                        height: 63,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: yellowColor,
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        '37°',
                        style: BlackTextStyle.copyWith(
                          fontSize: 32,
                          fontWeight: semiBold,
                        ),
                      ),
                      Text(
                        'Terang Benderang',
                        style: BlackTextStyle.copyWith(
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 94,
                      decoration: BoxDecoration(
                        color: whiteContainerColor,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Fase Budidaya',
                            style: BlackTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: semiBold,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Penanaman',
                            style: BlackTextStyle.copyWith(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 94,
                      decoration: BoxDecoration(
                        color: whiteContainerColor,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Suhu',
                            style: BlackTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: semiBold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '17°',
                                style: BlackTextStyle.copyWith(
                                  fontSize: 36,
                                  fontWeight: semiBold,
                                ),
                              ),
                              Text(
                                'celcius',
                                style: BlackTextStyle.copyWith(
                                  fontSize: 12,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 86,
            width: double.infinity,
            decoration: BoxDecoration(
              color: whiteContainerColor,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Waspada Terhadap Ilalang',
                  style: BlackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Rekomendasi bersihkan 1/2 bulan sekali',
                  style: BlackTextStyle.copyWith(
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildServices(context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Fitur',
            style: BlackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
          Text(
            'Manajemen',
            style: BlackTextStyle.copyWith(
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: (MediaQuery.of(context).size.width - 40) / 3,
                height: 101,
                decoration: BoxDecoration(
                  color: whiteContainerColor,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/ic_varietas.png',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      'Varietas Padi',
                      style: BlackTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: (MediaQuery.of(context).size.width - 40) / 3,
                height: 101,
                decoration: BoxDecoration(
                  color: whiteContainerColor,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/ic_grade.png',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      'Grade',
                      style: BlackTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: (MediaQuery.of(context).size.width - 40) / 3,
                height: 101,
                decoration: BoxDecoration(
                  color: whiteContainerColor,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/ic_ketertelusuran.png',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      'Ketertelusuran',
                      style: BlackTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildNotes() {
    return Container(
      margin: const EdgeInsets.only(
        top: 50,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ketertelusuran Beras Anda',
                    style: BlackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    'Pencatatan',
                    style: BlackTextStyle.copyWith(
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              Container(
                width: 94,
                height: 22,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: whiteContainerColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 13,
                      height: 13,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/ic_fire.png'),
                        ),
                      ),
                    ),
                    Text(
                      'Berlangsung',
                      style: BlackTextStyle.copyWith(
                        fontSize: 10,
                        fontWeight: semiBold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 12,
            ),
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: 189),
            decoration: BoxDecoration(
              color: whiteContainerColor,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Jadwal Anda',
                      style: BlackTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                    Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/ic_add_circle.png',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            right: 5,
                          ),
                          width: 24,
                          height: 24,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/ic_fase.png',
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Fase Penanaman',
                          style: BlackTextStyle.copyWith(
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            right: 5,
                          ),
                          width: 24,
                          height: 24,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/ic_date.png',
                              ),
                            ),
                          ),
                        ),
                        Text(
                          '10 hari',
                          style: BlackTextStyle.copyWith(
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    // Row(
                    //   children: [
                    //     Container(
                    //       margin: const EdgeInsets.only(
                    //         right: 5,
                    //       ),
                    //       width: 24,
                    //       height: 24,
                    //       decoration: const BoxDecoration(
                    //         image: DecorationImage(
                    //           image: AssetImage(
                    //             'assets/ic_forward.png',
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     Text(
                    //       '-21 h fase berikutnya',
                    //       style: BlackTextStyle.copyWith(
                    //         fontSize: 11,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Hari Ini',
                  style: BlackTextStyle.copyWith(
                    fontWeight: semiBold,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 36,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: whiteBackgroundColor,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Bersih ilalang',
                            style: BlackTextStyle.copyWith(
                              fontWeight: semiBold,
                              fontSize: 11,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '10.30',
                            style: BlackTextStyle.copyWith(
                              fontWeight: semiBold,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Edit',
                        style: BlackTextStyle.copyWith(
                          fontWeight: semiBold,
                          fontSize: 11,
                          color: RedColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 36,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: whiteBackgroundColor,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Bersih ilalang',
                            style: BlackTextStyle.copyWith(
                              fontWeight: semiBold,
                              fontSize: 11,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '10.30',
                            style: BlackTextStyle.copyWith(
                              fontWeight: semiBold,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Edit',
                        style: BlackTextStyle.copyWith(
                          fontWeight: semiBold,
                          fontSize: 11,
                          color: RedColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
