import 'package:chat_connect/models/models.dart';
import 'package:chat_connect/resources/resources.dart';
import 'package:chat_connect/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

reusablePostModelElement(PostModel postModel, UserModel userModel) {
  return Container(
      width: 200.w,
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      alignment: Alignment.centerLeft,
      decoration: const BoxDecoration(
        color: ColorProvider.secondaryBackground,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 55.w,
                height: 55.w,
                margin: EdgeInsets.only(right: 15.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorProvider.mainBackground.withOpacity(0.8)),
                child: userModel.photoUrl.isNotEmpty
                    ? Container(
                        padding: const EdgeInsets.all(5),
                        width: 45.w,
                        height: 45.w,
                        child: Image.network(
                          userModel.photoUrl,
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
                        size: 45.w,
                      ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  reusableMessageText(
                    "${userModel.firstName} ${userModel.lastName}",
                    fontSize: 18,
                  ),
                  reusableMessageText(
                    DateFormat('MMMM dd, yyyy HH:mm').format(postModel.date),
                    fontSize: 12,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          SizedBox(
            width: 375.w,
            child: reusableMessageText(postModel.message,
                fontSize: 12, maxLines: 100),
          ),
        ],
      ));
}
