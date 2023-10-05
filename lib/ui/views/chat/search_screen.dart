import 'package:chat_connect/bloc/bloc.dart';
import 'package:chat_connect/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 375.w,
      height: 812.h,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              reusableSearchBarWidget(
                textEditingController,
                () {
                  context
                      .read<SearchUserBloc>()
                      .add(GetSearchedListEvent(textEditingController.text));
                },
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(horizontal: 25.w),
                child: reusableText("Search", fontSize: 34),
              ),
              BlocConsumer<SearchUserBloc, SearchUserState>(
                listener: (context, state) {
                  if (state is SearchUserError) {
                    print(state.message);
                  }
                },
                builder: (context, state) {
                  if (state is SearchUserLoading) {
                    return Expanded(child: loadingWidget());
                  } else if (state.userModelList.isNotEmpty) {
                    return Expanded(
                      child: ListView.builder(
                        controller: ScrollController(),
                        itemCount: state.userModelList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {},
                            child: reusableUserModelElement(state.userModelList[index]),
                          );
                        },
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
