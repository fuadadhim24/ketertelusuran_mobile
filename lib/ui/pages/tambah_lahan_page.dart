import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketertelusuran_mobile/shared/theme.dart';
import 'package:ketertelusuran_mobile/ui/widgets/buttons.dart';
import 'package:ketertelusuran_mobile/ui/widgets/forms.dart';
import 'package:ketertelusuran_mobile/ui/widgets/map.dart';
import 'package:ketertelusuran_mobile/ui/widgets/searchContainer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class TambahLahanPage extends StatefulWidget {
  const TambahLahanPage({super.key});

  @override
  State<TambahLahanPage> createState() => _TambahLahanPage();
}

class _TambahLahanPage extends State<TambahLahanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 88,
        centerTitle: true,
        title: Text(
          'Tambah Lahan',
          style: BlackTextStyle.copyWith(
            fontWeight: semiBold,
            fontSize: 20,
          ),
        ),
      ),
      body: SlidingUpPanel(
        minHeight: MediaQuery.of(context).size.height / 3,
        maxHeight: MediaQuery.of(context).size.height,
        panel: Container(
          child: Column(
            children: [
              buildHeadingKetertelusuran(),
              Positioned(
                child: Container(
                  width: 111,
                  height: 101,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: whiteContainerColor,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: whiteContainerColor,
                      borderRadius: BorderRadius.circular(13),
                      border: Border.all(
                        width: 1,
                        color: greenColor,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/ic_lahan_big.png',
                          height: 52,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              buildInputLahan(),
            ],
          ),
        ),
        body: buildMapPanel(),
      ),
    );
  }

  Widget buildHeadingKetertelusuran() {
    return Container(
      padding: const EdgeInsets.only(
        top: 17,
        bottom: 5,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 14,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 21,
                    ),
                    Text(
                      'Pilih Lokasi Lahan',
                      style: BlackTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Tekan pada map untuk menentukan titik lokasi',
                      style: BlackTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 35,
          ),
        ],
      ),
    );
  }

  Widget buildMapPanel() {
    return Container(
      child: MapGoogle(),
    );
  }

  Widget buildInputLahan() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
      ),
      child: Column(
        children: [
          CustomFormField(title: 'Nama Lahan', typeFormField: 0),
          const SizedBox(
            height: 36,
          ),
          CustomFormField(title: 'Detail Lokasi', typeFormField: 0),
          const SizedBox(
            height: 36,
          ),
          CustomFormField(title: 'Luas', typeFormField: 0),
          const SizedBox(
            height: 36,
          ),
          CustomFormField(title: 'Jenis Tanah', typeFormField: 0),
          const SizedBox(
            height: 36,
          ),
          CustomFilledButton(
            title: 'Submit',
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
