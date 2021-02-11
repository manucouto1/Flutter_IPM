import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ipm1920_p2/domine/exercise/bloc/exercise_bloc.dart';
import 'package:ipm1920_p2/domine/exercise/bloc/exercise_state.dart';
import 'package:ipm1920_p2/domine/exercise/view/exercise_list.dart';
import 'package:ipm1920_p2/domine/workout/view/training/training_stepper_dto.dart';
import 'package:ipm1920_p2/domine/workout/workout.dart';
import 'package:ipm1920_p2/navigation/navigation_pages.dart';


class ExercisesView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Workout selected;
    return BlocBuilder<ExercisesBloc, ExerciseState>(
        builder: (context, state) {
          if (state is ExercisesLoaded) {
            selected = state.selected;
            return Scaffold(
                body: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    pinned: true,
                    floating: true,
                    snap: true,
                    expandedHeight: 175.0,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Container(
                        //width: 150,
                        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          border: Border.all(
                            width: 2.0,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.all(
                              Radius.circular(15.0)
                          ),
                        ),
                        child: Text(selected.name,
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      background: (selected.defaultImage())
                          ? NoBackGround().build(context)
                          : BackGround(selected.image).build(context),
                    ),

                  ),
                  SelectedWorkoutCard(selected.description).build(context),
                  ExercisesList(selected, state),
                ]
              ),
              floatingActionButton: new FloatingActionButton(
                  child: new Icon(Icons.directions_run),
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      TrainingPage.routeName,
                      arguments: WorkoutDto(name: selected.name, exercises: state.exercises),
                    );
                  }
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        }

    );
  }
}


class NoBackGround extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25.0, bottom: 20.0),
      decoration: BoxDecoration(
        boxShadow: [
          new BoxShadow(
            color: Colors.black12,
            offset: new Offset(0.0, 10.0),
          )
        ],
        border: Border.all(color: Colors.black12),
        shape: BoxShape.circle,
        color: Colors.white,
      ),
    );
  }

}

class BackGround extends StatelessWidget {
  final String image;
  BackGround(this.image);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25.0, bottom: 20.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        color: Colors.white,
        //shape: BoxShape.circle,
        image: DecorationImage(
          image: Image.memory(
            base64.decode(image),
          ).image,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

}

class SelectedWorkoutCard extends StatelessWidget {
  final String headerText;

  SelectedWorkoutCard(this.headerText);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children:[
          Container(
            padding: EdgeInsets.fromLTRB(20.0,10.0,20.0,10.0),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            alignment: Alignment.center,
            child: Center(
              child: Text(headerText,
                textAlign: TextAlign.center,
                style: new TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 15.0,
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                ),
              )
            )
          ),
        ]
      ),
    );
  }


}