
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class HallProvider extends ChangeNotifier{
  final ImagePicker imagePicker = ImagePicker();

  File? imageShowingHall;
  File? image1;
  File? image2;
  File? image3;

  List<String> cityList = ['صنعاء','عدن','تعز','عمران','البيضاء','الحديدة','المحويت','ذمار','حجة','إب','مأرب','صعدة','الضالع','المكلا'];


  String city = 'صنعاء';
  void changeCity(String s) {
    city = s;
    notifyListeners();
  }

  Future openGallery(BuildContext context ,int i) async {
    if(await checkCameraAndGalleryPermission(context)){
      try {
        final XFile? _photoGallery =
        //await imagePicker.pickImage(source: ImageSource.gallery , imageQuality: 80,maxWidth: 1080 ,maxHeight: 608,);
        await imagePicker.pickImage(source: ImageSource.gallery , imageQuality: 75,maxWidth: 640 ,maxHeight: 480,);
        if(_photoGallery != null){
          if(i == 1){
            imageShowingHall = File(_photoGallery.path.toString() ??'');
          }
          if(i == 2){
            image1 = File(_photoGallery.path.toString() ??'');
          }
          if(i == 3){
            image2 = File(_photoGallery.path.toString() ??'');
          }
          if(i == 4){
            image3 = File(_photoGallery.path.toString() ??'');
          }

        }
        notifyListeners();
      } catch (error, s) {
        log('get image from gallery', error: error, stackTrace: s);
      }
    }
  }

   Future<bool> checkCameraAndGalleryPermission(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    Map<Permission, PermissionStatus> statues = await [
      Permission.camera,
      Permission.storage,
    ].request();
    PermissionStatus? statusCamera = statues[Permission.camera];
    PermissionStatus? statusStorage = statues[Permission.storage];
    bool isGranted = statusCamera == PermissionStatus.granted &&
        statusStorage == PermissionStatus.granted ;
    if (isGranted) {
      return true;
    }
    bool isPermanentlyDenied =
        statusCamera == PermissionStatus.permanentlyDenied ||
            statusStorage == PermissionStatus.permanentlyDenied ;
    if (isPermanentlyDenied) {
      openAppSettings();
      return false;
    }

    return false;
  }

}