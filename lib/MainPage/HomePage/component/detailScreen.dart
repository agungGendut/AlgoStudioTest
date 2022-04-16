import 'dart:io';
import 'package:algostudiotest/Utils/LoadingPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../bloc/meme_bloc/meme_bloc.dart';
import '../MainHomeScreen.dart';

class DetailScreen extends StatefulWidget{
  final String urlImage, title;
  const DetailScreen({Key? key, required this.urlImage, required this.title}) : super(key: key);

  @override
  DetailScreenPage createState() => DetailScreenPage();
}

class DetailScreenPage extends State<DetailScreen>{
  final TextEditingController _replayController = TextEditingController();
  late String urlImage;
  late File image;
  late File watermarkImage;

  @override
  void initState() {
    urlImage = widget.urlImage;
    context.read<MemeBloc>().add(GetImageGalerry(urlImage, ""));
    super.initState();
  }

  Future<bool> onWillPop() {
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => const MyHomePage(title: "AlgoStudio Test",)
        )
    );

    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            leading: Container(
              margin: const EdgeInsets.all(5),
              child: IconButton(
                  icon: const Icon(FontAwesomeIcons.arrowLeft, color: Colors.black,),
                  onPressed: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const MyHomePage(title: "AlgoStudio Test",)
                        )
                    );
                  }
              ),
            ),
            backgroundColor: Colors.white,
            title: Text(widget.title, style: GoogleFonts.lato(color: Colors.black),),
            centerTitle: true,
          ),
          body: BlocConsumer<MemeBloc, MemeState>(
            listener: (context, state){
              if (state is SuccessWatermarkedImage){
                context.read<MemeBloc>().add(GetImageGalerry("", state.image.toString()));
                Fluttertoast.showToast(
                    msg: state.message,
                    toastLength: Toast.LENGTH_LONG,
                    backgroundColor: Colors.red
                );
              }
            },
            builder: (context, state){
              if (state is GalerryCaptureSuccess) {
                image = state.path;

                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child:  SizedBox(
                        height: MediaQuery.of(context).size.height / 1,
                        width: MediaQuery.of(context).size.width / 1,
                        child: Image.file(image),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: (){
                                context.read<MemeBloc>().add(GetWatermarkImage(context, image));
                              },
                              child: Text("Image", style: GoogleFonts.lato(fontSize: 14),),
                            ),
                            ElevatedButton(
                              onPressed: (){},
                              child: Text("Text", style: GoogleFonts.lato(fontSize: 14),),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }

              if (state is GetImageLocal) {
                watermarkImage = state.path;

                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 1,
                        width: MediaQuery.of(context).size.width / 1,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(state.imageOri)
                          )
                        ),
                        child: Image.file(watermarkImage),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: (){
                                context.read<MemeBloc>().add(SaveWatermarkedImage(state.imageOri, watermarkImage));
                              },
                              child: Text("Apply Watermark", style: GoogleFonts.lato(fontSize: 14),),
                            ),
                            ElevatedButton(
                              onPressed: (){
                                showModalBottomSheet(
                                    elevation: 20,
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context){
                                      return StatefulBuilder(
                                          builder: (BuildContext context, StateSetter setStateS){
                                            return Padding(
                                              padding: MediaQuery.of(context).viewInsets,
                                              child: Container(
                                                height: MediaQuery.of(context).size.height / 10,
                                                width: MediaQuery.of(context).size.width / 1,
                                                margin: const EdgeInsets.all(10),
                                                child: Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        height: MediaQuery.of(context).size.height / 10.85,
                                                        width: MediaQuery.of(context).size.width / 1.5,
                                                        child: TextField(
                                                          controller: _replayController,
                                                          maxLines: null,
                                                          decoration: InputDecoration(
                                                              hintText: 'add text',
                                                              border: InputBorder.none
                                                          ),
                                                          keyboardType: TextInputType.multiline,
                                                        ),
                                                      ),
                                                      IconButton(
                                                          icon: const Icon(FontAwesomeIcons.paperPlane),
                                                          onPressed: (){
                                                            print("id user di kirim: ");
                                                          }
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                      );
                                    });
                              },
                              child: Text("Text", style: GoogleFonts.lato(fontSize: 14),),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }


              return const LoadingPage();
            },
          ),
        ),
        onWillPop: onWillPop
    );
  }
}