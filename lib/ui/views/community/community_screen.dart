import 'package:chat_connect/bloc/bloc.dart';
import 'package:chat_connect/resources/resources.dart';
import 'package:chat_connect/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  void initState() {
    context.read<CommunityBloc>().add(const GetPostsEvent());
    super.initState();
  }

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
              BlocConsumer<CommunityBloc, CommunityState>(
                listener: (context, state) {
                  if (state is CommunityError) {
                    print(state.message);
                  }
                },
                builder: (context, state) {
                  if (state is CommunityLoading) {
                    return Expanded(child: loadingWidget());
                  } else if (state.postModelList.isNotEmpty &&
                      state.userModelList.isNotEmpty) {
                    final postModelList = state.postModelList.reversed.toList();
                    final userModelList = state.userModelList.reversed.toList();
                    return Expanded(
                      child: RefreshIndicator(
                        displacement: 25,
                        color: ColorProvider.mainText,
                        strokeWidth: 2,
                        onRefresh: () async {
                          context
                              .read<CommunityBloc>()
                              .add(const GetPostsEvent());
                        },
                        child: ListView.builder(
                          controller: ScrollController(),
                          itemCount: postModelList.length,
                          itemBuilder: (context, index) {
                            return reusablePostModelElement(
                                postModelList[index], userModelList[index]);
                          },
                        ),
                      ),
                    );
                  }
                  return Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: reusableMessageText(
                        "There are no post yet.",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
