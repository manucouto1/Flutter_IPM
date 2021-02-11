import 'package:ipm1920_p2/domine/exercise/view/details/details_view_dto.dart';
import 'package:meta/meta.dart';

class WorkoutDto {
  final String name;
  final List<ExerciseDto> exercises;
  String description;


  WorkoutDto({
    @required this.name,
    @required this.exercises,
    this.description
  });
}