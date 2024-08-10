import 'dart:developer';
import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class UserscreenProvider extends ChangeNotifier {
  String fileName = "";
  var filePath;
  int totalRow = 0;
  var location;
  Set<String> setlocation = {};
  void pickfile() async {
    log("1");
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['xlsx']);
    final filePath = result?.files.first.path;
    log(result!.files.first.name.toString());

    if (result == null) {
      fileName = "";
      notifyListeners();
      return;
    }

    var bytes = File(filePath!).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);
    int totalRow = 0;
    for (var table in excel.tables.keys) {
      totalRow = excel.tables[table]!.maxRows;

      // log(table);
      //log(excel.tables[table]!.maxColumns.toString());
      // log(excel.tables.[table].maxRows);
      for (var row in excel.tables[table]!.rows) {
        log(row.first!.value.toString(), name: "name");
        location = row.first!.value.toString();
        setlocation.add(location);
        notifyListeners();
      }
      ;
    }

    log(result.files.first.name);
    log(result.files.first.size.toString());
    log(result.files.first.path.toString());
    notifyListeners();
  }
}
