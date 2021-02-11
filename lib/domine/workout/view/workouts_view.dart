
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ipm1920_p2/domine/workout/bloc/workout_bloc.dart';
import 'package:ipm1920_p2/domine/workout/bloc/workout_state.dart';
import 'package:ipm1920_p2/domine/workout/view/workout_list.dart';
import 'package:ipm1920_p2/domine/workout/workout.dart';

class WorkoutsView extends StatelessWidget {
  WorkoutsView({
    @required this.workoutSelectedCallback,
  });

  final ValueChanged<Workout> workoutSelectedCallback;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutBloc, WorkoutState>(
        builder: (context, state) {
          if (state is WorkoutsFailure) {
            return Center(
              child: Text('Oops something went wrong!'),
            );
          }
          if (state is WorkoutsLoaded) {
            if (state.workouts.isEmpty) {
              return Center(
                child: Text('no content'),
              );
            }
            if (MediaQuery.of(context).size.width > 600) {
              this.workoutSelectedCallback(state.workouts.elementAt(0));
            }

            return WorkoutList(workoutSelectedCallback,state.workouts);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );
    }
}