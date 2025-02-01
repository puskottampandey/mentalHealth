import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentalhealth/configs/post_model.dart';
import 'package:mentalhealth/configs/state_model.dart';
import 'package:mentalhealth/controllers/get_post_controller.dart';
import 'package:mentalhealth/controllers/like_post.dart';
import 'package:mentalhealth/controllers/user_data.dart';
import 'package:mentalhealth/global/constants/colors_text.dart';
import 'package:mentalhealth/global/reuseable/snackbar.dart';
import 'package:mentalhealth/global/services/token_service.dart';
import 'package:mentalhealth/views/home/personal/post_entry.dart';
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommunityScreen extends ConsumerStatefulWidget {
  const CommunityScreen({super.key});

  @override
  ConsumerState<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends ConsumerState<CommunityScreen> {
  @override
  Widget build(BuildContext context) {
    final details = ref.watch(postListControllerProvider);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 4.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          showModalBottomSheet(
                              backgroundColor: AppColors.whiteColor,
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return Padding(
                                    padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom, // Adjust for keyboard
                                    ),
                                    child: SingleChildScrollView(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 16.h, horizontal: 16.w),
                                        child: const Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CreatePost(),
                                          ],
                                        ),
                                      ),
                                    ));
                              });
                        },
                        icon: const Icon(
                          Icons.add,
                          color: AppColors.primaryColor,
                        )),
                    Text(
                      "Post",
                      style: textPoppions.titleMedium?.copyWith(
                          fontSize: 14.sp,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
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
                    return PostListDetails(data: details.data);
                  case RequestStatus.failure:
                    return Center(
                      child: Text(
                        "No post list ",
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

class PostListDetails extends ConsumerStatefulWidget {
  final List<PostModel> data;
  const PostListDetails({
    super.key,
    required this.data,
  });

  @override
  ConsumerState<PostListDetails> createState() => _PostListDetailsState();
}

class _PostListDetailsState extends ConsumerState<PostListDetails> {
  late HubConnection hubConnection;
  TextEditingController messageController = TextEditingController();
  final String message = '';
  @override
  void initState() {
    super.initState();
    _initializeSignalR();
  }

  Future<void> _initializeSignalR() async {
    final token = await TokenService().getToken();

    hubConnection = HubConnectionBuilder()
        .withUrl(
          "https://mint-publicly-seagull.ngrok-free.app/posthub",
          options: HttpConnectionOptions(
            accessTokenFactory: () async => "$token",
          ),
        )
        .build();

    await hubConnection.start();

    hubConnection.on("ReceiveNotification", (arguments) {
      setState(() {
        if (arguments != null && arguments.isNotEmpty && arguments[0] != null) {
          SnackBars.successSnackbar(context, arguments[0].toString());
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final id = ref.watch(userId);
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.data.length,
      itemBuilder: (context, int index) {
        final item = widget.data[index];
        return Card(
          elevation: 0,
          color: AppColors.pureWhiteColor,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 8.h,
              horizontal: 10.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${item.user!.userName}",
                  style: textPoppions.titleMedium?.copyWith(
                      fontSize: 16.sp,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  timeago.format(
                      DateTime.parse(item.createdAt.toString()).toLocal()),
                  style: textPoppions.titleMedium?.copyWith(
                      fontSize: 12.sp,
                      color: AppColors.iconColor,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  item.title.toString(),
                  style: textPoppions.titleMedium?.copyWith(
                      fontSize: 15.sp,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  item.content.toString(),
                  style: textPoppions.titleMedium?.copyWith(
                      fontSize: 14.sp,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.bold),
                ),
                const Divider(
                  color: AppColors.iconColor,
                ),
                Row(
                  children: [
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      color: AppColors.iconColor,
                      padding: EdgeInsets.zero,
                      onPressed: () async {
                        final response = await ref
                            .read(likePostControllerProvider.notifier)
                            .likePost(item.id, id);

                        if (response != null) {
                          final int newLikeCount =
                              response['likeCount']['likeCount'];
                          final bool isLikedByUser = response['isLikedByUser'];

                          setState(() {
                            item.likesCount = newLikeCount;
                            item.isLikedByUser = isLikedByUser;
                          });
                        }
                      },
                      icon: Icon(
                        item.isLikedByUser
                            ? Icons.thumb_up
                            : Icons.thumb_up_alt_outlined,
                        color: item.isLikedByUser
                            ? Colors.blue
                            : AppColors.iconColor,
                      ),
                    ),
                    Text(
                      item.likesCount.toString(),
                      style: textPoppions.titleMedium?.copyWith(
                          fontSize: 14.sp,
                          color: AppColors.iconColor,
                          fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      color: AppColors.iconColor,
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.comment,
                      ),
                    ),
                    Text(
                      item.commentsCount.toString(),
                      style: textPoppions.titleMedium?.copyWith(
                          fontSize: 14.sp,
                          color: AppColors.iconColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
