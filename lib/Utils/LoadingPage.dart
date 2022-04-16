import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget{
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 1,
          width: MediaQuery.of(context).size.width / 1,
          child: Image.asset("asset/loading.gif", scale: 5,),
        ),
      ),
    );
  }
}