import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wvsu_tour_app/models/models.dart';
import 'package:wvsu_tour_app/repositories/messages/messages_repository.dart';

part 'messages_event.dart';
part 'messages_state.dart';

class MessagesInitial extends MessagesState {}

class MessagesLoadInProgress extends MessagesState {}

class MessagesLoadSuccess extends MessagesState {
  final List<Messages> messages;

  const MessagesLoadSuccess({@required this.messages})
      : assert(messages != null);

  @override
  List<Object> get props => [messages];
}

class MessagesLoadFailure extends MessagesState {}

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  final MessagesRepository messagesRepository;

  MessagesBloc({@required this.messagesRepository})
      : assert(messagesRepository != null),
        super(MessagesInitial());

  @override
  Stream<MessagesState> mapEventToState(
    MessagesEvent event,
  ) async* {
    try {
      final List messages = await messagesRepository.getData();
      yield MessagesLoadSuccess(messages: messages);
    } catch (_) {}
  }
}
