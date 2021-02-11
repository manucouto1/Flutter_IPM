import 'package:equatable/equatable.dart';
import 'package:ipm1920_p2/domine/workout/workout.dart';

class ExerciseEvent extends Equatable{
  const ExerciseEvent();
  @override
  List<Object> get props => [];
}

class ReadyToLoad extends ExerciseEvent {}
class LoadExercises extends ExerciseEvent {
  final Workout workout;
  const LoadExercises(this.workout);

  @override
  List<Object> get props => [workout];
}
