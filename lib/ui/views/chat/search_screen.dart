import 'package:chat_connect/bloc/bloc.dart';
import 'package:chat_connect/repositories/repositories.dart';
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
              SizedBox(
                height: 50.h,
              ),
              reusableSearchBarWidget(
                textEditingController,
                () {
                  context
                      .read<SearchUserBloc>()
                      .add(GetSearchedListEvent(textEditingController.text));
                },
              ),
              SizedBox(
                height: 25.h,
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
                            onTap: () async {
                              await const SearchUserRepository()
                                  .isAlreadyUsersHaveRoom(
                                      state.userModelList[index], context);
                            },
                            child: reusableUserModelElement(
                                state.userModelList[index]),
                          );
                        },
                      ),
                    );
                  }
                  return Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: reusableMessageText(
                        "Search for Users",
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
