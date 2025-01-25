
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_app/featuers/splash/preentation/view/widgets/logo_image.dart';
import 'package:hadawi_app/styles/colors/color_manager.dart';
import 'package:hadawi_app/styles/size_config/app_size_config.dart';
import 'package:hadawi_app/styles/text_styles/text_styles.dart';
import 'package:hadawi_app/utiles/localiztion/app_localization.dart';
import 'package:hadawi_app/utiles/shared_preferences/shared_preference.dart';
import 'package:hadawi_app/widgets/default_button.dart';
import 'package:hadawi_app/widgets/default_text_field.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class EditProfileScreen extends StatefulWidget {


  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text= UserDataFromStorage.userNameFromStorage;
    emailController.text= UserDataFromStorage.emailFromStorage;
    phoneController.text= UserDataFromStorage.phoneNumberFromStorage;
    genderController.text= UserDataFromStorage.genderFromStorage;
    dateController.text= UserDataFromStorage.brithDateFromStorage;
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.translate('profile').toString(),
            style: TextStyles.textStyle18Bold.copyWith(
                fontSize: MediaQuery.sizeOf(context).height * 0.024,
                color: ColorManager.black,
            ),),
        ),

        body: SingleChildScrollView(
          child: Column(children: [

            Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.sizeOf(context).height * .02,
                        ),
                        decoration:  BoxDecoration(
                          color: ColorManager.primaryBlue,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              SizedBox(height: MediaQuery.sizeOf(context).height * .01,),

                              SizedBox(
                                  height:  MediaQuery.sizeOf(context).height * .12,
                                  child: LogoImage()
                              ),

                              SizedBox(height: MediaQuery.sizeOf(context).height * .02,),

                              /// name
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).height * .024,),
                                child: Text(
                                    AppLocalizations.of(context)!.translate('fullName').toString(),
                                    style: TextStyles.textStyle18Bold.copyWith(
                                      color: ColorManager.white,
                                    )
                                ),
                              ),

                              SizedBox(
                                height: MediaQuery.sizeOf(context).height * .02,
                              ),

                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: MediaQuery.sizeOf(context).height * .02,
                                ),

                                child: DefaultTextField(
                                  controller: nameController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppLocalizations.of(context)!.translate('fullNameHint').toString();
                                    }
                                    return null;
                                  },
                                  keyboardType:TextInputType.name ,
                                  textInputAction: TextInputAction.done,
                                  fillColor: ColorManager.gray,
                                  hintText: AppLocalizations.of(context)!.translate('fullNameHint').toString(),
                                ),
                              ),

                              SizedBox(
                                height: MediaQuery.sizeOf(context).height * .02,
                              ),

                              /// email
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).height * .024,),
                                child: Text(
                                    AppLocalizations.of(context)!.translate('email').toString(),
                                    style: TextStyles.textStyle18Bold.copyWith(
                                      color: ColorManager.white,
                                    )
                                ),
                              ),

                              SizedBox(
                                height: MediaQuery.sizeOf(context).height * .02,
                              ),

                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: MediaQuery.sizeOf(context).height * .02,
                                ),

                                child: DefaultTextField(
                                  enable: false,
                                  controller: emailController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppLocalizations.of(context)!.translate('emailHint').toString();
                                    }
                                    return null;
                                  },
                                  keyboardType:TextInputType.name ,
                                  textInputAction: TextInputAction.done,
                                  fillColor: ColorManager.gray,
                                  hintText: AppLocalizations.of(context)!.translate('emailHint').toString(),
                                ),
                              ),

                              SizedBox(
                                height: MediaQuery.sizeOf(context).height * .02,
                              ),

                              /// phone number
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).height * .024,),
                                child: Text(
                                    AppLocalizations.of(context)!.translate('phone').toString(),
                                    style: TextStyles.textStyle18Bold.copyWith(
                                      color: ColorManager.white,
                                    )
                                ),
                              ),

                              SizedBox(
                                height: MediaQuery.sizeOf(context).height * .02,
                              ),

                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: MediaQuery.sizeOf(context).height * .02,
                                ),

                                child: DefaultTextField(
                                  enable: false,
                                  controller: phoneController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppLocalizations.of(context)!.translate('phoneNumberHint').toString();
                                    }
                                    return null;
                                  },
                                  keyboardType:TextInputType.phone ,
                                  textInputAction: TextInputAction.done,
                                  fillColor: ColorManager.gray,
                                  hintText: AppLocalizations.of(context)!.translate('phoneNumberHint').toString(),
                                ),
                              ),

                              SizedBox(height: MediaQuery.sizeOf(context).height * .02,),

                              /// date
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).height * .024,),
                                child: Text(
                                    AppLocalizations.of(context)!.translate('brithHint').toString(),
                                    style: TextStyles.textStyle18Bold.copyWith(
                                      color: ColorManager.white,
                                    )
                                ),
                              ),

                              SizedBox(
                                height: MediaQuery.sizeOf(context).height * .02,
                              ),

                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: MediaQuery.sizeOf(context).height * .02,
                                ),

                                child: DefaultTextField(
                                  enable: false,
                                  controller: dateController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppLocalizations.of(context)!.translate('brithHint').toString();
                                    }
                                    return null;
                                  },
                                  keyboardType:TextInputType.phone ,
                                  textInputAction: TextInputAction.done,
                                  fillColor: ColorManager.gray,
                                  hintText: AppLocalizations.of(context)!.translate('brithMessage').toString(),
                                ),
                              ),

                              SizedBox(height: MediaQuery.sizeOf(context).height * .02,),

                              /// gender
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).height * .024,),
                                child: Text(
                                    AppLocalizations.of(context)!.translate('gender').toString(),
                                    style: TextStyles.textStyle18Bold.copyWith(
                                      color: ColorManager.white,
                                    )
                                ),
                              ),

                              SizedBox(
                                height: MediaQuery.sizeOf(context).height * .02,
                              ),

                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: MediaQuery.sizeOf(context).height * .02,
                                ),

                                child: DefaultTextField(
                                  enable: false,
                                  controller: genderController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your Gender';
                                    }
                                    return null;
                                  },
                                  keyboardType:TextInputType.text ,
                                  textInputAction: TextInputAction.done,
                                  fillColor: ColorManager.gray,
                                  hintText: 'Enter your Gender',
                                ),
                              ),

                              SizedBox(height: MediaQuery.sizeOf(context).height * .02,),

                            ]
                        ),
                      ),

                      SizedBox(height: MediaQuery.sizeOf(context).height * .04,),

                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin:  EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).height * .05,),
                          child: DefaultButton(
                              buttonText: AppLocalizations.of(context)!.translate('save').toString(),
                              onPressed: (){
                              },
                              buttonColor: ColorManager.primaryBlue,
                          ),
                        ),
                      ),

                      SizedBox(height: MediaQuery.sizeOf(context).height * .04,),


                    ],
                  ),
                )),
          ]),
        ),
    );
  }
}