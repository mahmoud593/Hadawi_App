import 'package:flutter/material.dart';
import 'package:hadawi_app/styles/assets/asset_manager.dart';
import 'package:hadawi_app/styles/colors/color_manager.dart';
import 'package:hadawi_app/styles/size_config/app_size_config.dart';
import 'package:hadawi_app/styles/text_styles/text_styles.dart';
import 'package:hadawi_app/widgets/default_button.dart';
import 'package:hadawi_app/widgets/default_button_with_image.dart';
import 'package:hadawi_app/widgets/default_text_field.dart';

class PaymentGiftScreen extends StatelessWidget {
  const PaymentGiftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: ColorManager.white,
        appBar: AppBar(
            backgroundColor: ColorManager.gray,
            title: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "الدفع لعيد ميلاد محمد ممدوح",
                style: TextStyles.textStyle18Bold.copyWith(
                    color: ColorManager.primaryBlue),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image(
                    image: AssetImage(AssetsManager.logoWithoutBackground)),
              ),
            ]),
        body: Padding(
          padding: EdgeInsets.all(SizeConfig.height * 0.02),
          child: Column(
            children: [
              /// payment progress
              SizedBox(
                height: SizeConfig.height * 0.02,
              ),

              SizedBox(
                height: SizeConfig.height * 0.04,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    LinearProgressIndicator(
                      value: 0.6,
                      backgroundColor: ColorManager.gray,
                      color: ColorManager.primaryBlue,
                      minHeight: SizeConfig.height * 0.04,
                      borderRadius:
                          BorderRadius.circular(SizeConfig.height * 0.03),
                    ),
                    Text(
                      "60%",
                      style: TextStyles.textStyle18Medium.copyWith(
                        color: ColorManager.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.height * 0.04,
              ),

              /// payment amount
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      "المبلغ : ",
                      style: TextStyles.textStyle18Bold.copyWith(
                        color: ColorManager.black,
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        Container(
                          height: SizeConfig.height * 0.05,
                          width: SizeConfig.height * 0.2,
                          decoration: BoxDecoration(
                            color: ColorManager.gray,
                            borderRadius:
                                BorderRadius.circular(SizeConfig.height * 0.01),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.remove,
                                  color: ColorManager.primaryBlue,
                                ),
                              ),
                              Text(
                                "100",
                                style: TextStyles.textStyle18Medium.copyWith(
                                  color: ColorManager.primaryBlue,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.add,
                                  color: ColorManager.primaryBlue,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.width * 0.02,
                        ),
                        Text(
                          "ريال",
                          style: TextStyles.textStyle18Bold.copyWith(
                            color: ColorManager.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),


              SizedBox(
                height: SizeConfig.height * 0.01,
              ),

              /// payment name
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      "رقم الجوال : ",
                      style: TextStyles.textStyle18Bold.copyWith(
                        color: ColorManager.black,
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 3,
                    child: DefaultTextField(
                        controller: nameController,
                        hintText: '',
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'الرجاء ادخال رقم الجوال';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.done,
                        fillColor: ColorManager.gray,
                    ),
                  ),

                ],
              ),

              SizedBox(
                height: SizeConfig.height * 0.08,
              ),


              DefaultButton(
                buttonText: "الدفع كهدية",
                onPressed: () {},
                buttonColor: ColorManager.primaryBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
