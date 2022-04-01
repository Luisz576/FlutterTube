import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:fluttertube/blocs/favorite_bloc.dart';
import 'package:fluttertube/blocs/videos_bloc.dart';
import 'package:fluttertube/delegates/data_search.dart';
import 'package:fluttertube/models/video.dart';
import 'package:fluttertube/screens/Favorites.dart';
import 'package:fluttertube/tiles/VideoTile.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<VideosBloc>(context);
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Container(
          height: 25.0,
          child: Image.asset("images/youtube_logo.png"),
        ),
        elevation: 0.0,
        backgroundColor: Colors.black87,
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: StreamBuilder<Map<String, Video>>(
              stream: BlocProvider.of<FavoriteBloc>(context).outFavority,
              builder: (context, snapshot){
                if(snapshot.hasData)
                  return Text("${snapshot.data.length}");
                else
                  return CircularProgressIndicator();
              },
            ),
          ),
          IconButton(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Favorites()));
            },
            icon: Icon(Icons.star),
          ),
          IconButton(
            onPressed: () async{
              String result = await showSearch(context: context, delegate: DataSearch());
              if(result != null) bloc.inSearch.add(result);
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: StreamBuilder(
        initialData: [],
        stream: BlocProvider.of<VideosBloc>(context).outVideos,
        builder: (context, snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data.length + 1,
              itemBuilder: (context, index){
                if(index < snapshot.data.length){
                  return VideoTile(snapshot.data[index]);
                }else if(index > 1){
                  bloc.inSearch.add(null);
                  return Container(
                    height: 40.0,
                    width: 40.0,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red),),
                  );
                }else{
                  return Container();
                }
              }
            );
          }else{
            return Container();
          }
        }
      ),
    );
  }
}