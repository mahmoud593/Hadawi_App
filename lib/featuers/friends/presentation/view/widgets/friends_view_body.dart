import 'package:flutter/cupertino.dart';
import 'package:hadawi_app/featuers/profile/presentation/view/widgets/profile_row_widget.dart';
import 'package:hadawi_app/featuers/profile/presentation/view/widgets/row_data_widget.dart';
import 'package:hadawi_app/styles/assets/asset_manager.dart';

class FriendsViewBody extends StatelessWidget {
  const FriendsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [

          SizedBox(height: MediaQuery.sizeOf(context).height*0.07,),

          // اصدقاء اتابعهم
          ProfileRowWidget(image: '', title: 'اصدقاء اتابعهم'),

          SizedBox(height: MediaQuery.sizeOf(context).height*0.045,),

          // الاصدقاء يتابعوني
          ProfileRowWidget(image: '', title: 'اصدقاء يتابعوني',),

          SizedBox(height: MediaQuery.sizeOf(context).height*0.045,),

          // طلبات الصداقه
          ProfileRowWidget(image: '', title: 'طلبات المتابعه',),

          SizedBox(height: MediaQuery.sizeOf(context).height*0.045,),

          // الاصدقاء المشاركين بهديتي
          ProfileRowWidget(image: '', title: 'الاصدقاء المشاركين بهديتي',),

          SizedBox(height: MediaQuery.sizeOf(context).height*0.045,),

          // دعوه اصدقاء
          ProfileRowWidget(image: '', title: 'دعوه اصدقاء'),

          SizedBox(height: MediaQuery.sizeOf(context).height*0.045,),

        ],
      ),
    );
  }
}
