part of 'messages_bloc.dart';

@immutable
abstract class MessagesEvent {
  const MessagesEvent();
}

class MessagesRequested extends MessagesEvent {
  const MessagesRequested();

  @override
  List<Object> get props => [];
}
