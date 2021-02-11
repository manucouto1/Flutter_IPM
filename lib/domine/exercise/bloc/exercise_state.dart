import 'package:equatable/equatable.dart';
import 'package:ipm1920_p2/domine/exercise/view/details/details_view_dto.dart';
import 'package:ipm1920_p2/domine/workout/workout.dart';

class ExerciseState extends Equatable {
  const ExerciseState();

  @override
  List<Object> get props => [];
}

class ExercisesFailure extends ExerciseState {}

class ExercisesLoading extends ExerciseState {}

class ExercisesLoaded extends ExerciseState {
  final List<ExerciseDto> exercises;
  final Workout selected;

  const ExercisesLoaded(this.exercises, this.selected);

  @override
  List<Object> get props => exercises;

}
