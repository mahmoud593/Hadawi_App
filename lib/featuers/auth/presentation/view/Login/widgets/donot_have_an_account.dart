import 'package:flutter/material.dart';
import 'package:hadawi_app/featuers/auth/presentation/view/register/register_screen.dart';
import 'package:hadawi_app/styles/colors/color_manager.dart';
import 'package:hadawi_app/styles/text_styles/text_styles.dart';
import 'package:hadawi_app/utiles/helper/material_navigation.dart';
import 'package:hadawi_app/utiles/localiztion/app_localization.dart';

class DonotHaveAnAccount extends StatelessWidget {
  const DonotHaveAnAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(AppLocalizations.of(context)!.translate('don\'tHaveAccount').toString(),
            style: TextStyles.textStyle18Bold.copyWith(
            color: ColorManager.darkGrey,
            fontSize: MediaQuery.sizeOf(context).height*0.018
        )),
        GestureDetector(
          onTap: () {
            customPushNavigator(context, RegisterScreen());
          },
          child: Text(AppLocalizations.of(context)!.translate('createAccount').toString(),
              style: TextStyles.textStyle18Bold.copyWith(
              color: ColorManager.primaryBlue,
              fontSize: MediaQuery.sizeOf(context).height*0.02
          )),
        ),
      ],
    );
  }
}
