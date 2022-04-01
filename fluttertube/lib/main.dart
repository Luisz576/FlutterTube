import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:fluttertube/screens/home.dart';

import 'blocs/favorite_bloc.dart';
import 'blocs/videos_bloc.dart';

void main(){ runApp(MyApp()); }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: VideosBloc(),
      child: BlocProvider(
        bloc: FavoriteBloc(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "FlutterTube",
          home: Home(),
        ),
      )
    );
  }
}