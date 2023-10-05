import 'package:bloc/bloc.dart';
import 'package:chat_connect/models/models.dart';
import 'package:chat_connect/repositories/repositories.dart';
import 'package:equatable/equatable.dart';

part 'search_user_event.dart';
part 'search_user_state.dart';

class SearchUserBloc extends Bloc<SearchUserEvent, SearchUserState> {
  final SearchUserRepository searchUserRepository;
  SearchUserBloc({required this.searchUserRepository}) : super(const SearchUserState()) {
    on<GetSearchedListEvent>(_onGetSearchedListEvent);
  }

  _onGetSearchedListEvent(GetSearchedListEvent event, Emitter<SearchUserState> emit) async {
    emit(const SearchUserLoading());
    try{
      final userModelList = await searchUserRepository.getUserModelList(event.searchedText);
      emit(state.copyWith(userModelList: userModelList));
    }
    catch(e){
      emit(SearchUserError(message: e.toString()));
    }
  }
}
