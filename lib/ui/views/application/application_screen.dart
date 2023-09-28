import 'package:chat_connect/bloc/bloc.dart';
import 'package:chat_connect/resources/resources.dart';
import 'package:chat_connect/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApplicationScreen extends StatefulWidget {
  final Widget child;
  const ApplicationScreen({super.key, required this.child});

  @override
  State<ApplicationScreen> createState() => _ApplicationScreenState();
}

class _ApplicationScreenState extends State<ApplicationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorProvider.mainBackground,
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserError) {
            print(state.message);
          }
        },
        builder: (context, state) {
          if (state is UserLoading) {
            return loadingWidget();
          }
          if (state.userModel.id.isNotEmpty) {
            return SizedBox(
                height: 812.h,
                width: 375.w,
                child: Scaffold(
                  body: widget.child,
                  bottomNavigationBar: bottomNavigationBarWidget(),
                ));
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
