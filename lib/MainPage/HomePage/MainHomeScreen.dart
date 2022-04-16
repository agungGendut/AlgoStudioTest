import 'package:algostudiotest/Model/MemeData.dart';
import 'package:algostudiotest/Utils/LoadingPage.dart';
import 'package:algostudiotest/bloc/meme_bloc/meme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'component/detailScreen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late MemeData memeData;

  @override
  void initState() {
    context.read<MemeBloc>().add(GetDataMemeInitial(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.title, style: GoogleFonts.lato(color: Colors.black),),
        centerTitle: true,
      ),
      body: BlocConsumer<MemeBloc, MemeState>(
        listener: (context, state) {
          if (state is ErrorGetMemeInitial){
            Fluttertoast.showToast(
                msg: state.message,
                toastLength: Toast.LENGTH_LONG,
                backgroundColor: Colors.red
            );
          }
        },
        builder: (context, state) {
          if (state is SuccessGetMemeInitial){
            memeData = state.data;

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(15),
                    child: Text("MimGenerator", style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold),),
                  ),
                ),
                SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    childAspectRatio: 1.0,
                  ),
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      return InkWell(
                        onTap: () => Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => DetailScreen(urlImage: memeData.data?.memes?[index].url ?? "", title: "Detail Meme",)
                        ), (route) => false),
                        child: Card(
                          child: Container(
                            alignment: Alignment.center,
                            child: Image.network(memeData.data?.memes?[index].url ?? "", fit: BoxFit.fill,),
                          ),
                        ),
                      );
                    },
                    childCount: memeData.data?.memes?.length,
                  ),
                )
              ],
            );
          }

          return const LoadingPage();
        },
      ),
    );
  }
}