import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mentalhealth/configs/chat_list_model.dart';
import 'package:mentalhealth/configs/state_model.dart';
import 'package:mentalhealth/controllers/get_conversation.dart';
import 'package:mentalhealth/controllers/therapist_user.dart';
import 'package:mentalhealth/global/constants/colors_text.dart';
import 'package:mentalhealth/global/reuseable/formfield.dart';
import 'package:mentalhealth/views/home/chat/chat_screen.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final details = ref.watch(therapistUserControllerProvider);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Chats",
                style: textPoppions.titleMedium?.copyWith(
                    fontSize: 20.sp,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 12.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                decoration: BoxDecoration(
                    color: AppColors.pureWhiteColor,
                    borderRadius: BorderRadius.circular(8.r)),
                child: TextField(
                  readOnly: true,
                  onTap: () {
                    context.push('/search');
                  },
                  controller: TextEditingController(),
                  decoration: InputDecoration(
                    hintText: 'Search......',
                    hintStyle: textPoppions.headlineMedium?.copyWith(
                      color: AppColors.iconColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              Builder(builder: (context) {
                switch (details.requestStatus) {
                  case RequestStatus.initial:
                    return Center(child: Container());
                  case RequestStatus.progress:
                    return Center(child: Container());
                  case RequestStatus.success:
                    return ChatUserData(data: details.data);
                  case RequestStatus.failure:
                    return Center(
                      child: Text(
                        "Something went wrong",
                        style: textPoppions.titleMedium?.copyWith(
                            fontSize: 12.sp,
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.bold),
                      ),
                    );
                  case RequestStatus.fetchingMore:
                    return Container();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatUserData extends ConsumerWidget {
  final List<ChatList> data;
  const ChatUserData({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        final item = data[index];
        return Column(
          children: [
            GestureDetector(
              onTap: () {
                ref
                    .read(conversationControllerProvider.notifier)
                    .getConversations(item.conversationId);
                context.push("/chat",
                    extra: ConversationData(
                        conversationId: item.conversationId,
                        name: "${item.firstName}${item.lastName}"));
              },
              child: ListTile(
                minVerticalPadding: 0,
                contentPadding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                title: Text(
                  "${item.firstName} ",
                  style: textPoppions.titleMedium?.copyWith(
                      fontSize: 16.sp,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  item.specialization.toString(),
                  style: textPoppions.titleMedium?.copyWith(
                      fontSize: 14.sp,
                      color: AppColors.iconColor,
                      fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(
                  Icons.chat,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            Divider(
              color: AppColors.greyColor,
            )
          ],
        );
      },
    );
  }
}
