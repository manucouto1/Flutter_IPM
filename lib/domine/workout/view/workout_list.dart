
import 'package:flutter/cupertino.dart';
import 'package:ipm1920_p2/domine/workout/view/workout_card.dart';
import 'package:ipm1920_p2/domine/workout/workout.dart';

class WorkoutList extends StatelessWidget{

  WorkoutList(
    this.workoutSelectedCallback,
    this.workoutList);

  final List<Workout> workoutList;
  final ValueChanged<Workout> workoutSelectedCallback;

  ListView _buildListView(context) {
    return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return new WorkoutCard(
              this.workoutSelectedCallback,
              workoutList.elementAt(index)
          ).build(context);
        },
        itemCount: workoutList.length);
  }

  @override
  Widget build(BuildContext context) {
    return _buildListView(context);
  }

}