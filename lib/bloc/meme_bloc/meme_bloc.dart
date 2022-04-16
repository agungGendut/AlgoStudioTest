import 'dart:async';

import 'package:algostudiotest/Model/MemeData.dart';
import 'package:algostudiotest/ViewModel/ApiRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'meme_event.dart';
part 'meme_state.dart';

class MemeBloc extends Bloc<MemeEvent, MemeState> {
  late MemeData memeData;
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
  }
}
