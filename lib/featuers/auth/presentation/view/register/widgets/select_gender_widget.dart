import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_app/featuers/auth/presentation/controller/auth_cubit.dart';
import 'package:hadawi_app/featuers/auth/presentation/controller/auth_states.dart';
import 'package:hadawi_app/styles/colors/color_manager.dart';
import 'package:hadawi_app/styles/text_styles/text_styles.dart';
import 'package:hadawi_app/utiles/localiztion/app_localization.dart';

class SelectGenderWidget extends StatelessWidget {
  const SelectGenderWidget ({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit,AuthStates>(
      builder: (context, state) {
        var cubit = context.read<AuthCubit>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.translate('gender').toString(),
              style: TextStyles.textStyle18Bold.copyWith(
              color: ColorManager.black,
              fontSize: MediaQuery.sizeOf(context).height*0.02
            ),),
            Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    title: Text(AppLocalizations.of(context)!.translate('male').toString(),
                      style: TextStyles.textStyle18Medium,),
                    value: 'Male',
                    groupValue: cubit.genderValue,
                    onChanged: (String? value) {
                      cubit.changeGenderValue(value);
                    },
                  ),
                ),

                Expanded(
                  child: RadioListTile(
                    value: 'Female',
                    title: Text(AppLocalizations.of(context)!.translate('female').toString(),
                      style: TextStyles.textStyle18Medium,),
                      groupValue: cubit.genderValue,
                      onChanged: (String? value) {
                        cubit.changeGenderValue(value);
                      },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
