part of 'search_user_bloc.dart';

class SearchUserEvent extends Equatable {
  const SearchUserEvent();

  @override
  List<Object> get props => [];
}

class GetSearchedListEvent extends SearchUserEvent {
  final String searchedText;
  const GetSearchedListEvent(this.searchedText);

  @override
  List<Object> get props => [searchedText];
}