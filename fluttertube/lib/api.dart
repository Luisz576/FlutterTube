import 'dart:convert';

import 'package:http/http.dart' as Http;

import 'models/video.dart';

const API_KEY = "Your Api Key Here";

class Api{

  String _search;
  String _nextToken;

  Future<List<Video>> search(String search) async{

    _search = search;

    Http.Response response = await Http.get("https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10");

    return decode(response);

  }

  Future<List<Video>> nextPage() async{

    Http.Response response = await Http.get("https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken");

    return decode(response);

  }

  List<Video> decode(Http.Response response){

    if(response.statusCode == 200) { //200 = Recebeu dados
      var decoded = json.decode(response.body);
      _nextToken = decoded['nextPageToken'];
      List<Video> videos = decoded['items'].map<Video>(
              (map) {
            return Video.fromJson(map);
          }
      ).toList();
      return videos;
    }else{
      throw Exception("Failed to load videos");
    }

  }

}