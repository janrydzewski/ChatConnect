import 'package:chat_connect/bloc/bloc.dart';
import 'package:chat_connect/resources/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

Widget bottomNavigationBarWidget() {
  return BlocBuilder<ApplicationBloc, ApplicationState>(
    builder: (context, state) {
      return Container(
        height: 60,
        margin: EdgeInsets.only(bottom: 35.h, left: 15.w, right: 15.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              child: Column(
                children: [
                  SizedBox(
                    width: 35.w,
                    child: Image.asset(
                      "assets/icons/home.png",
                      color: state.index == 0
                          ? ColorProvider.mainElement
                          : ColorProvider.secondaryElement,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    width: 7.w,
                    height: 7.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: state.index == 0
                          ? ColorProvider.mainElement
                          : ColorProvider.mainBackground,
                    ),
                  )
                ],
              ),
              onTap: () {
                context.go('/home');
                context
                    .read<ApplicationBloc>()
                    .add(const ChangeApplicationIndexEvent(0));
              },
            ),
            GestureDetector(
              child: Column(
                children: [
                  SizedBox(
                    width: 35.w,
                    child: Image.asset(
                      "assets/icons/chat.png",
                      color: state.index == 1
                          ? ColorProvider.mainElement
                          : ColorProvider.secondaryElement,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    width: 7.w,
                    height: 7.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: state.index == 1
                          ? ColorProvider.mainElement
                          : ColorProvider.mainBackground,
                    ),
                  )
                ],
              ),
              onTap: () {
                context.go('/chat');
                context
                    .read<ApplicationBloc>()
                    .add(const ChangeApplicationIndexEvent(1));
              },
            ),
            GestureDetector(
              child: Column(
                children: [
                  SizedBox(
                    width: 35.w,
                    child: Image.asset(
                      "assets/icons/profile.png",
                      color: state.index == 2
                          ? ColorProvider.mainElement
                          : ColorProvider.secondaryElement,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    width: 7.w,
                    height: 7.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: state.index == 2
                          ? ColorProvider.mainElement
                          : ColorProvider.mainBackground,
                    ),
                  )
                ],
              ),
              onTap: () {
                context.go('/profile');
                context
                    .read<ApplicationBloc>()
                    .add(const ChangeApplicationIndexEvent(2));
              },
            ),
          ],
        ),
      );
    },
  );
}
