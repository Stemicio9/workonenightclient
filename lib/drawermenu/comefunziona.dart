

import 'package:flutter/material.dart';
import 'package:workonenight/services/menulaterale/comefunziona.dart';
import 'package:workonenight/stilitema/appbars.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ComeFunziona extends StatefulWidget {
  @override
  ComeFunzionaState createState() {
    return ComeFunzionaState();
  }

}


class ComeFunzionaState extends State<ComeFunziona> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarsenzaactions("Come Funziona"),

      body: StreamBuilder(
        stream: getvideocomefunziona().asBroadcastStream(),
        builder: (context,snapshot) {
          if(!snapshot.hasData){
            return Center(child: Text(" "));
          }
          return ListView.builder(itemBuilder: (BuildContext context, int index) { return creaelementosingolo(snapshot.data[index], context);},
          itemCount: snapshot.data.length,);
        },
      ),
    );
  }


  Widget creaelementosingolo(VideoComeFunziona video, context){
    YoutubePlayerController controller = YoutubePlayerController(
      initialVideoId: video.videosource,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false
      )
    );

    return Column(
      children: [
        SizedBox(height: 10),
        Text(video.titolo),
        SizedBox(height: 10),
        Center(
          child: YoutubePlayer(controller: controller)
        ),
        SizedBox(height: 10)
      ],
    );
  }

}