
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dropdown_search2/dropdown_search2.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_picker/map_picker.dart';
import 'package:provider/provider.dart';


import '../../constants/assets_path.dart';
import '../../constants/colors_constants.dart';

import '../../helper/common_helper.dart';
import '../../helper/form_validator.dart';
import '../../widgets/arrowBackWidget.dart';
import '../../widgets/components.dart';
import '../../widgets/customButton.dart';
import '../../widgets/customTextForm.dart';
import '../constants/string_constants.dart';
import '../providers/hallProvider.dart';
import '../services/endpoint.dart';
import '../services/rest_api_services.dart';
import '../utils/progressIndicatorDialog.dart';
import '../widgets/imageLabelWidget.dart';
import '../widgets/toast.dart';


class AddPartiesHallScreen extends StatefulWidget {
  const AddPartiesHallScreen({Key? key}) : super(key: key);
  @override
  State<AddPartiesHallScreen> createState() => _AddPartiesHallScreenState();
}

class _AddPartiesHallScreenState extends State<AddPartiesHallScreen> {

  final _formKey = GlobalKey<FormState>();
 // final nameController = TextEditingController();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final addressController = TextEditingController();
  final addressDetailsController = TextEditingController();
  final phoneNumbersController = TextEditingController();
  final infoController = TextEditingController();

  final _controller = Completer<GoogleMapController>();
  MapPickerController mapPickerController = MapPickerController();

  CameraPosition initCameraPosition = const CameraPosition(
    target: LatLng(15.369445, 44.191006),
    zoom: 15,
  );

