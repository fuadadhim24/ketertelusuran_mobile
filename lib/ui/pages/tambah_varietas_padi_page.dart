import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketertelusuran_mobile/shared/theme.dart';
import 'package:ketertelusuran_mobile/ui/widgets/buttons.dart';
import 'package:ketertelusuran_mobile/ui/widgets/forms.dart';
import 'package:ketertelusuran_mobile/ui/widgets/map.dart';

class TambahVarietasPadiPage extends StatelessWidget {
  const TambahVarietasPadiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 88,
        centerTitle: true,
        title: Text(
          'Pembenihan',
          style: BlackTextStyle.copyWith(
            fontWeight: semiBold,
            fontSize: 20,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
        ),
        children: [
          buildMainForm(),
        ],
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

  Widget buildMainForm() {
    return Column(
      children: [
        SizedBox(
          height: 16,
        ),
        CustomStringFormField(
            title: 'Benih Varietas Padi', stringInitialValue: 'Ciherang'),
        SizedBox(
          height: 36,
        ),
        CustomFormField(title: 'Sumber Benih', typeFormField: 0),
        SizedBox(
          height: 36,
        ),
        CustomDatePicker(title: 'Tanggal Kedaluwarsa Benih'),
        SizedBox(
          height: 36,
        ),
        CustomFormField(title: 'Tingkat Kemurnian (%)', typeFormField: 0),
        SizedBox(
          height: 36,
        ),
        CustomFormField(title: 'Tingkat Vigor (%)', typeFormField: 0),
        SizedBox(
          height: 36,
        ),
        CustomFormField(title: 'Jumlah Benih', typeFormField: 0),
        SizedBox(
          height: 48,
        ),
        CustomFilledButton(
          title: 'Buat Produksi',
          onPressed: () {
            Get.offAllNamed('/home');
          },
        ),
      ],
    );
  }
}
