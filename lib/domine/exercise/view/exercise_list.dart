import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ipm1920_p2/domine/exercise/bloc/exercise_state.dart';
import 'package:ipm1920_p2/domine/exercise/view/exericise_card.dart';
import 'package:ipm1920_p2/domine/workout/workout.dart';

class ExercisesList extends StatelessWidget {
  final Workout workout;
  final ExerciseState state;

  ExercisesList(this.workout, this.state);

  @override
  Widget build(BuildContext context) {
    return SliverFixedExtentList(
      itemExtent: 200.0,
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        if (state is ExercisesLoaded) {
          if (state.props.isEmpty) {
            return Center(
              child: Text('no content'),
            );
          }

          return Container(
            alignment: Alignment.center,
            color: Theme.of(context).primaryColor,
            child: ExerciseCard(state.props.elementAt(index)).build(context),
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
        childCount: (state.props != null && state.props.length > 0) ? state.props
            .length : 1,
      ),
    );
  }

}