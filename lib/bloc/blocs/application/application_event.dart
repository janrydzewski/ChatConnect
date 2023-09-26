part of 'application_bloc.dart';

class ApplicationEvent extends Equatable {
  const ApplicationEvent();

  @override
  List<Object> get props => [];
}

class ChangeApplicationIndexEvent extends ApplicationEvent {
  final int newIndex;

  const ChangeApplicationIndexEvent(this.newIndex);

  @override
  List<Object> get props => [newIndex];
}