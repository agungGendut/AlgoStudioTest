part of 'meme_bloc.dart';

@immutable
abstract class MemeEvent {}

class GetDataMemeInitial  extends MemeEvent{
  final BuildContext context;
  GetDataMemeInitial(this.context);
}

class AddTextWatermark extends MemeEvent{
  final String textWatermark;
  AddTextWatermark(this.textWatermark);
}

class GetWatermarkImage extends MemeEvent {
  final BuildContext context;
  final File imageOri;
  GetWatermarkImage(this.context, this.imageOri);
}

class GetImageGalerry extends MemeEvent {
  final String url;
  final String iamge;
  GetImageGalerry(this.url, this.iamge);
}

class SaveWatermarkedImage extends MemeEvent {
  final File ori;
  final File watermark;
  SaveWatermarkedImage(this.ori, this.watermark);
}