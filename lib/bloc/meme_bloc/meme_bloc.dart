import 'dart:async';
import 'dart:io';

import 'package:algostudiotest/Model/MemeData.dart';
import 'package:algostudiotest/ViewModel/ApiRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as ui;

part 'meme_event.dart';
part 'meme_state.dart';

class MemeBloc extends Bloc<MemeEvent, MemeState> {
  late MemeData memeData;
  late File path1;
  late File path2;
  MemeBloc() : super(MemeInitial()) {
    on<MemeEvent>((event, emit) async {
      await mapEventToStates(event, emit);
    });
  }

  Future<void> mapEventToStates(
      MemeEvent event, Emitter<MemeState> emit
      ) async {

    if (event is GetDataMemeInitial){
      MemeData response = await ApiRepository.getMemeData();
      if (response.success == true){
        memeData = response;
        emit(SuccessGetMemeInitial(memeData));
      } else {
        emit(ErrorGetMemeInitial("Failed"));
      }
    }

    if (event is GetWatermarkImage){
      final ImagePicker _picker = ImagePicker();
      final image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 360, maxWidth: 360,
        imageQuality: 50,
      );
      emit(GetImageLocal(File(image?.path ?? ""), event.imageOri));
    }

    if (event is GetImageGalerry){
      var response;
      try {
        if (event.url != ""){
          response = await get(Uri.parse(event.url));
        } else {
         response = await rootBundle.load(event.iamge.toString());
        }
        var documentDirectory = await getApplicationDocumentsDirectory();
        var firstPath = documentDirectory.path + "/images";
        var filePathAndName = documentDirectory.path + '/images/pic.png';
        await Directory(firstPath).create(recursive: true);
        File file2 = File(filePathAndName);
        file2.writeAsBytesSync(response.bodyBytes);
        path1 = file2;
        emit(GalerryCaptureSuccess(file2));
      } catch (e){
        emit(GaleryFailure(error: e.toString()));
      }
    }

    if (event is SaveWatermarkedImage){
      ui.Image? originalImage = ui.decodeImage(event.ori.readAsBytesSync());
      ui.Image? watermarkImage = ui.decodeImage(event.watermark.readAsBytesSync());
      ui.Image result = ui.drawImage(originalImage!, watermarkImage!);
      print(result.data);
      emit(SuccessWatermarkedImage("Success", result));
    }

    if (event is AddTextWatermark){

    }
  }
}
