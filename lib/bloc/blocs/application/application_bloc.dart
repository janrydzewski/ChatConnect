import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'application_event.dart';
part 'application_state.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  ApplicationBloc() : super(const ApplicationState(index: 0)) {
    on<ChangeApplicationIndexEvent>(_onChangeApplicationIndexEvent);
  }

  _onChangeApplicationIndexEvent(ChangeApplicationIndexEvent event, Emitter<ApplicationState> emit) {
    emit(ApplicationState(index: event.newIndex));
  }
}