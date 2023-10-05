part of 'search_user_bloc.dart';

class SearchUserState extends Equatable {
  final List<UserModel> userModelList;

  const SearchUserState({
    List<UserModel>? userModelList,
  }) : userModelList = userModelList ?? const [];

  SearchUserState copyWith({
    List<UserModel>? userModelList,
  }) {
    return SearchUserState(
      userModelList: userModelList ?? this.userModelList,
    );
  }

  @override
  List<Object> get props => [userModelList];
}

class SearchUserLoading extends SearchUserState {
  const SearchUserLoading();

  @override
  List<Object> get props => [];
}

class SearchUserError extends SearchUserState {
  final String message;

  const SearchUserError({
    List<UserModel>? userModelList,
    required this.message,
  }) : super(userModelList: userModelList);

  @override
  List<Object> get props => [message];
}
