import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_app/featuers/auth/presentation/controller/auth_cubit.dart';
import 'package:hadawi_app/featuers/auth/presentation/controller/auth_states.dart';
import 'package:hadawi_app/featuers/auth/presentation/view/Login/widgets/donot_have_an_account.dart';
import 'package:hadawi_app/featuers/auth/presentation/view/Login/widgets/forget_password_button.dart';
import 'package:hadawi_app/featuers/auth/presentation/view/Login/widgets/login_with_social_button.dart';
import 'package:hadawi_app/featuers/home_layout/presentation/view/home_layout/home_layout.dart';
import 'package:hadawi_app/styles/colors/color_manager.dart';
import 'package:hadawi_app/styles/text_styles/text_styles.dart';
import 'package:hadawi_app/utiles/helper/material_navigation.dart';
import 'package:hadawi_app/widgets/default_button.dart';
import 'package:hadawi_app/widgets/default_text_field.dart';
import 'package:hadawi_app/widgets/toast.dart';

class LoginFormWidget extends StatelessWidget {
   LoginFormWidget({super.key, required this.phoneController, required this.passController});
  final TextEditingController phoneController ;
  final TextEditingController passController ;

  GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.sizeOf(context).height*0.03),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: ColorManager.white,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: loginKey,
          child: Column(
            children: [

              Text('Sign in',style: TextStyles.textStyle24Bold),

              SizedBox( height:  MediaQuery.sizeOf(context).height*0.035,),

              // phone number
              DefaultTextField(
                  controller: phoneController,
                  hintText: 'Enter your phone number',
                  validator: (value) {
                    if(value.isEmpty){
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  fillColor: ColorManager.gray
              ),

              SizedBox( height:  MediaQuery.sizeOf(context).height*0.03,),

              // password
              DefaultTextField(
                  viewPassword: true,
                  withSuffix: true,
                  controller: passController,
                  hintText: 'Enter your password',
                  validator: (value) {
                    if(value.isEmpty){
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  fillColor: ColorManager.gray
              ),

              SizedBox( height:  MediaQuery.sizeOf(context).height*0.01,),

              // forget password
              ForgetPasswordButton(),

              SizedBox( height:  MediaQuery.sizeOf(context).height*0.045,),

              // sign in
              BlocConsumer<AuthCubit,AuthStates>(
                listener: (context, state) {
                  if(state is UserLoginSuccessState){
                    customPushNavigator(context, HomeLayout());
                  }
                  if(state is UserLoginErrorState){
                    customToast(title: state.message, color: ColorManager.primaryBlue);
                  }
                },
                builder: (context, state) {
                  var cubit = context.read<AuthCubit>();
                  return state is UserLoginLoadingState?
                  const Center(child: CircularProgressIndicator(),):
                  DefaultButton(
                      buttonText: 'Sign in',
                      onPressed: (){
                        if(loginKey.currentState!.validate()){
                          cubit.login(
                              email: phoneController.text,
                              password: passController.text
                          );
                        }
                      },
                      buttonColor: ColorManager.primaryBlue
                  );
                }
              ),

              SizedBox( height:  MediaQuery.sizeOf(context).height*0.03,),

              Text('Or',style: TextStyles.textStyle18Bold.copyWith(
                  color: ColorManager.darkGrey
              )),

              SizedBox( height:  MediaQuery.sizeOf(context).height*0.03,),

              // login with social
              LoginWithSocialButton(),

              SizedBox( height:  MediaQuery.sizeOf(context).height*0.035,),

              // don't have an account
              DonotHaveAnAccount(),

            ],
          ),
        ),
      ),
    );
  }
}
