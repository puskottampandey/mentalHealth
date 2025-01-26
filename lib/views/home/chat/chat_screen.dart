import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';

import '../../../global/constants/colors_text.dart';
import '../../../global/reuseable/scaffold.dart';


class ChatScren extends StatefulWidget {
  final String? data;
  const ChatScren({
    super.key,
    this.data,
  });

  @override
  State<ChatScren> createState() => _ChatScrenState();
}

final List<String> chatlist = [];
final controller = TextEditingController();

class _ChatScrenState extends State<ChatScren> {
  @override
  Widget build(BuildContext context) {
    return ReuseableScaffold(
      appbar: true,
      text: widget.data,
      back: true,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: chatlist.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            chatlist[index],
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
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          hintStyle: textPoppions.headlineMedium?.copyWith(
                            color: AppColors.iconColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          border: InputBorder.none,
                        ),
                        onSubmitted: (value) => _sendMessage(),
                      ),
                    ),
                  ),
                  // Send button
                  IconButton(
                    icon: const Icon(
                      Icons.send,
                      color: AppColors.primaryColor,
                    ),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage() {
    if (controller.text.trim().isEmpty) return;

    setState(() {
      chatlist.insert(0, controller.text.trim());
    });

    controller.clear();
  }
}
