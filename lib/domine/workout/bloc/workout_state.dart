
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../workout.dart';

@immutable
abstract class WorkoutState extends Equatable {
  const WorkoutState();

  @override
  List<Object> get props => [];
}

class WorkoutsFailure extends WorkoutState {}

class WorkoutsLoading extends WorkoutState {}

class WorkoutsLoaded extends WorkoutState {
  final List<Workout> workouts;

  const WorkoutsLoaded(this.workouts);

  @override
  List<Object> get props => workouts;

}