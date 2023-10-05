import 'package:chat_connect/models/post.dart';
import 'package:chat_connect/models/user.dart';
import 'package:chat_connect/resources/resources.dart';
import 'package:chat_connect/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 375.w,
      height: 812.h,
      child: Scaffold(
        backgroundColor: ColorProvider.mainBackground,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 35.h,
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(horizontal: 25.w),
                child: reusableText("Community", fontSize: 34),
              ),
              Expanded(
                      child: ListView.builder(
                        controller: ScrollController(),
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return reusablePostModelElement(
                              PostModel(id: "", authorId: firebaseAuth.currentUser!.uid, message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", date: DateTime.now().subtract(Duration(minutes: 182),),), UserModel(id: "", firstName: "Jan", lastName: "Rydzewski", email: "jan.rydzewski1337@gmail.com", photoUrl: "https://firebasestorage.googleapis.com/v0/b/chatconnect-2090a.appspot.com/o/profileUrl%2FUEzrPmRL4qOYeQsOqV2vyIIuM2U2?alt=media&token=e22e959e-7f9a-490b-8bab-7a743f8c055b"));
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
