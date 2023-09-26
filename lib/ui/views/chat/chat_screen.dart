import 'package:chat_connect/models/models.dart';
import 'package:chat_connect/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 375.w,
      height: 812.h,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                width: 375.w,
                height: 35.h,
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search_outlined,
                    size: 35.w,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(horizontal: 25.w),
                child: reusableText("Messages", fontSize: 34),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        context.go("/chat/message");
                      },
                      child: reusableMainMessageWidget(
                          messageModel: MessageModel.testMessage()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
