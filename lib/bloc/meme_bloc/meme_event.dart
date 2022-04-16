part of 'meme_bloc.dart';

@immutable
abstract class MemeEvent {}

class GetDataMemeInitial  extends MemeEvent{
  final BuildContext context;
  GetDataMemeInitial(this.context);
}
