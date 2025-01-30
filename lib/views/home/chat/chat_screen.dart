import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentalhealth/configs/state_model.dart';
import 'package:mentalhealth/controllers/chat_controller.dart';
import 'package:mentalhealth/controllers/get_conversation.dart';
import 'package:mentalhealth/controllers/user_data.dart';
import 'package:mentalhealth/global/constants/colors_text.dart';
import 'package:mentalhealth/global/reuseable/scaffold.dart';
import 'package:mentalhealth/global/services/token_service.dart';
import 'package:mentalhealth/views/home/home/therapist_data.dart';
import 'package:signalr_netcore/signalr_client.dart';

import '../../../configs/conversation_history.dart';

final chatMessage = StateProvider((ref) => []);

class ConversationData {
  final String conversationId;
  final String name;

  ConversationData({required this.conversationId, required this.name});
}

class ChatScreen extends ConsumerStatefulWidget {
  final ConversationData param;
  const ChatScreen({
    super.key,
    required this.param,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final ScrollController _scrollController = ScrollController();
  late HubConnection hubConnection;
  TextEditingController messageController = TextEditingController();

  List<Map<String, String>> messages = [];
  @override
  void initState() {
    super.initState();
    _initializeSignalR();
  }

  Future<void> _initializeSignalR() async {
    final token = await TokenService().getToken();

    hubConnection = HubConnectionBuilder()
        .withUrl(
          "https://mint-publicly-seagull.ngrok-free.app/chathub",
          options: HttpConnectionOptions(
            accessTokenFactory: () async => "$token",
          ),
        )
        .build();

    await hubConnection.start();

    hubConnection.on('ReceiveMessage', (arguments) {
      setState(() {
        messages.insert(0, {
          "sender": arguments![0].toString(),
          "message": arguments[1].toString()
        });
      });
      messageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final details = ref.watch(conversationControllerProvider);
    final userid = ref.watch(userId);
    // final ConversationHistoryList feed = details.data;
    // for (var name in feed.messages) {
    //   print(name.messageContent.toString());
    //   messages.add(name.messageContent.toString()); // This will print each name
    // }

    return ReuseableScaffold(
      appbar: true,
      text: widget.param.name,
      back: true,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller:
                    _scrollController, // Scroll controller for synchronization
                child: Column(
                  children: [
                    Builder(builder: (context) {
                      switch (details.requestStatus) {
                        case RequestStatus.initial:
                          return Center(child: Container());
                        case RequestStatus.progress:
                          return Center(child: Container());
                        case RequestStatus.success:
                          return HistoryMessage(data: details.data, id: userid);
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
                    ListView.builder(
                      controller:
                          _scrollController, // Same scroll controller to sync scroll
                      physics: const NeverScrollableScrollPhysics(),
                      reverse: true,
                      shrinkWrap: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final msg = messages[index];
                        bool isMe = msg["sender"] == userid;
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 6.h),
                          child: Align(
                            alignment: isMe
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: isMe
                                    ? Colors.blue.shade100
                                    : Colors.blue.shade300,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                msg["message"]!,
                                style: textPoppions.headlineMedium?.copyWith(
                                  color: AppColors.blackColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              color: Colors.grey[200],
              child: Row(
                children: [
                  // Text input
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      decoration: BoxDecoration(
                          color: AppColors.pureWhiteColor,
                          borderRadius: BorderRadius.circular(8.r)),
                      child: TextField(
                        controller: messageController,
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          hintStyle: textPoppions.headlineMedium?.copyWith(
                            color: AppColors.iconColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  // Send button
                  IconButton(
                    icon: const Icon(
                      Icons.send,
                      color: AppColors.primaryColor,
                    ),
                    onPressed: () {
                      if (messageController.text.trim().isNotEmpty) {
                        ref
                            .read(sendMessageControllerProvider.notifier)
                            .sendMessage(widget.param.conversationId,
                                messageController.text);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HistoryMessage extends StatelessWidget {
  final ConversationHistoryList data;
  final String id;
  const HistoryMessage({
    super.key,
    required this.data,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      reverse: true,
      shrinkWrap: true,
      itemCount: data.messages.length,
      itemBuilder: (context, index) {
        final msg = data.messages[index];
        bool isMe = msg.senderId == id;
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
            child: Align(
              alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: isMe ? Colors.blue.shade100 : Colors.blue.shade300,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  data.messages[index].messageContent.toString(),
                  style: textPoppions.headlineMedium?.copyWith(
                    color: AppColors.blackColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ));
      },
    );
  }
}
// class ChatScreen extends StatefulWidget {
//   final String? data;
//   const ChatScreen({
//     super.key,
//     this.data,
//   });

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// final List<String> chatlist = [];
// final controller = TextEditingController();

// class _ChatScreenState extends State<ChatScreen> {
//   final hubConnection =
//       HubConnectionBuilder().withUrl('https://your-signalr-hub-url').build();

//   TextEditingController messageController = TextEditingController();
//   List<String> messages = [];

//   @override
//   void initState() {
//     super.initState();

//     _startHubConnection();

//     hubConnection.on('ReceiveMessage', _handleReceivedMessage);
//   }

//   void _startHubConnection() async {
//     try {
//       await hubConnection.start();
//     } catch (e) {}
//   }

//   void _handleReceivedMessage(List<Object?> arguments) {
//     String user = arguments[0] ?? '';
//     String message = arguments[1] ?? '';

//     setState(() {
//       messages.add('$user: $message');
//     });
//   }

//   void _sendMessage() {
//     String user = 'You';
//     String message = messageController.text;
//     hubConnection.invoke('SendMessage', args: [user, message]);
//     messageController.text = '';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ReuseableScaffold(
//       appbar: true,
//       text: widget.data,
//       back: true,
//       child: Padding(
//         padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 reverse: true,
//                 itemCount: chatlist.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
//                       child: Align(
//                         alignment: Alignment.centerRight,
//                         child: Container(
//                           padding: const EdgeInsets.all(12.0),
//                           decoration: BoxDecoration(
//                             color: Colors.blue.shade100,
//                             borderRadius: BorderRadius.circular(8.r),
//                           ),
//                           child: Text(
//                             chatlist[index],
//                             style: textPoppions.headlineMedium?.copyWith(
//                               color: AppColors.blackColor,
//                               fontSize: 14.sp,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ));
//                 },
//               ),
//             ),
//             SizedBox(
//               height: 10.h,
//             ),
//             Container(
//               color: Colors.grey[200],
//               child: Row(
//                 children: [
//                   // Text input
//                   Expanded(
//                     child: Container(
//                       padding: EdgeInsets.symmetric(horizontal: 8.w),
//                       decoration: BoxDecoration(
//                           color: AppColors.pureWhiteColor,
//                           borderRadius: BorderRadius.circular(8.r)),
//                       child: TextField(
//                         controller: controller,
//                         decoration: InputDecoration(
//                           hintText: 'Type a message...',
//                           hintStyle: textPoppions.headlineMedium?.copyWith(
//                             color: AppColors.iconColor,
//                             fontSize: 12.sp,
//                             fontWeight: FontWeight.w600,
//                           ),
//                           border: InputBorder.none,
//                         ),
//                         onSubmitted: (value) => _sendMessage(),
//                       ),
//                     ),
//                   ),
//                   // Send button
//                   IconButton(
//                     icon: const Icon(
//                       Icons.send,
//                       color: AppColors.primaryColor,
//                     ),
//                     onPressed: _sendMessage,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _sendMessage() {
//     if (controller.text.trim().isEmpty) return;

//     setState(() {
//       chatlist.insert(0, controller.text.trim());
//     });

//     controller.clear();
//   }
// }
