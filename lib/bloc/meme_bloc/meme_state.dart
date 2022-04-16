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

class GetImageLocal extends MemeState{
  final File path;
  final File imageOri;
  GetImageLocal(this.path, this.imageOri);
}

class GalerryCaptureSuccess extends MemeState {
  final File path;
  GalerryCaptureSuccess(this.path);
}

class GaleryFailure extends MemeState {
  final String error;
  GaleryFailure({this.error = "GaleryFailure"});
}

class SuccessWatermarkedImage extends MemeState {
  final String message;
  final ui.Image image;
  SuccessWatermarkedImage(this.message, this.image);
}
