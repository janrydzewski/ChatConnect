import 'package:chat_connect/bloc/bloc.dart';
import 'package:chat_connect/models/models.dart';
import 'package:chat_connect/resources/resources.dart';
import 'package:chat_connect/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessagesScreen extends StatefulWidget {
  final String chatId;
  final String receiverName;
  const MessagesScreen(
      {super.key, required this.chatId, required this.receiverName});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final _messageController = TextEditingController();

  @override
  void initState() {
    context.read<MessageBloc>().add(GetMessagesEvent(widget.chatId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 375.w,
      height: 812.h,
      child: Scaffold(
        backgroundColor: ColorProvider.secondaryBackground,
        appBar: reusableMessageAppBar(widget.receiverName, context),
        body: Column(
          children: [
            Expanded(
              child: Container(
                width: 375.w,
                margin: EdgeInsets.only(top: 40.h),
                decoration: const BoxDecoration(
                  color: ColorProvider.mainBackground,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                ),
                child: Column(children: [
                  Container(
                    width: 100.w,
                    height: 30.h,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: ColorProvider.secondaryBackground,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: reusableMessageText("Today", fontSize: 14),
                  ),
                  BlocConsumer<MessageBloc, MessageState>(
                    listener: (context, state) {
                      if (state is MessageError) {
                        print(state.message);
                      }
                    },
                    builder: (context, state) {
                      if (state is MessageLoading) {
                        return Expanded(child: loadingWidget());
                      } else if (state.messageModelList.isNotEmpty) {
                        final messageModelList =
                            state.messageModelList.reversed.toList();
                        return Expanded(
                          child: ListView.builder(
                            reverse: true,
                            controller: ScrollController(),
                            scrollDirection: Axis.vertical,
                            itemCount: messageModelList.length,
                            itemBuilder: (context, index) {
                              return reusableMessageWidget(
                                  messageModelList[index].message,
                                  messageModelList[index].senderUid ==
                                          firebaseAuth.currentUser!.uid
                                      ? true
                                      : false);
                            },
                          ),
                        );
                      }
                      return const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: ColorProvider.mainElement,
                          ),
                        ),
                      );
                    },
                  ),
                ]),
              ),
            ),
            Container(
              width: 375.w,
              height: 90.w,
              color: ColorProvider.mainBackground,
              child: Container(
                width: 375.w,
                height: 50.w,
                margin: EdgeInsets.only(left: 35.w, right: 35.w, bottom: 40.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: ColorProvider.toMessage),
                child: Row(
                  children: [
                    GestureDetector(
                      child: Container(
                        width: 35.w,
                        height: 35.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: ColorProvider.fromMessage,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: ColorProvider.mainBackground,
                        ),
                      ),
                    ),
                    Expanded(
                      child: reusableMessageTextField(_messageController),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<MessageBloc>().add(
                              SendMessageEvent(
                                widget.chatId,
                                MessageModel(
                                  id: "",
                                  senderUid: firebaseAuth.currentUser!.uid,
                                  message: _messageController.text,
                                  date: DateTime.now(),
                                ),
                              ),
                            );
                        _messageController.clear();
                      },
                      child: Container(
                        width: 35.w,
                        height: 35.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: ColorProvider.fromMessage,
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          color: ColorProvider.mainBackground,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
