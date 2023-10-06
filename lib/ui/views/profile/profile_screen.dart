import 'dart:io';

import 'package:chat_connect/bloc/bloc.dart';
import 'package:chat_connect/models/user.dart';
import 'package:chat_connect/resources/resources.dart';
import 'package:chat_connect/ui/ui.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late UserState userState;

  @override
  void initState() {
    userState = context.read<UserBloc>().state;
    _firstNameController.text = userState.userModel.firstName;
    _lastNameController.text = userState.userModel.lastName;
    _emailController.text = userState.userModel.email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final picker = ImagePicker();
    dynamic pickedImage;
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
                child: reusableText("Profile", fontSize: 34),
              ),
              Expanded(
                child: Container(
                  width: 375.w,
                  margin: EdgeInsets.only(
                      left: 30.w, right: 30.w, top: 50.h, bottom: 50.h),
                  decoration: BoxDecoration(
                    color: ColorProvider.secondaryBackground,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BlocBuilder<UserBloc, UserState>(
                        builder: (context, state) {
                          if (state is UserLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: ColorProvider.mainBackground
                                        .withOpacity(0.5)),
                                child: state.userModel.photoUrl.isNotEmpty
                                    ? SizedBox(
                                        width:  140.w,
                                        height: 140.h,
                                        child: Image.network(
                                          state.userModel.photoUrl,
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return loadingWidget();
                                          },
                                        ),
                                      )
                                    : Icon(
                                        Icons.person,
                                        size: 80.w,
                                      ),
                              ),
                              SizedBox(
                                height: 50.h,
                              ),
                              reusableProfileText(
                                  "${state.userModel.firstName} ${state.userModel.lastName}"),
                            ],
                          );
                        },
                      ),
                      Column(
                        children: [
                          reusableProfileButton("Edit Profile", () {
                            showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30),
                                      topLeft: Radius.circular(30)),
                                ),
                                context: context,
                                builder: (BuildContext context) {
                                  return SizedBox(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        BlocBuilder<EditProfileBloc,
                                            EditProfileState>(
                                          builder: (context, state) {
                                            return GestureDetector(
                                                onTap: () async {
                                                  pickedImage =
                                                      await picker.pickImage(
                                                          source: ImageSource
                                                              .gallery);
                                                  context
                                                      .read<EditProfileBloc>()
                                                      .add(EditPhotoEvent(
                                                          pickedImage));
                                                },
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color: ColorProvider
                                                            .secondaryBackground
                                                            .withOpacity(0.4)),
                                                    child: state.file.path != ""
                                                        ? SizedBox(
                                                            width: 80.w,
                                                            child: Image.file(
                                                              File(state
                                                                  .file.path),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          )
                                                        : userState
                                                                .userModel
                                                                .photoUrl
                                                                .isNotEmpty
                                                            ? SizedBox(
                                                                width: 80.w,
                                                                height: 80.h,
                                                                child: Image
                                                                    .network(
                                                                  userState
                                                                      .userModel
                                                                      .photoUrl,
                                                                  loadingBuilder: (BuildContext
                                                                          context,
                                                                      Widget
                                                                          child,
                                                                      ImageChunkEvent?
                                                                          loadingProgress) {
                                                                    if (loadingProgress ==
                                                                        null) {
                                                                      return child;
                                                                    }
                                                                    return loadingWidget();
                                                                  },
                                                                ),
                                                              )
                                                            : Icon(
                                                                Icons.person,
                                                                size: 80.w,
                                                              )));
                                          },
                                        ),
                                        Form(
                                          key: _formKey,
                                          child: Column(
                                            children: [
                                              reusableAuthTextField(
                                                  "First Name",
                                                  _firstNameController),
                                              reusableAuthTextField("Last Name",
                                                  _lastNameController),
                                              reusableAuthTextField(
                                                  "Email", _emailController),
                                            ],
                                          ),
                                        ),
                                        reusableProfileSecondaryButton("Apply",
                                            () async {
                                          String downloadUrl = "";
                                          if (pickedImage != null) {
                                            File image = File(pickedImage.path);
                                            Reference storageRef =
                                                firebaseStorage
                                                    .ref()
                                                    .child('profileUrl')
                                                    .child(firebaseAuth
                                                        .currentUser!.uid);
                                            UploadTask uploadTask =
                                                storageRef.putFile(image);
                                            TaskSnapshot taskSnapshot =
                                                await uploadTask;
                                            downloadUrl = await taskSnapshot.ref
                                                .getDownloadURL();
                                            print("downloaded: ${downloadUrl}");
                                          }
                                          UserModel userModel = UserModel(
                                            id: firebaseAuth.currentUser!.uid,
                                            firstName:
                                                _firstNameController.text,
                                            lastName: _lastNameController.text,
                                            email: _emailController.text,
                                            photoUrl: downloadUrl == ""
                                                ? userState.userModel.photoUrl
                                                : downloadUrl,
                                          );
                                          context.read<EditProfileBloc>().add(
                                              EditProfileDetailsEvent(
                                                  userModel));

                                          context.pop();
                                        })
                                      ],
                                    ),
                                  );
                                });
                          }),
                          reusableProfileButton("Log Out", () {
                            context.read<AuthBloc>().add(SignOutEvent());
                            context.go('/signIn');
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
