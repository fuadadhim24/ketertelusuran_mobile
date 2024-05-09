import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:get/get.dart';
import 'package:ketertelusuran_mobile/shared/theme.dart';
import 'package:ketertelusuran_mobile/ui/widgets/buttons.dart';
import 'package:ketertelusuran_mobile/ui/widgets/forms.dart';
import 'package:ketertelusuran_mobile/ui/widgets/mapPicker.dart';

class FlutterSlidingUpPanel extends StatefulWidget {
  final String title;
  final VoidCallback onSetting;
  const FlutterSlidingUpPanel(
      {super.key, required this.title, required this.onSetting});

  @override
  State<FlutterSlidingUpPanel> createState() => _FlutterSlidingUpPanelState();
}

class _FlutterSlidingUpPanelState extends State<FlutterSlidingUpPanel> {
  late ScrollController scrollController;

  ///The controller of sliding up panel
  SlidingUpPanelController panelController = SlidingUpPanelController();

  double minBound = 0;

  double upperBound = 1.0;

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        panelController.expand();
      } else if (scrollController.offset <=
              scrollController.position.minScrollExtent &&
          !scrollController.position.outOfRange) {
        panelController.anchor();
      } else {}
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  widget.onSetting.call();
                },
              )
            ],
          ),
          // body: buildMapPanel(),
          body: Container(
            child: Center(
              child: Text('content'),
            ),
          ),
        ),
        SlidingUpPanelWidget(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            decoration: ShapeDecoration(
              color: Colors.white,
              shadows: [
                BoxShadow(
                  blurRadius: 5.0,
                  spreadRadius: 2.0,
                  color: const Color(0x11000000),
                )
              ],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 5),
                  child: Text('Form Detail Lahan. Klik atau geser ke atas'),
                ),
                buildHeadingKetertelusuran(),
                SizedBox(height: 18),
                // Bagian yang sebelumnya di dalam Positioned
                Container(
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
                SizedBox(height: 18),
                buildInputLahan(),
              ],
            ),
          ),
          controlHeight: 50.0,
          anchor: 0.4,
          minimumBound: minBound,
          upperBound: upperBound,
          panelController: panelController,
          onTap: () {
            ///Customize the processing logic
            if (SlidingUpPanelStatus.expanded == panelController.status) {
              panelController.collapse();
            } else {
              panelController.expand();
            }
          },
          enableOnTap: true, // Enable the onTap callback for control bar.
          dragDown: (details) {
            print('dragDown');
          },
          dragStart: (details) {
            print('dragStart');
          },
          dragCancel: () {
            print('dragCancel');
          },
          dragUpdate: (details) {
            print(
              'dragUpdate,${panelController.status == SlidingUpPanelStatus.dragging ? 'dragging' : ''}',
            );
          },
          dragEnd: (details) {
            print('dragEnd');
          },
        ),
      ],
    );
  }
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

Widget buildMapPanel() {
  return Container(
    child: MapPicker(),
  );
}
