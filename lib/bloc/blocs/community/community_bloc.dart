import 'package:bloc/bloc.dart';
import 'package:chat_connect/models/models.dart';
import 'package:chat_connect/repositories/repositories.dart';
import 'package:equatable/equatable.dart';

part 'community_event.dart';
part 'community_state.dart';

class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {
  final CommunityRepository communityRepository;
  CommunityBloc({required this.communityRepository})
      : super(const CommunityState()) {
    on<GetPostsEvent>(_onGetPostsEvent);
  }

  _onGetPostsEvent(GetPostsEvent event, Emitter<CommunityState> emit) async {
    emit(const CommunityLoading());
    try {
      final postModelList = await communityRepository.getPostsList();
      final userModelList = await communityRepository.getAuthorIdList();
      emit(state.copyWith(
          postModelList: postModelList, userModelList: userModelList));
    } catch (e) {
      emit(CommunityError(message: e.toString()));
    }
  }
}
