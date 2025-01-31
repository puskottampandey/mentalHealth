import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mentalhealth/controllers/get_post_controller.dart';
import 'package:mentalhealth/controllers/therapist_user.dart';
import 'package:mentalhealth/controllers/user_data.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../global/constants/colors_text.dart';
import '../../../global/reuseable/scaffold.dart';
import '../../../global/utils/greeting_time.dart';
import '../home/home_screen.dart';
import '../news/news_screen.dart';
import '../personal/personal_screen.dart';
import '../profile/profile_screen.dart';

final currentIndexProvider = StateProvider((ref) => 0);

class MainHomeScreen extends ConsumerWidget {
  MainHomeScreen({super.key});

  final List<Widget> screens = [
    HomeScreen(),
    const ChatScreen(),
    const CommunityScreen(),
    const ProfileScreen(),
  ];

  final iconList = [
    Icons.home,
    Icons.cyclone,
    Icons.pie_chart,
    Icons.person,
  ];
  final iconName = [
    "Home",
    "Trasaction",
    "Budget",
    "Profile",
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);
    final id = ref.watch(userId);
    return ReuseableScaffold(
        appbar: true,
        text: "Hey, ${GreetingUtils().greeting()}",
        bottomnavigation: true,
        center: false,
        back: false,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications,
              ))
        ],
        bottomnavigationWidget: SalomonBottomBar(
          itemPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          backgroundColor: AppColors.pureWhiteColor,
          currentIndex: currentIndex,
          onTap: (index) async {
            ref.read(currentIndexProvider.notifier).state = index;
            if (index == 1) {
              ref
                  .read(therapistUserControllerProvider.notifier)
                  .therapistUser(id);
            }
            if (index == 2) {
              ref.read(postListControllerProvider.notifier).getPostList();
            }
            if (index == 3) {
              ref.read(userDataControllerProvider.notifier).userData();
            }
          },
          items: [
            salomonBar(currentIndex, Icons.home, "Home", 0),
            salomonBar(currentIndex, Icons.chat, "Chat", 1),
            salomonBar(currentIndex, Icons.history, "History", 2),
            salomonBar(currentIndex, Icons.person, "Profile", 3),
          ],
        ),
        child: screens[currentIndex]);
  }

  SalomonBottomBarItem salomonBar(
      int currentIndex, IconData icon, String text, int index) {
    return SalomonBottomBarItem(
      selectedColor: const Color.fromARGB(255, 107, 239, 107),
      icon: Icon(
        icon,
        size: 22.sp,
        color: currentIndex == index
            ? AppColors.primaryColor
            : AppColors.iconColor,
      ),
      title: Text(
        text,
        style: textPoppions.titleMedium?.copyWith(
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor),
      ),
    );
  }

  Container decoratedContainer({
    Color? color,
    String? icon,
    Function()? ontap,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 4.h,
        horizontal: 4.w,
      ),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: ontap,
        icon: SvgPicture.asset(
          icon!,
          colorFilter: const ColorFilter.mode(
            kvverylightColor,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
