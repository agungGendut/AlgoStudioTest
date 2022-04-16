import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../MainHomeScreen.dart';

class DetailScreen extends StatefulWidget{
  final String urlImage, title;
  const DetailScreen({Key? key, required this.urlImage, required this.title}) : super(key: key);

  @override
  DetailScreenPage createState() => DetailScreenPage();
}

class DetailScreenPage extends State<DetailScreen>{
  late String urlImage;


  @override
  void initState() {
    urlImage = widget.urlImage;
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
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  height: MediaQuery.of(context).size.height / 1,
                  width: MediaQuery.of(context).size.width / 1,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(urlImage)
                    )
                  ),
                ),
              ),
            ],
          ),
        ),
        onWillPop: onWillPop
    );
  }
}