import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:fluttertube/blocs/favorite_bloc.dart';
import 'package:fluttertube/models/video.dart';

const API_KEY = "AIzaSyCyLPUJQhBW-edDGU6sxPipLxsPayF5Wco";

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FavoriteBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder<Map<String, Video>>(
        initialData: {},
        stream: bloc.outFavority,
        builder: (context, snapshot){
          return ListView(
            children: snapshot.data.values.map((map){
              return InkWell(
                onTap: (){
                  FlutterYoutube.playYoutubeVideoById(
                    apiKey: API_KEY,
                    videoId: map.id
                  );
                },
                onLongPress: (){
                  bloc.toggleFavorite(map);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 50,
                      child: Image.network(map.thumb),
                    ),
                    Expanded(
                      child: Text(
                        map.title,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}