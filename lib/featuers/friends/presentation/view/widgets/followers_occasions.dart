import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_app/featuers/friends/presentation/controller/firends_states.dart';
import 'package:hadawi_app/featuers/friends/presentation/controller/friends_cubit.dart';
import 'package:hadawi_app/styles/colors/color_manager.dart';
import 'package:hadawi_app/styles/text_styles/text_styles.dart';
import 'package:hadawi_app/widgets/default_app_bar_widget.dart';

class FollowersOccasions extends StatelessWidget {
  final String followersId;
  const FollowersOccasions({super.key, required this.followersId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FriendsCubit ,FriendsStates>(
  builder: (context, state) {
    final cubit = context.read<FriendsCubit>();
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: defaultAppBarWidget(
        appBarTitle: '',
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount( mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.1
              ),
          itemBuilder: (context, index) {
            return Container(
              height: MediaQuery.sizeOf(context).height * 0.25,
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.gray.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.06,
                    decoration: BoxDecoration(
                      color: ColorManager.primaryBlue,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        cubit.userOccasions[index].occasionName,
                        style: TextStyles.textStyle18Regular
                            .copyWith(color: ColorManager.white),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      child: CachedNetworkImage(
                        width: cubit.userOccasions[index].giftImage.isEmpty
                            ? MediaQuery.sizeOf(context).width * 0.25
                            : double.infinity,
                        fit: BoxFit.cover,
                        imageUrl: cubit.userOccasions[index].giftImage,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) {
                          return cubit.userOccasions[index].giftImage.isEmpty &&
                              cubit.userOccasions[index].giftType == 'مبلغ مالي'
                              ? Image.asset(
                            'assets/images/money_bag.png',
                            fit: BoxFit.contain,
                          )
                              : const Icon(
                            Icons.error,
                            color: Colors.red,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          itemCount: cubit.userOccasions.length,
        ),
      ),
    );
  },
);
  }
}
