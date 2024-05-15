import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketertelusuran_mobile/shared/theme.dart';
import 'package:ketertelusuran_mobile/ui/widgets/buttons.dart';
import 'package:ketertelusuran_mobile/ui/widgets/forms.dart';
import 'package:ketertelusuran_mobile/ui/widgets/dropDownForm.dart';

class PanenPage extends StatelessWidget {
  const PanenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 88,
        centerTitle: true,
        title: Text(
          'Panen',
          style: BlackTextStyle.copyWith(
            fontSize: 20,
            fontWeight: semiBold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
        ),
        children: [
          buildFormContent(context),
        ],
      ),
    );
  }

  Widget buildFormContent(context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 36,
      ),
      width: double.infinity,
      height: 739,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: 50,
            child: Container(
              width: MediaQuery.of(context).size.width - 14,
              height: MediaQuery.of(context).size.height - 50,
              decoration: BoxDecoration(
                color: whiteContainerColor.withOpacity(0.6),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  buildHeadingContent(),
                  buildMainContent(context),
                ],
              ),
            ),
          ),
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
                      'assets/ic_grade.png',
                      height: 42,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHeadingContent() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 100,
            height: 24,
            decoration: BoxDecoration(
              color: greenColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/ic_grade_varietas.png',
                  width: 12,
                  height: 12,
                ),
                const SizedBox(
                  width: 9,
                ),
                Text(
                  'Ciherang',
                  style: WhiteTextStyle.copyWith(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 100,
            height: 24,
            decoration: BoxDecoration(
              color: greenColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/ic_time.png',
                  width: 12,
                  height: 12,
                ),
                const SizedBox(
                  width: 9,
                ),
                Text(
                  '120 hari',
                  style: WhiteTextStyle.copyWith(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMainContent(context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Text(
            'Data ketertelusuran',
            style: BlackTextStyle.copyWith(
              fontSize: 10,
              fontWeight: semiBold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            'Lahan A',
            style: BlackTextStyle.copyWith(
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 42,
          ),
          const CustomDropDownFormField(),
          const SizedBox(
            height: 36,
          ),
          const CustomFormField(
            title: 'Nama Perawatan',
            typeFormField: 0,
          ),
          const SizedBox(
            height: 36,
          ),
          const CustomFormField(
            title: 'Jumlah',
            typeFormField: 0,
          ),
          const SizedBox(
            height: 36,
          ),
          const CustomFormField(
            title: 'Kebutuhan',
            typeFormField: 0,
          ),
          const SizedBox(
            height: 36,
          ),
          CustomDatePicker(title: 'Tanggal Perlakuan'),
          const SizedBox(
            height: 18,
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
