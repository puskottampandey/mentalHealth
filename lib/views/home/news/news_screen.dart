import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mentalhealth/configs/chat_list_model.dart';
import 'package:mentalhealth/configs/coversation_user_list.dart';
import 'package:mentalhealth/configs/state_model.dart';
import 'package:mentalhealth/controllers/get_conversation.dart';
import 'package:mentalhealth/controllers/get_conversations.dart';
import 'package:mentalhealth/global/constants/colors_text.dart';
import 'package:mentalhealth/views/home/chat/chat_screen.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../controllers/user_data.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final details = ref.watch(conversionListControllerProvider);
    final id = ref.watch(userId);
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
                    return const Center(
                        child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ));
                  case RequestStatus.progress:
                    return const Center(
                        child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ));
                  case RequestStatus.success:
                    return ChatUserData(data: details.data);
                  case RequestStatus.failure:
                    print(details.message);
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
  final List<ConversionUpdate> data;
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
        bool? check = item.recentMessage!.isRead;
        return Column(
          children: [
            GestureDetector(
              onTap: () {
                ref
                    .read(conversationControllerProvider.notifier)
                    .getConversations(item.conversationId);
                context.push("/chat",
                    extra: ConversationData(
                        conversationId: item.conversationId.toString(),
                        name: "${item.name}"));
              },
              child: ListTile(
                minVerticalPadding: 0,
                contentPadding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                title: Text(
                  "${item.name} ",
                  style: textPoppions.titleMedium?.copyWith(
                      fontSize: 16.sp,
                      color: AppColors.blackColor,
                      fontWeight: check! ? FontWeight.w400 : FontWeight.bold),
                ),
                subtitle: Row(
                  children: [
                    Text(
                      "${item.recentMessage!.message.toString()}.  ",
                      style: textPoppions.titleMedium?.copyWith(
                          fontSize: 14.sp,
                          color: check!
                              ? AppColors.iconColor
                              : AppColors.blackColor,
                          fontWeight:
                              check ? FontWeight.w400 : FontWeight.bold),
                    ),
                    Text(
                      timeago.format(
                          DateTime.parse(item.lastActiveAt.toString())
                              .toLocal()),
                      style: textPoppions.titleMedium?.copyWith(
                          fontSize: 12.sp,
                          color: check!
                              ? AppColors.iconColor
                              : AppColors.blackColor,
                          fontWeight:
                              check ? FontWeight.w400 : FontWeight.bold),
                    ),
                  ],
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
