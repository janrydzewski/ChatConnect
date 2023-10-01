import 'package:chat_connect/models/models.dart';
import 'package:chat_connect/resources/resources.dart';
import 'package:chat_connect/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

reusableMainMessageWidget(
    {required ChatModel chatModel, required UserModel receiverModel}) {
  return Container(
    width: 375.w,
    height: 85.h,
    margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
    child: Row(
      children: [
        Container(
          width: 75.w,
          height: 75.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: ColorProvider.secondaryBackground.withOpacity(0.8)),
          child: receiverModel.photoUrl.isNotEmpty
              ? SizedBox(
                  width: 65.w,
                  height: 65.w,
                  child: Image.network(
                    receiverModel.photoUrl,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return loadingWidget();
                    },
                  ),
                )
              : Icon(
                  Icons.person,
                  size: 65.w,
                ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: reusableMessageText(
                      "${receiverModel.firstName} ${receiverModel.lastName}",
                      fontSize: 20,
                      fontColor: ColorProvider.thirdText),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: reusableMessageText(
                    chatModel.lastMessage,
                    maxLines: 2,
                    fontSize: 13,
                    fontColor: ColorProvider.fourthText,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 65.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              reusableMessageText(
                  "${DateTime.now().difference(chatModel.lastMessageDate).inMinutes} minutes",
                  fontSize: 13),
              Container(
                width: 30.w,
                height: 30.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                ),
                alignment: Alignment.center,
                child: reusableMessageText("1", fontSize: 16),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
