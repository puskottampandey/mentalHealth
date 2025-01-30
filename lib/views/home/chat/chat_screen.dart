import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentalhealth/controllers/chat_controller.dart';
import 'package:mentalhealth/global/constants/colors_text.dart';
import 'package:mentalhealth/global/reuseable/scaffold.dart';
import 'package:mentalhealth/global/services/token_service.dart';
import 'package:signalr_netcore/signalr_client.dart';

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
  late HubConnection hubConnection;
  TextEditingController messageController = TextEditingController();
  List<String> messages = [];

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
        messages.insert(0, arguments![1].toString());
      });
      messageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ReuseableScaffold(
        appbar: true,
        text: widget.param.name,
        back: true,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: const EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              messages[index],
                              style: textPoppions.headlineMedium?.copyWith(
                                color: AppColors.blackColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ));
                  },
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
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
                        ref
                            .read(sendMessageControllerProvider.notifier)
                            .sendMessage(widget.param.conversationId,
                                messageController.text);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Column(
          //   children: [
          //     Expanded(
          //       child: ListView.builder(
          //         itemCount: messages.length,
          //         itemBuilder: (context, index) {
          //           return ListTile(
          //             title: Text(messages[index]),
          //           );
          //         },
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Row(
          //         children: [
          //           Expanded(
          //             child: TextField(
          //               controller: messageController,
          //               decoration: const InputDecoration(
          //                 hintText: 'Enter your message',
          //               ),
          //             ),
          //           ),
          //           IconButton(
          //             icon: const Icon(Icons.send),
          //             onPressed: () {
          //               ref
          //                   .read(sendMessageControllerProvider.notifier)
          //                   .sendMessage(widget.param, messageController.text);
          //             },
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
        ));
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
