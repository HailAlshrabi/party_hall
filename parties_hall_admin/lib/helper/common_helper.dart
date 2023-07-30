

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants/assets_path.dart';
import '../constants/string_constants.dart';



class CommonHelper{

   static double getScreenWidth(BuildContext context){
      return MediaQuery.of(context).size.width;
   }

   static double getScreenHeight(BuildContext context) {
      return MediaQuery.of(context).size.height;
   }

   static double getSizePaddingTopScreen(BuildContext context) {
      return MediaQuery.of(context).padding.top;
   }

   static double getSizeAppBarHeight(AppBar appBar){
      return appBar.preferredSize.height;
   }

   static void dismissKeyBoard() {
      // for dismiss keyboard
      FocusManager.instance.primaryFocus?.unfocus();
   }

   static Future<bool> checkInternetConnection() async {
      try {
         final result = await InternetAddress.lookup("google.com");
         if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
           // print("-----------connect Internet---------");
            return true;
         } else {
           // print("------------not connect Internet-------");
            return false;
         }
      } on SocketException catch (_) {
         print("not connect");
         return false;
      }
   }



   static Future<String> getDateFormatted(BuildContext context ) async {
      DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1990),
          lastDate: DateTime(2100));

      if (pickedDate != null) {
         String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
         print(formattedDate); //formatted date output using intl package =>  2021-03-16
         return formattedDate;
      } else {
         return '';
      }
   }

   static String randomNumbersAndLetters({int length =15}){
      const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
      Random _rnd = Random();
      return String.fromCharCodes(Iterable.generate(
          length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
   }

}