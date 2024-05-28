import 'package:flutter/foundation.dart';
import 'package:ketertelusuran_mobile/services/produksi.dart';
import 'package:ketertelusuran_mobile/ui/pages/home_page.dart';

class Fase {
  static int? currentDay = Produksi.currentDays;
  static String? currentPhaseName;

  static double? totalDurasi;
  static int totalPhase = 0;
  static String namaFase = "";
  static Map<String, List<Map<String, dynamic>>> categorizedValuesMap = {};
  static Map<String, List<Map<String, dynamic>>> currentPhase = {};
  static Future<void> readFaseChoosed() async {
    // debugPrint(HomePage.faseDanPerlakuanList.toString());
    totalDurasi = hitungTotalDurasi(HomePage.faseDanPerlakuanList);
    categorizedValuesMap = faseCategorize(HomePage.faseDanPerlakuanList);
    totalPhase = hitungTotalFase(HomePage.faseDanPerlakuanList);
    currentPhase = Fase.currentPhaseList(categorizedValuesMap, currentDay);

    namaFase = currentPhase.values.first[0]['nama_fase'];
    // debugPrint(currentPhase.toString());
    // debugPrint(totalDurasi.toString());
    // debugPrint(categorizedValuesMap.toString());
    // debugPrint(totalPhase.toString());
  }

  static double hitungTotalDurasi(List<dynamic> list) {
    Set<String> uniqueFaseNames = {};
    double totalDurasi = 0;

    list.forEach((value) {
      if (!uniqueFaseNames.contains(value['nama_fase'])) {
        double durasi = double.parse(value['durasi']);
        totalDurasi += durasi;
        uniqueFaseNames.add(value['nama_fase']);
      }
    });
    return totalDurasi;
  }

  static int hitungTotalFase(List<dynamic> list) {
    Set<String> uniqueFaseNames = {};
    int totalFase = 0;

    list.forEach((value) {
      if (!uniqueFaseNames.contains(value['nama_fase'])) {
        int dataCount = 1;
        totalFase += dataCount;
        uniqueFaseNames.add(value['nama_fase']);
      }
    });
    return totalFase;
  }

  static Map<String, List<Map<String, dynamic>>> faseCategorize(
      List<dynamic> list) {
    Map<String, List<Map<String, dynamic>>> categorizedValues = {};

    list.forEach((value) {
      String faseName = value['nama_fase'];

      if (!categorizedValues.containsKey(faseName)) {
        categorizedValues[faseName] = [];
      }

      categorizedValues[faseName]?.add(value);
    });

    return categorizedValues;
  }
  
  static Map<String, List<Map<String, dynamic>>> currentPhaseList(
      Map<String, List<Map<String, dynamic>>> phases, currentDay) {
    Map<String, List<Map<String, dynamic>>> currentPhase = {};
    int minRangePhase = 0;
    List<String> keysList = phases.keys.toList();
    int totalData = keysList.length;
    int maxRangePhase = 0;
    // debugPrint("keyList: $keysList");
    // debugPrint("totalData: $totalData");

    for (String key in keysList) {
      // debugPrint(phases[key]![0]['durasi'].toString());
      double doubleRangePhase =
          double.parse(phases[key]![0]['durasi'].toString());
      int intMaxRangePhase = doubleRangePhase.toInt();
      maxRangePhase += intMaxRangePhase;
      // debugPrint("MinRangePhase: $minRangePhase");
      if (minRangePhase < currentDay && currentDay < maxRangePhase) {
        currentPhase = {
          key: [phases[key]![0]]
        };
        // debugPrint(currentPhase.toString());
      }
      minRangePhase = intMaxRangePhase;
      // debugPrint("MaxRangePhase: $maxRangePhase");
    }
    return currentPhase;
  }
}
