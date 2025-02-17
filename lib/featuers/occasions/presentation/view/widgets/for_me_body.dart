import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_app/featuers/occasions/presentation/controller/occasion_cubit.dart';
import 'package:hadawi_app/featuers/occasions/presentation/view/widgets/gift_screen.dart';
import 'package:hadawi_app/styles/colors/color_manager.dart';
import 'package:hadawi_app/styles/size_config/app_size_config.dart';
import 'package:hadawi_app/styles/text_styles/text_styles.dart';
import 'package:hadawi_app/utiles/helper/material_navigation.dart';
import 'package:hadawi_app/utiles/localiztion/app_localization.dart';
import 'package:hadawi_app/utiles/shared_preferences/shared_preference.dart';
import 'package:hadawi_app/widgets/default_text_field.dart';
import 'package:hadawi_app/widgets/toast.dart';

import '../../../../../utiles/cashe_helper/cashe_helper.dart';
import 'money_screen.dart';

class ForMeBody extends StatefulWidget {
  const ForMeBody({super.key});

  @override
  State<ForMeBody> createState() => _ForMeBodyState();
}

class _ForMeBodyState extends State<ForMeBody> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OccasionCubit, OccasionState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = context.read<OccasionCubit>();
        final mediaQuery = MediaQuery.sizeOf(context);
        return Form(
          key: cubit.forMeFormKey,
          child: Column(
            crossAxisAlignment: CashHelper.languageKey == 'ar'
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              /// public or private
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!
                        .translate('public')
                        .toString(),
                    style: TextStyles.textStyle18Bold
                        .copyWith(color: ColorManager.black),
                  ),
                  SizedBox(width: 10,),
                  Switch(
                      value: cubit.isPublicValue,
                      onChanged: (value) {
                        cubit.switchIsPublic();
                      }),
                  SizedBox(width: 10,),
                  Text(
                    AppLocalizations.of(context)!
                        .translate('private')
                        .toString(),
                    style: TextStyles.textStyle18Bold
                        .copyWith(color: ColorManager.black),
                  ),
                ],
              ),

              /// person name
              Visibility(
                visible: cubit.isForMe == false ? true : false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.translate('personName').toString(),
                      style: TextStyles.textStyle18Bold
                          .copyWith(color: ColorManager.black),
                    ),
                    SizedBox(height: mediaQuery.height * 0.01),

                    DefaultTextField(
                        controller: cubit.nameController,
                        hintText: AppLocalizations.of(context)!.translate('personNameHint').toString(),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!.translate('validatePersonName').toString();
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        fillColor: ColorManager.gray),
                    SizedBox(height: mediaQuery.height * 0.02),
                  ],
                ),
              ),
              /// new occasion
              Text(
                AppLocalizations.of(context)!
                    .translate('occasionName')
                    .toString(),
                style: TextStyles.textStyle18Bold
                    .copyWith(color: ColorManager.black),
              ),
              SizedBox(height: mediaQuery.height * 0.01),
              /// occasion name
              DefaultTextField(
                  controller: cubit.occasionNameController,
                  hintText: AppLocalizations.of(context)!
                      .translate('occasionNameHint')
                      .toString(),
                  validator: (value) {
                    if (value!.trim().isNotEmpty) return null;
                    return AppLocalizations.of(context)!
                        .translate('validateOccasionName')
                        .toString();
                  },
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  fillColor: ColorManager.gray),
              SizedBox(height: mediaQuery.height * 0.01),
              /// service fees text
              Text(
                AppLocalizations.of(context)!.translate('feesNote').toString(),
                style: TextStyles.textStyle12Bold
                    .copyWith(color: ColorManager.black.withOpacity(.5)),
              ),
              SizedBox(height: mediaQuery.height * 0.02),

              /// date of occasion
              // Text(
              //   AppLocalizations.of(context)!
              //       .translate('occasionDate')
              //       .toString(),
              //   style: TextStyles.textStyle18Bold
              //       .copyWith(color: ColorManager.black),
              // ),
              // SizedBox(height: mediaQuery.height * 0.01),
              //
              // GestureDetector(
              //   onTap: () {
              //     showDatePicker(
              //       helpText: AppLocalizations.of(context)!
              //           .translate('occasionDate')
              //           .toString(),
              //       context: context,
              //       firstDate: DateTime(1920),
              //       lastDate: DateTime.now().add(const Duration(days: 365)),
              //     ).then(
              //         (value) => cubit.setOccasionDate(brithDateValue: value!));
              //   },
              //   child: DefaultTextField(
              //       controller: cubit.occasionDateController,
              //       hintText: cubit.occasionDateController.text.isEmpty
              //           ? AppLocalizations.of(context)!
              //               .translate('occasionDateHint')
              //               .toString()
              //           : cubit.occasionDateController.text,
              //       validator: (value) {
              //         if (value!.trim().isNotEmpty) return null;
              //         return AppLocalizations.of(context)!
              //             .translate('validateOccasionDate')
              //             .toString();
              //       },
              //       keyboardType: TextInputType.text,
              //       textInputAction: TextInputAction.next,
              //       enable: false,
              //       fillColor: ColorManager.gray),
              // ),
              // SizedBox(height: mediaQuery.height * 0.03),

              /// requested gift (gift type)
              Row(
                mainAxisAlignment: CashHelper.languageKey == 'ar'
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "${AppLocalizations.of(context)!.translate('giftType').toString()}: ",
                        style: TextStyles.textStyle18Bold
                            .copyWith(color: ColorManager.black),
                      ),

                      /// present
                      GestureDetector(
                        onTap: () {
                          cubit.giftType = 'هدية';
                          UserDataFromStorage.giftType = cubit.giftType;
                          cubit.switchGiftType();
                          debugPrint('giftType: ${cubit.giftType}');
                        },
                        child: Container(
                          height: mediaQuery.height * .055,
                          width: mediaQuery.width * .25,
                          decoration: BoxDecoration(
                            color: cubit.isPresent
                                ? ColorManager.primaryBlue
                                : ColorManager.gray,
                            borderRadius:
                                BorderRadius.circular(mediaQuery.height * 0.05),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!
                                      .translate('gift')
                                      .toString(),
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
                        onTap: () {
                          cubit.giftType = 'مبلغ مالي';
                          UserDataFromStorage.giftType = cubit.giftType;
                          cubit.switchGiftType();
                          debugPrint('giftType: ${cubit.giftType}');
                        },
                        child: Container(
                          height: mediaQuery.height * .055,
                          width: mediaQuery.width * .25,
                          decoration: BoxDecoration(
                            color: cubit.isMoney
                                ? ColorManager.primaryBlue
                                : ColorManager.gray,
                            borderRadius:
                                BorderRadius.circular(mediaQuery.height * 0.05),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!
                                      .translate('money')
                                      .toString(),
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
                ],
              ),
              SizedBox(height: mediaQuery.height * 0.02),

              /// gift section
              Visibility(
                visible: cubit.isPresent == true ? true : false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// gift name
                    Text(
                      AppLocalizations.of(context)!
                          .translate('giftName')
                          .toString(),
                      style: TextStyles.textStyle18Bold
                          .copyWith(color: ColorManager.black),
                    ),
                    SizedBox(height: mediaQuery.height * 0.01),
                    DefaultTextField(
                        controller: cubit.giftNameController,
                        hintText: AppLocalizations.of(context)!
                            .translate('giftNameHint')
                            .toString(),
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return AppLocalizations.of(context)!
                                .translate('validateGiftName')
                                .toString();
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        fillColor: ColorManager.gray),
                    SizedBox(height: mediaQuery.height * 0.04),

                    /// link
                    Text(
                      AppLocalizations.of(context)!
                          .translate('link')
                          .toString(),
                      style: TextStyles.textStyle18Bold
                          .copyWith(color: ColorManager.black),
                    ),
                    SizedBox(height: mediaQuery.height * 0.01),
                    DefaultTextField(
                        controller: cubit.linkController,
                        hintText: AppLocalizations.of(context)!
                            .translate('linkHint')
                            .toString(),
                        validator: (value) {
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        fillColor: ColorManager.gray),

                    SizedBox(height: mediaQuery.height * 0.04),

                    /// picture
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "${AppLocalizations.of(context)!.translate('gifPicture').toString()} ",
                          style: TextStyles.textStyle18Bold
                              .copyWith(color: ColorManager.black),
                        ),
                        Container(
                          height: mediaQuery.height * 0.2,
                          width: mediaQuery.width * 0.5,
                          decoration: BoxDecoration(
                              color: ColorManager.gray,
                              borderRadius: BorderRadius.circular(10)),
                          child: cubit.image == null
                              ? Center(
                            child: Container(),
                          )
                              : Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.file(
                              cubit.image!,
                              fit: BoxFit.fill,
                              height: mediaQuery.height * 0.2,
                              width: mediaQuery.width * 0.5,
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              cubit.pickGiftImage();
                            },
                            icon: Icon(
                              Icons.file_upload_outlined,
                              size: mediaQuery.height * 0.04,
                              color: ColorManager.primaryBlue,
                            )),
                      ],
                    ),
                    SizedBox(height: mediaQuery.height * 0.04),

                    /// amount
                    Text(
                      "${AppLocalizations.of(context)!.translate('giftAmount').toString()} ",
                      style: TextStyles.textStyle18Bold
                          .copyWith(color: ColorManager.black),
                    ),
                    SizedBox(height: mediaQuery.height * 0.01),
                    Row(
                      children: [
                        Expanded(
                          child: DefaultTextField(
                              controller: cubit.moneyAmountController,
                              hintText: AppLocalizations.of(context)!
                                  .translate('giftAmountHint')
                                  .toString(),
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return AppLocalizations.of(context)!
                                      .translate('validateGiftAmount')
                                      .toString();
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              fillColor: ColorManager.gray),
                        ),
                        SizedBox(width: 10,),
                        Text(
                          AppLocalizations.of(context)!.translate('rsa').toString(),
                          style: TextStyles.textStyle18Regular,
                        )
                      ],
                    ),

                    SizedBox(height: mediaQuery.height * 0.02),
                    Row(
                      mainAxisAlignment: CashHelper.languageKey == 'ar'
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            /// with packaging
                            Row(
                              children: [
                                Text(
                                  "${AppLocalizations.of(context)!.translate('packaging').toString()}: ",
                                  style: TextStyles.textStyle18Bold
                                      .copyWith(color: ColorManager.black),
                                ),
                                /// with packaging
                                GestureDetector(
                                  onTap: () {
                                    cubit.switchGiftWithPackage(true);
                                  },
                                  child: Container(
                                    height: mediaQuery.height * .055,
                                    width: mediaQuery.height * .15,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: cubit.giftWithPackage
                                          ? ColorManager.primaryBlue
                                          : ColorManager.gray,
                                      borderRadius:
                                      BorderRadius.circular(mediaQuery.height * 0.05),
                                    ),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .translate('withPackaging')
                                          .toString(),
                                      style: TextStyles.textStyle18Bold
                                          .copyWith(color: ColorManager.white),
                                    ),
                                  ),
                                ),
                                SizedBox(width: mediaQuery.width * .05),

                                /// without packaging
                                GestureDetector(
                                  onTap: () {
                                    cubit.switchGiftWithPackage(false);

                                  },
                                  child: Container(
                                    height: mediaQuery.height * .055,
                                    width: mediaQuery.height * .15,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: cubit.giftWithPackage
                                          ? ColorManager.gray
                                          : ColorManager.primaryBlue,
                                      borderRadius:
                                      BorderRadius.circular(mediaQuery.height * 0.05),
                                    ),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .translate('withoutPackaging')
                                          .toString(),
                                      style: TextStyles.textStyle18Bold
                                          .copyWith(color: ColorManager.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: mediaQuery.height * 0.02,),


                    // show gift image and price
                    Visibility(
                      visible: cubit.giftWithPackage== true? true : false,
                      child: Column(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.translate('giftNotePackage').toString(),
                            style: TextStyles.textStyle18Bold
                                .copyWith(color: ColorManager.black.withOpacity(.5)),
                          ),
                          SizedBox(height: mediaQuery.height * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: (){
                                  cubit.switchGiftWithPackageType(50);
                                },
                                child: SizedBox(
                                  height: mediaQuery.height * 0.1,
                                  width: mediaQuery.height * 0.1,
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      Container(
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          color: cubit.giftWithPackageType==50
                                              ? ColorManager.primaryBlue
                                              : ColorManager.gray,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(SizeConfig.height * 0.01),
                                          child: Image.asset(
                                            "assets/images/giftbox.png",
                                            fit: BoxFit.fill,
                                            height: mediaQuery.height * 0.08,
                                            width: mediaQuery.height * 0.08,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: mediaQuery.height * 0.04,
                                        width: mediaQuery.height * 0.04,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: ColorManager.white,
                                          borderRadius: BorderRadius.circular(500),
                                        ),
                                        child: Text(
                                          "50",
                                          style: TextStyles.textStyle12Bold
                                              .copyWith(color: ColorManager.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  cubit.switchGiftWithPackageType(100);
                                },
                                child: SizedBox(
                                  height: mediaQuery.height * 0.1,
                                  width: mediaQuery.height * 0.1,
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      Container(
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          color: cubit.giftWithPackageType==100
                                              ? ColorManager.primaryBlue
                                              : ColorManager.gray,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(SizeConfig.height * 0.01),
                                          child: Image.asset(
                                            "assets/images/giftbox.png",
                                            fit: BoxFit.fill,
                                            height: mediaQuery.height * 0.08,
                                            width: mediaQuery.height * 0.08,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: mediaQuery.height * 0.04,
                                        width: mediaQuery.height * 0.04,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: ColorManager.white,
                                          borderRadius: BorderRadius.circular(500),
                                        ),
                                        child: Text(
                                          "100",
                                          style: TextStyles.textStyle12Bold
                                              .copyWith(color: ColorManager.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),


              /// money section
              Visibility(
                visible: cubit.isPresent == false? true : false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// amount
                    Text(
                      "${AppLocalizations.of(context)!.translate('moneyAmount').toString()} ",
                      style: TextStyles.textStyle18Bold
                          .copyWith(color: ColorManager.black),
                    ),
                    SizedBox(height: mediaQuery.height * 0.01,),
                    Row(
                      children: [
                        Expanded(
                          child: DefaultTextField(
                              controller: cubit.moneyAmountController,
                              hintText: AppLocalizations.of(context)!
                                  .translate('moneyAmountHint')
                                  .toString(),
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return AppLocalizations.of(context)!
                                      .translate('validateMoneyAmount')
                                      .toString();
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              fillColor: ColorManager.gray),
                        ),
                        SizedBox(width: 10,),
                        Text(
                          AppLocalizations.of(context)!.translate('rsa').toString(),
                          style: TextStyles.textStyle18Regular,
                        )
                      ],
                    ),
                    SizedBox(height: mediaQuery.height * 0.02),

                    /// with packaging
                    Row(
                      children: [
                        Text(
                          "${AppLocalizations.of(context)!.translate('packaging').toString()}: ",
                          style: TextStyles.textStyle18Bold
                              .copyWith(color: ColorManager.black),
                        ),

                        /// with packaging
                        GestureDetector(
                          onTap: () {
                            cubit.switchGiftWithPackage(true);
                          },
                          child: Container(
                            height: mediaQuery.height * .055,
                            width: mediaQuery.height * .15,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: cubit.giftWithPackage
                                  ? ColorManager.primaryBlue
                                  : ColorManager.gray,
                              borderRadius:
                              BorderRadius.circular(mediaQuery.height * 0.05),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!
                                  .translate('withPackaging')
                                  .toString(),
                              style: TextStyles.textStyle18Bold
                                  .copyWith(color: ColorManager.white),
                            ),
                          ),
                        ),
                        SizedBox(width: mediaQuery.width * .05),

                        /// without packaging
                        GestureDetector(
                          onTap: () {
                            cubit.switchGiftWithPackage(false);

                          },
                          child: Container(
                            height: mediaQuery.height * .055,
                            width: mediaQuery.height * .15,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: cubit.giftWithPackage
                                  ? ColorManager.gray
                                  : ColorManager.primaryBlue,
                              borderRadius:
                              BorderRadius.circular(mediaQuery.height * 0.05),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!
                                  .translate('withoutPackaging')
                                  .toString(),
                              style: TextStyles.textStyle18Bold
                                  .copyWith(color: ColorManager.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: mediaQuery.height * 0.02),

                    /// receiver name
                    Visibility(
                      visible: cubit.giftWithPackage== false? true : false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.translate('moneyReceiverName').toString(),
                            style: TextStyles.textStyle18Bold
                                .copyWith(color: ColorManager.black),
                          ),
                          SizedBox(height: mediaQuery.height * 0.01),
                          DefaultTextField(
                              controller: cubit.giftReceiverNameController,
                              hintText: AppLocalizations.of(context)!.translate('moneyReceiverNameHint').toString(),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return AppLocalizations.of(context)!.translate('validateMoneyReceiverName').toString();
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              fillColor: ColorManager.gray),
                          SizedBox(height: mediaQuery.height * 0.02),
                          /// receiver number
                          Text(
                            AppLocalizations.of(context)!.translate('moneyReceiverPhone').toString(),
                            style: TextStyles.textStyle18Bold
                                .copyWith(color: ColorManager.black),
                          ),
                          SizedBox(height: mediaQuery.height * 0.01),
                          DefaultTextField(
                              controller: cubit.giftReceiverNumberController,
                              hintText: AppLocalizations.of(context)!.translate('moneyReceiverPhoneHint').toString(),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return AppLocalizations.of(context)!.translate('validateMoneyReceiverPhone').toString();
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
                              fillColor: ColorManager.gray),
                          SizedBox(height: mediaQuery.height * 0.02),
                          /// bank name
                          Text(
                            AppLocalizations.of(context)!.translate('bankName').toString(),
                            style: TextStyles.textStyle18Bold
                                .copyWith(color: ColorManager.black),
                          ),
                          SizedBox(height: mediaQuery.height * 0.01),
                          DefaultTextField(
                              controller: cubit.bankNameController,
                              hintText: AppLocalizations.of(context)!.translate('bankNameHint').toString(),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return AppLocalizations.of(context)!.translate('validateBankName').toString();
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              fillColor: ColorManager.gray),
                          SizedBox(height: mediaQuery.height * 0.02),
                          /// account iban number
                          Text(
                            AppLocalizations.of(context)!.translate('ibanNumber').toString(),
                            style: TextStyles.textStyle18Bold
                                .copyWith(color: ColorManager.black),
                          ),
                          SizedBox(height: mediaQuery.height * 0.01),
                          DefaultTextField(
                              controller: cubit.ibanNumberController,
                              hintText: AppLocalizations.of(context)!.translate('ibanNumberHint').toString(),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return AppLocalizations.of(context)!.translate('validateIbanNumber').toString();
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              fillColor: ColorManager.gray),
                          SizedBox(height: mediaQuery.height * 0.02),

                          /// date of receive
                          Text(
                            AppLocalizations.of(context)!
                                .translate('receivingTime')
                                .toString(),
                            style: TextStyles.textStyle18Bold
                                .copyWith(color: ColorManager.black),
                          ),
                          SizedBox(height: mediaQuery.height * 0.01),
                          GestureDetector(
                            onTap: () {
                              showDatePicker(
                                helpText: AppLocalizations.of(context)!
                                    .translate('receivingTime')
                                    .toString(),
                                context: context,
                                firstDate: DateTime(1920),
                                lastDate: DateTime.now().add(const Duration(days: 365)),
                              ).then(
                                      (value) => cubit.setMoneyReceiveDate(brithDateValue: value!));
                            },
                            child: DefaultTextField(
                                controller: cubit.moneyReceiveDateController,
                                hintText: cubit.moneyReceiveDateController.text.isEmpty
                                    ? AppLocalizations.of(context)!
                                    .translate('receivingTimeHint')
                                    .toString()
                                    : cubit.occasionDateController.text,
                                validator: (value) {
                                  if (value!.trim().isNotEmpty) return null;
                                  return AppLocalizations.of(context)!
                                      .translate('validateReceivingTime')
                                      .toString();
                                },
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                enable: false,
                                fillColor: ColorManager.gray),
                          ),

                          SizedBox(height: mediaQuery.height * 0.02),
                          Row(
                            mainAxisAlignment: CashHelper.languageKey == 'ar'
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              Text(
                                "${AppLocalizations.of(context)!.translate('isContainsNames').toString()} ",
                                style: TextStyles.textStyle12Bold
                                    .copyWith(color: ColorManager.black),
                              ),
                              Switch(
                                  value: cubit.giftContainsNameValue,
                                  onChanged: (value) {
                                    cubit.switchGiftContainsName();
                                  }),

                            ],
                          ),
                          SizedBox(height: mediaQuery.height * 0.02),


                          /// message
                          Text(
                            AppLocalizations.of(context)!.translate('giftCard').toString(),
                            style: TextStyles.textStyle18Bold
                                .copyWith(color: ColorManager.black),
                          ),
                          SizedBox(height: mediaQuery.height * 0.01),
                          DefaultTextField(
                              controller: cubit.moneyGiftMessageController,
                              maxLines: 8,
                              hintText: AppLocalizations.of(context)!.translate('giftCardHint').toString(),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return AppLocalizations.of(context)!.translate('validateGiftCard').toString();
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              fillColor: ColorManager.gray),
                          SizedBox(height: mediaQuery.height * 0.01),
                          /// note for send money fess
                          Text(
                            AppLocalizations.of(context)!.translate('moneyGiftFeesNote').toString(),
                            style: TextStyles.textStyle12Bold
                                .copyWith(color: ColorManager.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),



              /// delivery data
              Visibility(
                visible: cubit.isPresent== true || (cubit.isPresent ==false && cubit.giftWithPackage== true) ? true : false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// receiver name
                    Text(
                      AppLocalizations.of(context)!.translate('City').toString(),
                      style: TextStyles.textStyle18Bold
                          .copyWith(color: ColorManager.black),
                    ),
                    SizedBox(height: mediaQuery.height * 0.01),
                    DefaultTextField(
                        controller: cubit.giftDeliveryCityController,
                        hintText: AppLocalizations.of(context)!.translate('CityHint').toString(),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!.translate('validateCity').toString();
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        fillColor: ColorManager.gray),
                    /// receiver name
                    Text(
                      AppLocalizations.of(context)!.translate('theDistrict').toString(),
                      style: TextStyles.textStyle18Bold
                          .copyWith(color: ColorManager.black),
                    ),
                    SizedBox(height: mediaQuery.height * 0.01),
                    DefaultTextField(
                        controller: cubit.giftDeliveryStreetController,
                        hintText: AppLocalizations.of(context)!.translate('theDistrictHint').toString(),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!.translate('validateTheDistrict').toString();
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        fillColor: ColorManager.gray),
                    SizedBox(height: mediaQuery.height * 0.02),
                    /// receiver number
                    Text(
                      AppLocalizations.of(context)!.translate('moneyReceiverPhone').toString(),
                      style: TextStyles.textStyle18Bold
                          .copyWith(color: ColorManager.black),
                    ),
                    SizedBox(height: mediaQuery.height * 0.01),
                    DefaultTextField(
                        controller: cubit.giftReceiverNumberController,
                        hintText: AppLocalizations.of(context)!.translate('moneyReceiverPhoneHint').toString(),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!.translate('validateMoneyReceiverPhone').toString();
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        fillColor: ColorManager.gray),
                    SizedBox(height: mediaQuery.height * 0.02),
                    /// date of receive
                    Text(
                      AppLocalizations.of(context)!
                          .translate('receivingTime')
                          .toString(),
                      style: TextStyles.textStyle18Bold
                          .copyWith(color: ColorManager.black),
                    ),
                    SizedBox(height: mediaQuery.height * 0.01),
                    GestureDetector(
                      onTap: () {
                        showDatePicker(
                          helpText: AppLocalizations.of(context)!
                              .translate('receivingTime')
                              .toString(),
                          context: context,
                          firstDate: DateTime(1920),
                          lastDate: DateTime.now().add(const Duration(days: 365)),
                        ).then(
                                (value) => cubit.setMoneyReceiveDate(brithDateValue: value!));
                      },
                      child: DefaultTextField(
                          controller: cubit.moneyReceiveDateController,
                          hintText: cubit.moneyReceiveDateController.text.isEmpty
                              ? AppLocalizations.of(context)!
                              .translate('receivingTimeHint')
                              .toString()
                              : cubit.occasionDateController.text,
                          validator: (value) {
                            if (value!.trim().isNotEmpty) return null;
                            return AppLocalizations.of(context)!
                                .translate('validateReceivingTime')
                                .toString();
                          },
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          enable: false,
                          fillColor: ColorManager.gray),
                    ),

                    SizedBox(height: mediaQuery.height * 0.02),
                    Row(
                      mainAxisAlignment: CashHelper.languageKey == 'ar'
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        Text(
                          "${AppLocalizations.of(context)!.translate('isContainsNames').toString()} ",
                          style: TextStyles.textStyle12Bold
                              .copyWith(color: ColorManager.black),
                        ),
                        Switch(
                            value: cubit.giftContainsNameValue,
                            onChanged: (value) {
                              cubit.switchGiftContainsName();
                            }),

                      ],
                    ),
                    SizedBox(height: mediaQuery.height * 0.02),


                    /// message
                    Text(
                      AppLocalizations.of(context)!.translate('giftCard').toString(),
                      style: TextStyles.textStyle18Bold
                          .copyWith(color: ColorManager.black),
                    ),
                    SizedBox(height: mediaQuery.height * 0.01),
                    DefaultTextField(
                        controller: cubit.moneyGiftMessageController,
                        maxLines: 8,
                        hintText: AppLocalizations.of(context)!.translate('giftCardHint').toString(),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!.translate('validateGiftCard').toString();
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        fillColor: ColorManager.gray),

                    SizedBox(height: mediaQuery.height * 0.02),

                    /// note
                    Text(
                      AppLocalizations.of(context)!.translate('note').toString(),
                      style: TextStyles.textStyle18Bold
                          .copyWith(color: ColorManager.black),
                    ),
                    SizedBox(height: mediaQuery.height * 0.01),
                    DefaultTextField(
                        controller: cubit.giftDeliveryNoteController,
                        maxLines: 8,
                        hintText: AppLocalizations.of(context)!.translate('noteHint').toString(),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!.translate('validateNote').toString();
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        fillColor: ColorManager.gray),
                  ],
                ),
              ),


              SizedBox(height: mediaQuery.height * 0.05),

              ///  continue button
              Center(
                child: GestureDetector(
                  onTap: () {
                    if (cubit.forMeFormKey.currentState!.validate()) {
                      if (cubit.isPresent) {
                        customPushNavigator(
                            context,
                            GiftScreen());
                      } else {
                        customPushNavigator(
                            context,
                            MoneyScreen());
                      }
                    }
                  },
                  child: Container(
                    height: mediaQuery.height * .06,
                    width: mediaQuery.width * .5,
                    decoration: BoxDecoration(
                      color: ColorManager.primaryBlue,
                      borderRadius:
                          BorderRadius.circular(mediaQuery.height * 0.05),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!
                              .translate('continue')
                              .toString(),
                          style: TextStyles.textStyle18Bold
                              .copyWith(color: ColorManager.white),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
