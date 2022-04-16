import 'package:algostudiotest/bloc/meme_bloc/meme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'MainPage/HomePage/MainHomeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<MemeBloc>(create: (context) => MemeBloc()),
        ],
        child: MaterialApp(
          title: 'AlgoStudio Test',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(title: 'AlgoStudio Test'),
        )
    );
  }
}
