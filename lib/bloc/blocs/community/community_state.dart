part of 'community_bloc.dart';

class CommunityState extends Equatable {
  final List<PostModel> postModelList;
  final List<UserModel> userModelList;

  const CommunityState({
    List<PostModel>? postModelList,
    List<UserModel>? userModelList,
  }) : postModelList = postModelList ?? const [],
        userModelList = userModelList ?? const [];

  CommunityState copyWith({
    List<PostModel>? postModelList,
    List<UserModel>? userModelList
  }) {
    return CommunityState(
      postModelList: postModelList ?? this.postModelList,
      userModelList: userModelList ?? this.userModelList,
    );
  }

  @override
  List<Object> get props => [postModelList, userModelList];
}

class CommunityLoading extends CommunityState {
  const CommunityLoading();

  @override
  List<Object> get props => [];
}

class CommunityError extends CommunityState {
  final String message;

  const CommunityError({
    List<PostModel>? postModelList,
    List<UserModel>? userModelList,
    required this.message,
  }) : super(postModelList: postModelList, userModelList: userModelList);

  @override
  List<Object> get props => [message];
}
