
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ipm1920_p2/domine/exercise/view/details/details_view_dto.dart';
import 'package:ipm1920_p2/domine/workout/view/training/training_stepper_dto.dart';
import 'package:youtube_player/youtube_player.dart';

class TrainingStepper extends StatefulWidget {
  TrainingStepper(this.workout);

  final WorkoutDto workout;

  @override
  _StepperState createState() => new _StepperState(workout);
}

class _StepperState extends State<TrainingStepper> {
  _StepperState(this.workout);

  WorkoutDto workout;
  int _currentStep = 0;
  int counter = 0;


  @override
  Widget build(BuildContext context) {
    return new Stepper(
      type: StepperType.vertical,
      currentStep: _currentStep,
      onStepTapped: (int step) => setState(() => _currentStep = step),
      onStepContinue: _currentStep < workout.exercises.length ? () => setState(() => _currentStep += 1) : null,
      onStepCancel: _currentStep > 0 ? () => setState(() => _currentStep -= 1) : null,
      steps: workout.exercises.map((x) {
        x.setStepPosition(counter);
        counter++;
        return Step(
          title: new Text(
            x.name, style: TextStyle(color: Color(0xff344E5C)),),
          content: ExerciseCard(x),
          isActive: _currentStep >= x.stepPosition,
          state: _currentStep >= x.stepPosition ? StepState.complete : StepState.disabled,
        );
      }
      ).toList(),
      controlsBuilder: (BuildContext context,
          {VoidCallback onStepContinue, VoidCallback onStepCancel}){

        return Row(
          children: <Widget>[
            SizedBox(height: 70.0,),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  new BoxShadow(
                    color: Colors.black12,
                    offset: new Offset(0.0, 3.0),
                  )
                ],
                border: Border.all(color: Colors.black12),
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child:FlatButton(
                child: Text("Next"),
                onPressed: onStepContinue,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  new BoxShadow(
                    color: Colors.black12,
                    offset: new Offset(0.0, 2.0),
                  )
                ],
                border: Border.all(color: Colors.black12),
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child:FlatButton(
                child: Text("Back"),
                onPressed: onStepCancel,
              ),
            ),

          ],
        );
      },
    );
  }
}


class ExerciseCard extends StatelessWidget{
  final ExerciseDto exercise;

  ExerciseCard(this.exercise);



  @override
  Widget build(BuildContext context) {
    double altura;
    if (MediaQuery.of(context).size.width > 600) {
      altura = 500.0;
    } else {
      altura = 250.0;
    }
    return Container(
      child: Card(
        child: InkWell(
          child: Container(
            height: altura,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: PlayerWidget(exerciseDto: exercise),
                ),
                ListTile(
                  title: Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                        exercise.name,
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                        )
                    ),

                  ),
                  subtitle: (exercise.repetitions.contains("\'") ||
                      exercise.repetitions.contains("\""))
                      ? Container()
                      : Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            "Exercise cicle: " + exercise.repetitions,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: new TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: (exercise.repetitions.contains("\'") ||
                      exercise.repetitions.contains("\""))
                      ? Container(
                    height: 40,
                    child: CounterWidget(exercise.repetitions),
                  ) : Container(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class PlayerWidget extends StatefulWidget {
  PlayerWidget({this.exerciseDto});

  final ExerciseDto exerciseDto;

  @override
  State<StatefulWidget> createState() => _PlayerWidgetState();

}


class _PlayerWidgetState extends State<PlayerWidget> {

  @override
  Widget build(BuildContext context) {
    var source = widget.exerciseDto.videoUrl.split("watch?v=");

    return (source.length > 1)
        ?_player(source[1])
        : Container();
  }

  Widget _player(source){
    return YoutubePlayer(
      context: context,
      source: source,
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


class CounterWidget extends StatefulWidget {
  CounterWidget(this.time);
  final String time;

  _CounterWidgetState createState() => _CounterWidgetState(getTime(time), getTime(time));

  int getTime(String time) {
    int _seconds = 0;

    var minutesParts = time.split('\'' );

    if(minutesParts.length > 1){
      var minutes = int.parse(minutesParts[0]);
      _seconds+= 60 * minutes;

      if(minutesParts.length > 2){
        var secondParts = minutesParts[1].split('\"');
        if(secondParts.length > 1){
          var auxSeconds = int.parse(secondParts[0]);
          _seconds+= auxSeconds;
        }
      }

    } else {
      var secondParts = time.split('\"');
      if(secondParts.length > 1){
        var auxSeconds = int.parse(secondParts[0].trim());
        _seconds+= auxSeconds;
      }
    }

    return _seconds;
  }
}


class _CounterWidgetState extends State<CounterWidget>{
  _CounterWidgetState(this._seconds, this._initialValue);


  Timer _timer;
  int _seconds = 0;
  int _initialValue = 0;
  var paused = true;
  var firstPlay = true;


  void startTimer() {
    paused = false;
    if (firstPlay){
      firstPlay = false;
      const oneSec = const Duration(seconds: 1);
      _timer = new Timer.periodic(
        oneSec,
          (Timer timer) =>
          setState(
                () {
              if (_seconds < 1) {
                timer.cancel();
                _seconds = _initialValue;
                firstPlay = true;
              } else if (!paused) {
                _seconds--;
              }
            },
          ),
      );
    }
  }

  void pause(){
    paused = true;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Row(
      children: <Widget>[
        FlatButton(
          onPressed: () {
            startTimer();
          },
          child: Row(
            children: <Widget>[
              Text("Start"),
              new Icon(Icons.play_arrow),
            ],
          ),
        ),
        FlatButton(
          onPressed: () {
            pause();
          },
          child: Row(
              children: <Widget>[
              Text("Stop"),
              new Icon(Icons.pause),
            ],
          ),
        ),
        Expanded(
          child: Center(

            child: Text("$_seconds", style: TextStyle(fontSize: 22),),
          ),
        ),
      ],
    );
  }
}


