import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ipm1920_p2/domine/workout/workout.dart';

class WorkoutCard extends StatelessWidget{
  WorkoutCard(
      this.workoutSelectedCallback,
      this.workout);

  final Workout workout;
  final ValueChanged<Workout> workoutSelectedCallback;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.only(top:4, bottom: 4, left: 5, right: 5),
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),

          onTap: () {
            workoutSelectedCallback(workout);
          },
          child:CardContent(workout).build(context),
        ),
      ),
    );
  }

}

class CardContent extends StatelessWidget {
  final Workout workout;
  CardContent(this.workout);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryTextTheme.title.color,
              border: Border.all(
                width: 0.5,
              ),
              boxShadow: [
                BoxShadow(
                  color:Colors.black12,
                  offset: Offset(0.0, 3.0),
                )
              ]
            ),
            child: CardTitle(workout).build(context),
          ),
          Container(
            margin: EdgeInsets.only(top: 3.0),
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.18,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black12
                ),
              ),
              image: DecorationImage(
                image: MemoryImage(base64.decode(workout.image), scale: 0.25),
                fit: (workout.defaultImage())?BoxFit.cover:BoxFit.contain,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only( top: 10, bottom: 10),
            color: Color(0xDFFFFFFF),
            child: BodyContent(workout).build(context),
          )
        ],
      ),
    );
  }
}


class CardTitle extends StatelessWidget {
  final Workout workout;
  CardTitle (this.workout);

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
                      color: Theme.of(context).primaryTextTheme.title.color,
                      border: Border.all(
                        width: 2.0,
                        color: Colors.black12,
                      ),
                      borderRadius: BorderRadius.all(
                          Radius.circular(15.0)
                      ),
                    ),
                    child: Text(workout.name,
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        color: Colors.black54,
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

class BodyContent extends StatelessWidget {
  final Workout workout;
  BodyContent(this.workout);


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child:ListTile(
        leading: Icon(Icons.directions_run, size: 40,),
        subtitle: Column(
            children: [
              Container(
                height: 45,
                child: Text(
                  workout.description,
                  overflow: TextOverflow.clip,
                  style: new TextStyle(
                    fontSize: 13.0,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                  height: 30,
                  child: Row(
                    children: <Widget>[
                      Text("See Exercises"),
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