  final textController = TextEditingController();




  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();



  }

  @override
  Widget build(BuildContext context) {
    double _myHeight = CommonHelper.getScreenHeight(context) - CommonHelper.getSizePaddingTopScreen(context);
    double _myWidth = CommonHelper.getScreenWidth(context);
    final _provider =Provider.of<HallProvider>(context);

    return SafeArea(
        child: Scaffold(
          appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent,
            title: const Text('إضافة قاعة إحتفالات',textDirection: TextDirection.rtl , style: TextStyle(color:  AppColor.PrimaryColor,fontSize: 18.0 ,fontWeight:FontWeight.w600 ),),
            centerTitle: true, leading: ArrowBackWidget(myContext: context,),
          ),

          body:Directionality(
            textDirection:TextDirection.rtl,
            child: Container(
              padding:const EdgeInsets.all(8.0) ,
              color: Colors.white.withOpacity(0.05),
              child: SingleChildScrollView(
                child:Column(
                  children: [
                   Row(
                     children: [
                       Expanded(flex: 1,child:  ImageLabelWidget(
                         file: _provider.imageShowingHall, width: _myWidth * 0.40,height:_myHeight * 0.15,
                         label:'صورة العرض',
                         getImageFromGallery: () {
                            _provider.openGallery(context,1);
                         },
                       ),),
                       const SizedBox(width: 10.0,),
                       Expanded(flex: 1,child:  ImageLabelWidget(
                         file: _provider.image1, width: _myWidth * 0.40,height:_myHeight * 0.15,
                         label:'صورة إختياري1',
                         getImageFromGallery: () {
                           _provider.openGallery(context,2);
                         },
                       ),),
                     ],
                   ),

                    const SizedBox(height: 10.0,),
                    Row(
                      children: [
                        Expanded(flex: 1,child:  ImageLabelWidget(
                          file: _provider.image2, width: _myWidth * 0.40,height:_myHeight * 0.15,
                          label:'صورة إختياري2',
                          getImageFromGallery: () {
                            _provider.openGallery(context,3);
                          },
                        ),),
                        const SizedBox(width: 10.0,),
                        Expanded(flex: 1,child:  ImageLabelWidget(
                          file: _provider.image3, width: _myWidth * 0.40,height:_myHeight * 0.15,
                          label:'صورة إختياري3',
                          getImageFromGallery: () {
                            _provider.openGallery(context,4);
                          },
                        ),),
                      ],
                    ),

                    const SizedBox(height: 10.0,),
                    Container(
                      width: _myWidth,
                      // alignment: Alignment.bottomCenter,
                      child: Container(
                        width: _myWidth,
                        padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 10.0),
                        decoration: boxDecoration(),
                        child:Form(
                          key: _formKey,
                          child:  Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 16.0),
                              CustomTextForm(
                                margin:const EdgeInsets.all(0.0),
                                hint:'إسم القاعة',
                                labelText: 'إسم القاعة',
                                textEditController: nameController,
                                validator: FormValidator.fieldValidator,
                                maxLength: 95,
                                actionKeyboard:TextInputAction.none,
                                enableFocusedBorder: true,
                                filled: true,
                                labelColor:AppColor.PrimaryColor ,
                                fillColor: AppColor.PrimaryColor.withOpacity(0.02),
                                text_style: TextStyle(fontSize:_myWidth * 0.04 ),
                               // fontSize: _myWidth * 0.04,
                              ),
                              const SizedBox(height: 10.0),
                              SizedBox(
                                height: _myHeight * 0.08,
                                child: DropdownSearch<String>(
                                  dropdownSearchDecoration: inputDecorationDropDownSearch(_myWidth),
                                  dropDownButton:  const Icon(Icons.arrow_drop_down,color: AppColor.PrimaryColor,),
                                  mode: Mode.DIALOG,
                                  selectedItem: _provider.city,
                                  items: _provider.cityList,
                                  showSearchBox: true,
                                  label: 'المحافطة',
                                  hint:'المحافطة',
                                  itemAsString: (String? s) => s.toString(),
                                  onChanged: (String? selection){
                                    if(selection != null){
                                      _provider.changeCity(selection);
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              CustomTextForm(
                                margin:const EdgeInsets.all(0.0),
                                hint:'السعر',
                                labelText: 'السعر',
                                textEditController: priceController,
                                validator: FormValidator.fieldValidator,
                                maxLength: 10,
                                actionKeyboard:TextInputAction.none,
                                textInputType: TextInputType.number,
                                enableFocusedBorder: true,
                                filled: true,
                                labelColor:AppColor.PrimaryColor ,
                                fillColor: AppColor.PrimaryColor.withOpacity(0.02),
                                text_style: TextStyle(fontSize:_myWidth * 0.04 ),
                                // fontSize: _myWidth * 0.04,
                              ),
                              const SizedBox(height: 10.0),
                              CustomTextForm(
                                margin:const EdgeInsets.all(0.0),
                                hint:'العنوان',
                                labelText: ' العنوان',
                                textEditController: addressController,
                                validator: FormValidator.fieldValidator,
                                maxLength: 50,
                                actionKeyboard:TextInputAction.none,
                                enableFocusedBorder: true,
                                filled: true,
                                labelColor:AppColor.PrimaryColor ,
                                fillColor: AppColor.PrimaryColor.withOpacity(0.02),
                                text_style: TextStyle(fontSize:_myWidth * 0.04 ),
                                // fontSize: _myWidth * 0.04,
                              ),
                              const SizedBox(height: 10.0),
                              CustomTextForm(
                                margin:const EdgeInsets.all(0.0),
                                hint:'تفاصيل العنوان',
                                labelText: 'تفاصيل العنوان',
                                textEditController: addressDetailsController,
                                validator: FormValidator.fieldValidator,
                                maxLength: 490,
                                actionKeyboard:TextInputAction.none,
                                enableFocusedBorder: true,
                                filled: true,
                                labelColor:AppColor.PrimaryColor ,
                                fillColor: AppColor.PrimaryColor.withOpacity(0.02),
                                text_style: TextStyle(fontSize:_myWidth * 0.04 ),
                                // fontSize: _myWidth * 0.04,
                              ),
                              const SizedBox(height: 10.0),
                              CustomTextForm(
                                margin:const EdgeInsets.all(0.0),
                                hint:'أرقام التواصل',
                                labelText: 'أرقام التواصل',
                                textEditController: phoneNumbersController,
                                validator: FormValidator.fieldValidator,
                                maxLength: 190,
                                actionKeyboard:TextInputAction.none,
                                enableFocusedBorder: true,
                                filled: true,
                                labelColor:AppColor.PrimaryColor ,
                                fillColor: AppColor.PrimaryColor.withOpacity(0.02),
                                text_style: TextStyle(fontSize:_myWidth * 0.04 ),
                                // fontSize: _myWidth * 0.04,
                              ),
                              const SizedBox(height: 10.0),
                              CustomTextForm(
                                margin:const EdgeInsets.all(0.0),
                                hint:'معلومات عن القاعة',
                                labelText: 'معلومات عن القاعة',
                                textEditController: infoController,
                                validator: FormValidator.fieldValidator,
                                maxLength: 1000,
                                actionKeyboard:TextInputAction.none,
                                enableFocusedBorder: true,
                                filled: true,
                                maxLines: 5,
                                labelColor:AppColor.PrimaryColor ,
                                fillColor: AppColor.PrimaryColor.withOpacity(0.02),
                                text_style: TextStyle(fontSize:_myWidth * 0.04 ),
                                // fontSize: _myWidth * 0.04,
                              ),
                              const SizedBox(height: 10.0),

                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0,),


                    Container(
                      width: double.infinity,
                      height: 300.0,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                            height: 300,
                            width: double.infinity,
                            child:    MapPicker(
                              // pass icon widget
                              iconWidget: Icon(Icons.location_on ,color: AppColor.PrimaryColor,size: 60.0),
                              // SvgPicture.asset(
                              //   AssetsPath.icon_location,
                              //   height: 60,
                              //   color: AppColor.PrimaryColor,
                              // ),
                              //add map picker controller
                              mapPickerController: mapPickerController,
                              child: Container(
                                width: double.infinity,
                                height: 300,
                                child: GoogleMap(
                                  myLocationEnabled: true,
                                  zoomControlsEnabled: false,
                                  // hide location button
                                  myLocationButtonEnabled: false,
                                  mapType: MapType.normal,
                                  //  camera position
                                  initialCameraPosition: initCameraPosition,
                                  onMapCreated: (GoogleMapController controller) {
                                    _controller.complete(controller);
                                  },
                                  onCameraMoveStarted: () {
                                    // notify map is moving
                                    mapPickerController.mapMoving!();
                                    textController.text = "جاري البحث ...";
                                  },
                                  onCameraMove: (cameraPosition) {
                                    initCameraPosition = cameraPosition;
                                  },
                                  onCameraIdle: () async {
                                    // notify map stopped moving
                                    mapPickerController.mapFinishedMoving!();
                                    //get address name from camera position
                                    List<Placemark> placemarks = await placemarkFromCoordinates(
                                        initCameraPosition.target.latitude,
                                        initCameraPosition.target.longitude,
                                        localeIdentifier: "ar"
                                    );

                                    try{
                                      // update the ui with the address
                                      // textController.text =
                                      // '${placemarks[2].country} ,${placemarks[2].administrativeArea} ,${placemarks[2].locality} ,${placemarks[2].street}';
                                      //print('${placemarks[2].name} ,${placemarks[2].administrativeArea},${placemarks[2].street}');
                                      //if(placemarks[2].name != null)
                                       // areaController.text = placemarks[2].name ?? '';
                                    }catch(ex){
                                      print('AddAdress-----------${ex}');
                                    }


                                  },
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).viewPadding.top + 20,
                            width: MediaQuery.of(context).size.width - 50,
                            height: 50,
                            child: TextFormField(
                              maxLines: 3,
                              textAlign: TextAlign.center,
                              readOnly: true,
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero, border: InputBorder.none),
                              controller: textController,
                            ),
                          ),
                          Positioned(
                            bottom: 24,
                            left: 24,
                            right: 24,
                            child: SizedBox(
                              height: 50,
                              child: TextButton(
                                child: const Text(
                                  'حفظ الموقع',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 19,
                                    // height: 19/19,
                                  ),
                                ),
                                onPressed: () {
                                  print("Location ${initCameraPosition.target.latitude} ${initCameraPosition.target.longitude}");
                                  print("Address: ${textController.text}");


                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all<Color>(AppColor.PrimaryColor),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: 20.0),

                    CustomButton(
                      onPressed: () async {

                        bool myValid = _formKey.currentState!.validate();
                        if (myValid) {
                          if (await CommonHelper.checkInternetConnection()) {

                        Map map= {
                        'name': nameController.text.toString().trim(),
                        'price': priceController.text.toString().trim(),
                        'address': addressController.text.toString().trim(),
                        'addressDetails': addressDetailsController.text.toString().trim(),
                        'latitude': initCameraPosition.target.latitude.toString() ?? '0',
                        'longitude': initCameraPosition.target.longitude.toString() ?? '0',
                        'imageShowing': _provider.imageShowingHall != null ? convertImageToBase64(_provider.imageShowingHall) : '',
                        'image1': _provider.image1 != null ? convertImageToBase64(_provider.image1) : '',
                        'image2': _provider.image2 != null ? convertImageToBase64(_provider.image2) : '',
                        'image3': _provider.image3 != null ? convertImageToBase64(_provider.image3) : '',
                        'phoneNumbers': phoneNumbersController.text.toString().trim(),
                        'infoHall': infoController.text.toString().trim(),
                        'city': _provider.city,
                        };

                        ProgressIndicatorDialog().show(context, text: 'جاري الاضافة...');

                        dynamic response = await RestApiServices().postData(context, map, EndPoint.addHall);


                        if (response['success']) {

                          // dismiss dialog
                          Navigator.of(context).pop();
                          showToast(message: response['message'] ?? '', state: ToastStates.success);
                        } else {
                          Navigator.of(context).pop();

                          showToast(message: response['message'] ?? '', state: ToastStates.error);

                        }

                        } else {
                        showToast(message: txt_notInternet, state: ToastStates.error);

                        }
                      }
                      },
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 8.0),
                      width: _myWidth,
                      bgColor: AppColor.PrimaryColor ,
                      bgOverlayColor: Colors.white.withOpacity(0.8),
                      txtColor: Colors.white,
                      text: 'إضافة ',
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              )
            ),
          ),
        ));
  }

   String convertImageToBase64(File? file){
    List<int> imageBytes = file!.readAsBytesSync();
    return base64Encode(imageBytes);
  }


}
