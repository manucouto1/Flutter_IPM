import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ipm1920_p2/domine/exercise/view/details/details_view_dto.dart';
import 'package:ipm1920_p2/navigation/navigation_pages.dart';

class ExerciseCard extends StatelessWidget {
  final ExerciseDto exercise;
  const ExerciseCard(this.exercise);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            Navigator.of(context).pushNamed(
              ExercisesInfoPage.routeName,
              arguments: exercise,
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                width: 150,
                height: 200,
                //color: Colors.grey,
                child: Image.memory(
                  base64.decode(exercise.image),
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: ListTile(
                  title: Container(
                    height: 60,
                    padding: EdgeInsets.only( top: 20),
                    child: Text(
                        exercise.name,
                        style:new TextStyle(
                          fontWeight: FontWeight.bold,
                        )
                    ),
                  ),
                  subtitle: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 84,
                          padding: EdgeInsets.only( top: 0),
                          child: Text(
                            exercise.description,
                            overflow: TextOverflow.fade,
                            style: new TextStyle(
                              fontSize: 14.0,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only( top: 10),
                          child: Text(
                            "Exercise cicle: "+exercise.repetitions,
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
              ),
              Icon(Icons.arrow_right),
            ],
          ),
        ),
      ),
    );
  }
}