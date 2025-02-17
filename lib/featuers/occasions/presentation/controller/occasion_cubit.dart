import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_app/featuers/occasions/data/repo_imp/occasion_repo_imp.dart';
import 'package:hadawi_app/featuers/occasions/domain/entities/occastion_entity.dart';
import 'package:hadawi_app/utiles/shared_preferences/shared_preference.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

part 'occasion_state.dart';

class OccasionCubit extends Cubit<OccasionState> {
  OccasionCubit() : super(OccasionInitial());

  bool isForMe = true;
  bool isPresent = true;
  bool isMoney = false;
  int selectedIndex = 0;
  bool bySharingValue = false;
  int giftPrice = 0;
  String giftType = 'هدية';
  GlobalKey<FormState> forMeFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> forOtherFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> moneyFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> giftFormKey = GlobalKey<FormState>();
  TextEditingController giftNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController occasionDateController = TextEditingController();
  TextEditingController moneyAmountController = TextEditingController();
  TextEditingController occasionNameController = TextEditingController();
  TextEditingController newOccasionNameController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  TextEditingController ibanNumberController = TextEditingController();
  TextEditingController accountOwnerNameController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();

  void switchForWhomOccasion() {
    if (isForMe) {
      isForMe = false;
      selectedIndex = 1;
      UserDataFromStorage.setIsForMe(false);
      debugPrint('isForMe $isForMe');
    } else {
      isForMe = true;
      selectedIndex = 0;
      UserDataFromStorage.setIsForMe(true);
      debugPrint('isForMe $isForMe');
    }
    emit(SwitchForWhomOccasionSuccess());
  }

  void switchGiftType() {
    isPresent = !isPresent;
    isMoney = !isMoney;

    emit(SwitchGiftTypeSuccess());
  }

  void switchBySharing() {
    bySharingValue = !bySharingValue;
    emit(SwitchBySharingSuccess());
  }

  void setOccasionDate({required DateTime brithDateValue}) {
    occasionDateController.text =
        DateFormat('yyyy-MM-dd').format(brithDateValue);
    emit(SetOccasionDateState());
  }

  var picker = ImagePicker();

  File? image;

  Future<void> pickGiftImage() async {
    emit(PickImageLoadingState());
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
      emit(PickImageSuccessState());
    } else {
      emit(PickImageErrorState());
    }
    emit(PickImageErrorState());
  }

  void removeImage() {
    image = null;
    emit(RemovePickedImageSuccessState());
  }

  Future<String> uploadImage() async {
    emit(UploadImageLoadingState());
    try {
      final uploadTask = await firebase_storage.FirebaseStorage.instance
          .ref()
          .child('giftImages/${Uri.file(image!.path).pathSegments.last}')
          .putFile(image!);

      final downloadUrl = await uploadTask.ref.getDownloadURL();

      emit(UploadImageSuccessState());
      return downloadUrl;
    } catch (error) {
      emit(UploadImageErrorState());
      throw Exception("Failed to upload image: $error");
    }
  }

  Future<void> addOccasion() async {
    emit(AddOccasionLoadingState());

    try {
      final String? imageUrl = UserDataFromStorage.giftType == '' ||
              UserDataFromStorage.giftType == 'هدية'
          ? await uploadImage()
          : null;
      final result = await OccasionRepoImp().addOccasions(
        isForMe: UserDataFromStorage.isForMe==true?true:UserDataFromStorage.isForMe,
        occasionName: UserDataFromStorage.occasionName,
        occasionDate: UserDataFromStorage.occasionDate,
        occasionType: UserDataFromStorage.isForMe ? 'مناسبة لى' : 'مناسبة لآخر',
        moneyGiftAmount: 0,
        personId: UserDataFromStorage.uIdFromStorage,
        personName: nameController.text.isEmpty ? UserDataFromStorage.userNameFromStorage : nameController.text,
        personPhone: UserDataFromStorage.phoneNumberFromStorage,
        personEmail: UserDataFromStorage.emailFromStorage,
        giftImage: imageUrl ?? '',
        giftName: giftNameController.text.isEmpty ? '' : giftNameController.text,
        giftLink: linkController.text.isEmpty ? '' : linkController.text,
        giftPrice: giftPrice == 0 ? int.parse(moneyAmountController.text) : giftPrice,
        giftType: UserDataFromStorage.giftType==""? 'هدية':UserDataFromStorage.giftType,
        isSharing: bySharingValue,
      );
      result.fold((failure) {
        emit(AddOccasionErrorState(error: failure.message));
      }, (occasion) {
        emit(AddOccasionSuccessState(occasion: occasion));
      });
    } catch (error) {
      debugPrint('*************');
      debugPrint('error: $error');
      emit(AddOccasionErrorState(error: error.toString()));
    }
  }

}
