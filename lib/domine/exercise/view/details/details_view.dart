import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ipm1920_p2/domine/exercise/view/details/details_view_dto.dart';
import 'package:youtube_player/youtube_player.dart';

const String _API_KEY = "AIzaSyAi_CsNyza3199UdYhOztO7t-blhkREoi8";

class DetailsView extends StatelessWidget {
  final ExerciseDto exerciseDto;
  DetailsView(this.exerciseDto);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CardTitle(exerciseDto),
      ),
      body: CardBody(exerciseDto),
    );
  }
}

class CardTitle extends StatelessWidget {
  final ExerciseDto exerciseDto;
  CardTitle(this.exerciseDto);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: ListTile(
            //leading:
              title: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(20.0,0.0,20.0,0.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      border: Border.all(
                        width: 2.0,
                        color: Theme.of(context).primaryTextTheme.title.color,
                      ),
                      borderRadius: BorderRadius.all(
                          Radius.circular(15.0)
                      ),
                    ),
                    child: Text(exerciseDto.name,
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        color: Theme.of(context).primaryTextTheme.title.color,
                        fontSize: 16.0,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
          ),
        ),

      ],
    );
  }

}

class CardBody extends StatelessWidget {
  final ExerciseDto exerciseDto;
  CardBody(this.exerciseDto);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
          child: Container(
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                Container(
                  child: PlayerWidget(exerciseDto: exerciseDto,)
                ),
                Divider(color: Colors.black38),
                Container(
                  child: InfoWidget(exerciseDto)
                ),
              ],
            ),
          ),

      ),
    );
  }

}


class PlayerWidget extends StatefulWidget {
  PlayerWidget({Key key, this.exerciseDto}): super (key: key);

  final ExerciseDto exerciseDto;

  @override
  State<StatefulWidget> createState() => _PlayerWidgetState();

}

class _PlayerWidgetState extends State<PlayerWidget> {

  @override
  Widget build(BuildContext context) {
    var source = widget.exerciseDto.videoUrl.split("watch?v=");

    return YoutubePlayer(
      context: context,
      source: (source.length > 0)? source[1]:"JsUh89t6F24", // hay que extraer el id
      quality: YoutubeQuality.HD,
      autoPlay: false,
      loop: false,
      reactToOrientationChange: true,
      startFullScreen: false,
      controlsActiveBackgroundOverlay: true,
      controlsTimeOut: Duration(seconds: 4),
      playerMode: YoutubePlayerMode.DEFAULT,
      onError: (error) {
        print(error);
      },
    );
  }
}


class InfoWidget extends StatelessWidget {
  final ExerciseDto exerciseDto;
  InfoWidget(this.exerciseDto);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:ListTile(
        subtitle: Column(
            children: [
              Container(
                child: Text(
                  exerciseDto.description,
                  overflow: TextOverflow.clip,
                  style: new TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Divider(color: Colors.black38),
              Container(
                  height: 30,
                  child: Row(
                    children: <Widget>[
                      Text("Duretion: "+exerciseDto.repetitions),
                      Icon(Icons.arrow_right, color: Colors.black),
                    ],
                  )
              ) ,
            ]
        ),
      ),
    );
  }


}
/*
FlutterYoutube.playYoutubeVideoByUrl(
                      apiKey: _API_KEY,
                      videoUrl: exerciseDto.videoUrl,
                      autoPlay: false, //default falase
                      fullScreen: false, //default false
                      appBarColor: Colors.red,
                      backgroundColor: Colors.white,
                  ),
 */