import 'package:flutter/foundation.dart';
import 'package:ketertelusuran_mobile/services/produksi.dart';
import 'package:ketertelusuran_mobile/ui/pages/home_page.dart';

class Fase {
  static String? currentPhaseName;

  static double? totalDurasi;
  static int totalPhase = 0;
  static String namaFase = "";
  static Map<String, List<Map<String, dynamic>>> categorizedValuesMap = {};
  static Map<String, List<Map<String, dynamic>>> currentPhase = {};
  static Future<void> readFaseChoosed(currentDays) async {
    // debugPrint(HomePage.faseDanPerlakuanList.toString());
    totalDurasi = hitungTotalDurasi(HomePage.faseDanPerlakuanList);
    categorizedValuesMap = faseCategorize(HomePage.faseDanPerlakuanList);
    totalPhase = hitungTotalFase(HomePage.faseDanPerlakuanList);
    currentPhase = Fase.currentPhaseList(categorizedValuesMap, currentDays);

    namaFase = currentPhase.values.first[0]['nama_fase'];
    // debugPrint(currentPhase.toString());
    // debugPrint(HomePage.faseDanPerlakuanList.toString());
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
    // Define the order of phases
    List<String> phaseOrder = ['Penyemaian', 'Penanaman', 'Perawatan', 'Panen'];

    // Sorting and creating the sortedFaseCategorized map
    Map<String, List<Map<String, dynamic>>> sortedFaseCategorized = {};

    list.forEach((value) {
      String faseName = value['nama_fase'];

      if (!categorizedValues.containsKey(faseName)) {
        categorizedValues[faseName] = [];
      }

      categorizedValues[faseName]?.add(value);
    });

    // Sort the categorized values
    Map<String, List<Map<String, dynamic>>> sortedCategorizedValues =
        sortCategorizedValues(categorizedValues, phaseOrder);

    // debugPrint(sortedCategorizedValues.toString());
    return sortedCategorizedValues;
  }

  static Map<String, List<Map<String, dynamic>>> sortCategorizedValues(
      Map<String, List<Map<String, dynamic>>> categorizedValues,
      List<String> phaseOrder) {
    // Create a map to store sorted values
    Map<String, List<Map<String, dynamic>>> sortedValues = {};

    // Iterate through the phase order
    phaseOrder.forEach((phase) {
      // Check if the categorized values contain the phase
      if (categorizedValues.containsKey(phase)) {
        // Add the phase and its values to the sorted map
        sortedValues[phase] = categorizedValues[phase]!;
      }
    });

    return sortedValues;
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
      // debugPrint("CurrentDay: $currentDay");
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
