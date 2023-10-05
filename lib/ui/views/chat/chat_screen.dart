// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:chat_connect/bloc/bloc.dart';
import 'package:chat_connect/resources/resources.dart';
import 'package:chat_connect/ui/ui.dart';

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
              BlocConsumer<ChatBloc, ChatState>(
                listener: (context, state) {
                  if (state is ChatError) {
                    print(state.message);
                  }
                },
                builder: (context, state) {
                  if (state is ChatLoading) {
                    return Expanded(child: loadingWidget());
                  } else if (state.chatModelList.isNotEmpty) {
                    final chatModelList = state.chatModelList.reversed.toList();
                    final receiverUserList =
                        state.receiverUserList.reversed.toList();
                    return Expanded(
                      child: ListView.builder(
                        controller: ScrollController(),
                        itemCount: chatModelList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              context.go("/message", extra: {
                                "chatRoomId": chatModelList[index].id,
                                "receiverName":
                                    "${receiverUserList[index].firstName} ${receiverUserList[index].lastName}"
                              });
                            },
                            child: reusableMainMessageWidget(
                                chatModel: chatModelList[index],
                                receiverModel: receiverUserList[index]),
                          );
                        },
                      ),
                    );
                  }
                  return const Expanded(
                      child: Center(
                    child: CircularProgressIndicator(
                      color: ColorProvider.mainElement,
                    ),
                  ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
