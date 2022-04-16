part of 'meme_bloc.dart';

@immutable
abstract class MemeState {}

class MemeInitial extends MemeState {}

class SuccessGetMemeInitial extends MemeState{
  final MemeData data;
  SuccessGetMemeInitial(this.data);
}

class ErrorGetMemeInitial extends MemeState{
  final String message;
  ErrorGetMemeInitial(this.message);
}
