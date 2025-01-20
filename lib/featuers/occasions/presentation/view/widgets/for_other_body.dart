import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_app/featuers/occasions/presentation/controller/occasion_cubit.dart';
import 'package:hadawi_app/featuers/occasions/presentation/view/widgets/gift_screen.dart';
import 'package:hadawi_app/featuers/occasions/presentation/view/widgets/money_screen.dart';
import 'package:hadawi_app/styles/colors/color_manager.dart';
import 'package:hadawi_app/styles/text_styles/text_styles.dart';
import 'package:hadawi_app/utiles/helper/material_navigation.dart';
import 'package:hadawi_app/widgets/default_text_field.dart';

class ForOtherBody extends StatelessWidget {
  const ForOtherBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OccasionCubit, OccasionState>(
      builder: (context, state) {
        final cubit = context.read<OccasionCubit>();
        final mediaQuery = MediaQuery.sizeOf(context);
        return Column(
          children: [
            /// person name
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  ' :اسم الشخص',
                  style: TextStyles.textStyle18Bold
                      .copyWith(color: ColorManager.black),
                ),
                DefaultTextField(
                    controller: cubit.nameController,
                    hintText: '',
                    validator: (value) {
                      return '';
                    },
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    fillColor: ColorManager.gray)
              ],
            ),
            SizedBox(height: mediaQuery.height * 0.03),

            /// occasion
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  ' :المناسبة',
                  style: TextStyles.textStyle18Bold
                      .copyWith(color: ColorManager.black),
                ),
                DefaultTextField(
                    controller: cubit.occasionNameController,
                    hintText: '',
                    validator: (value) {
                      return '';
                    },
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    fillColor: ColorManager.gray)
              ],
            ),
            SizedBox(height: mediaQuery.height * 0.03),

            /// date of occasion
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  ':تاريخ المناسبة',
                  style: TextStyles.textStyle18Bold
                      .copyWith(color: ColorManager.black),
                ),
                GestureDetector(
                  onTap: () {
                    showDatePicker(
                      helpText: 'Select the date of the occasion',
                      context: context,
                      firstDate: DateTime(1920),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    ).then((value) =>cubit.setOccasionDate(brithDateValue: value!));
                  },
                  child: DefaultTextField(
                      controller: cubit.occasionDateController,
                      hintText: cubit.occasionDateController.text.isEmpty
                          ? ''
                          : cubit.occasionDateController.text,
                      validator: (value) {
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      enable: false,
                      fillColor: ColorManager.gray),
                )
              ],
            ),
            SizedBox(height: mediaQuery.height * 0.03),
            /// money gift
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  ' :المبلغ المطلوب',
                  style: TextStyles.textStyle18Bold
                      .copyWith(color: ColorManager.black),
                ),
                DefaultTextField(
                    controller: cubit.moneyAmountController,
                    hintText: '',
                    validator: (value) {
                      return '';
                    },
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    fillColor: ColorManager.gray)
              ],
            ),
            SizedBox(height: mediaQuery.height * 0.03),
            /// requested gift
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    /// present
                    GestureDetector(
                      onTap: () {
                        customPushNavigator(
                            context,
                            BlocProvider<OccasionCubit>(
                              create: (context) => OccasionCubit(),
                              child: GiftScreen(),
                            ));
                        cubit.switchGiftKind();
                      },
                      child: Container(
                        height: mediaQuery.height * .055,
                        width: mediaQuery.width * .25,
                        decoration: BoxDecoration(
                          color: ColorManager.primaryBlue,
                          borderRadius:
                              BorderRadius.circular(mediaQuery.height * 0.05),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'هدية',
                                style: TextStyles.textStyle18Bold
                                    .copyWith(color: ColorManager.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: mediaQuery.width * .05),

                    /// money
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: mediaQuery.height * .055,
                        width: mediaQuery.width * .25,
                        decoration: BoxDecoration(
                          color: ColorManager.primaryBlue,
                          borderRadius:
                              BorderRadius.circular(mediaQuery.height * 0.05),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'مبلغ مالي',
                                style: TextStyles.textStyle18Bold
                                    .copyWith(color: ColorManager.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  ' :الهدية المطلوبة',
                  style: TextStyles.textStyle18Bold
                      .copyWith(color: ColorManager.black),
                ),
              ],
            ),
            SizedBox(height: mediaQuery.height * .04),

            ///  continue button
            GestureDetector(
              onTap: () {},
              child: Container(
                height: mediaQuery.height * .06,
                width: mediaQuery.width * .5,
                decoration: BoxDecoration(
                  color: ColorManager.primaryBlue,
                  borderRadius: BorderRadius.circular(mediaQuery.height * 0.05),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'المتابعة',
                      style: TextStyles.textStyle18Bold
                          .copyWith(color: ColorManager.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
