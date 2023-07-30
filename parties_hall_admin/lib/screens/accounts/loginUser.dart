
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
import '../home.dart';


class UserLogin extends StatefulWidget {
  const UserLogin({Key? key}) : super(key: key);

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final _formKey = GlobalKey<FormState>();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();

  void loginUser(BuildContext context, AuthProvider myProvider) async {

    bool myValid = _formKey.currentState!.validate();
    if (myValid) {
      if (await CommonHelper.checkInternetConnection()) {

        Map mapLogin = {
          'phoneNumber': phoneNumberController.text.toString().trim(),
          'password': passwordController.text.toString().trim()
        };

        ProgressIndicatorDialog().show(context, text: 'جاري تسجيل الدخول...');

        await myProvider.getLoginUser(context, mapLogin, EndPoint.adminLogin);


        if (!myProvider.loading) {
          if (myProvider.loginUserModel != null) {
            if (myProvider.loginUserModel?.success == true) {

              // dismiss dialog
              Navigator.of(context).pop();
              navigationPushAndRemoveUntil(context, HomeScreen());
            } else {
              Navigator.of(context).pop();

              showToast(message: myProvider.loginUserModel?.message ?? '', state: ToastStates.error);

            }
          }else{
            Navigator.of(context).pop();
          }

        }

      } else {
        showToast(message: txt_notInternet, state: ToastStates.error);

      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();

  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthProvider>(context);
    double _myHeight = CommonHelper.getScreenHeight(context) - CommonHelper.getSizePaddingTopScreen(context);
    double _myWidth = CommonHelper.getScreenWidth(context);
    return Scaffold(
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            color: AppColor.PrimaryColor,
            height:_myHeight ,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: _myHeight * 0.10,
                    ),
                    SizedBox(
                      height: _myHeight * 0.20,
                      width: _myWidth * 0.40,
                      child: const Image(
                        fit: BoxFit.cover,
                        image: AssetImage(AssetsPath.icon_hall),
                      ),
                    ),
                    SizedBox(
                      height: _myHeight * 0.02,
                    ),
                    Text(txt_appName,style: TextStyle(color: Colors.white,fontSize: 18,),),
                    SizedBox(
                      height: _myHeight * 0.02,
                    ),
                    CustomTextForm(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      hint: 'إدخل رقم الهاتف',
                      labelText: 'رقم الهاتف',
                      validator: FormValidator.fieldValidator,
                      hintColor: AppColor.GreyShade5,
                      textEditController: phoneNumberController,
                      textInputType: TextInputType.phone,
                      actionKeyboard: TextInputAction.done,
                      borderColor: AppColor.GreyShade5,
                      counterText: '',
                      maxLength: 9,
                      prefixIcon: Icon(
                        Icons.phone_android,
                        color: Colors.white,
                      ),
                      text_style: white16,
                      labelColor: Colors.white,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    CustomTextFormPassword(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      hint: 'إدخل كلمة المرور',
                      labelText: 'كلمة المرور',
                      validator: FormValidator.passwordValidator,
                      hintColor: AppColor.GreyShade5,
                      textEditController: passwordController,
                      textInputType: TextInputType.visiblePassword,
                      actionKeyboard: TextInputAction.done,
                      borderColor: AppColor.GreyShade5,
                      counterText: '',
                      maxLength: 30,
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                      suffixIcon: Icon(
                        Icons.visibility_off,
                        color: Colors.white,
                      ),
                      text_style: white16,
                      labelColor: Colors.white,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    CustomButton(
                      onPressed: () {
                        loginUser(context, loginProvider);
                      },
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 8.0),
                      width: _myWidth,
                      bgColor: Colors.white,
                      bgOverlayColor: AppColor.PrimaryColor.withOpacity(0.8),
                      txtColor: AppColor.PrimaryColor,
                      text: 'دخول',
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
