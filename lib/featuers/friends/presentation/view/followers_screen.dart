import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_app/featuers/friends/presentation/controller/firends_states.dart';
import 'package:hadawi_app/featuers/friends/presentation/controller/friends_cubit.dart';
import 'package:hadawi_app/featuers/friends/presentation/view/widgets/followers_occasions.dart';
import 'package:hadawi_app/featuers/visitors/presentation/view/widgets/occasion_details.dart';
import 'package:hadawi_app/styles/assets/asset_manager.dart';
import 'package:hadawi_app/styles/colors/color_manager.dart';
import 'package:hadawi_app/styles/text_styles/text_styles.dart';
import 'package:hadawi_app/utiles/localiztion/app_localization.dart';
import 'package:hadawi_app/utiles/shared_preferences/shared_preference.dart';
import 'package:hadawi_app/widgets/default_app_bar_widget.dart';
import 'package:hadawi_app/widgets/toast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class FollowersScreen extends StatefulWidget {
  const FollowersScreen({super.key});

  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<FriendsCubit>()
        .getFollowers(userId: UserDataFromStorage.uIdFromStorage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: defaultAppBarWidget(
            appBarTitle: AppLocalizations.of(context)!
                .translate('friendsFollowMe')
                .toString()),
        body: BlocConsumer<FriendsCubit, FriendsStates>(
          listener: (context, state) {
            if (state is GetFollowersErrorState) {
              customToast(title: state.message, color: ColorManager.error);
            }
          },
          builder: (context, state) {
            var cubit = context.read<FriendsCubit>();
            return ModalProgressHUD(
              inAsyncCall: state is GetFollowersLoadingState,
              child: SingleChildScrollView(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: cubit.followers.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 0,
                    );
                  },
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      cubit
                          .getUserOccasions(
                              userId: cubit.followers[index].userId)
                          .then(
                        (value) async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) => cubit,
                                child: FollowersOccasions(
                                  followersId: cubit.followers[index].userId,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.sizeOf(context).height * 0.02,
                          vertical: MediaQuery.sizeOf(context).height * 0.01),
                      height: MediaQuery.sizeOf(context).height * 0.1,
                      decoration: BoxDecoration(
                        color: ColorManager.gray,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Row(children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 25,
                          child: CircleAvatar(
                            radius: 23,
                            child: Image(
                              image: AssetImage(
                                AssetsManager.userIcon,
                              ),
                              height: MediaQuery.sizeOf(context).height * 0.04,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).height * 0.02,
                        ),
                        Expanded(
                          child: Text(cubit.followers[index].userName,
                              style: TextStyles.textStyle18Medium
                                  .copyWith(color: ColorManager.black)),
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
