
import 'package:flutter/material.dart';
import 'package:parties_hall_admin/constants/string_constants.dart';
import 'package:parties_hall_admin/widgets/toast.dart';
import 'package:provider/provider.dart';

import '../../constants/assets_path.dart';
import '../../constants/colors_constants.dart';
import '../../helper/common_helper.dart';
import '../../helper/form_validator.dart';
import '../../providers/AuthProvider.dart';
import '../../services/endpoint.dart';
import '../../utils/progressIndicatorDialog.dart';
import '../../utils/style.dart';
import '../../widgets/components.dart';
import '../../widgets/customButton.dart';
import '../../widgets/customTextForm.dart';
import '../../widgets/customTextFormPassword.dart';
import 'addPartiesHallScreen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    double _myHeight = CommonHelper.getScreenHeight(context) - CommonHelper.getSizePaddingTopScreen(context);
    double _myWidth = CommonHelper.getScreenWidth(context);
    return Scaffold(
      appBar:  AppBar(
        elevation: 0,
        backgroundColor: AppColor.PrimaryColor,
        title:  Text('$txt_appName ',textDirection: TextDirection.rtl , style: TextStyle(color:  Colors.white,fontSize: _myWidth * 0.04),),
        centerTitle: true,

      ) ,
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            color: Colors.white,
            height:_myHeight ,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    SizedBox(
                      height: _myHeight * 0.10,
                    ),

                    CustomButton(
                      onPressed: () {
                        navigationPush(context, AddPartiesHallScreen());
                      },
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 8.0),
                      width: _myWidth,
                      bgColor: AppColor.PrimaryColor ,
                      bgOverlayColor: Colors.white.withOpacity(0.8),
                      txtColor: Colors.white,
                      text: 'إضافة قاعة إحتفالات',
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


}
