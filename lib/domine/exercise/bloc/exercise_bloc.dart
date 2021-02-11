import 'package:bloc/bloc.dart';
import 'package:ipm1920_p2/domine/exercise/exercise.dart';
import 'package:ipm1920_p2/domine/exercise/view/details/details_view_dto.dart';
import 'package:ipm1920_p2/domine/workout/workout.dart';

import '../exercise_dao.dart';
import 'exercise_event.dart';
import 'exercise_state.dart';

class ExercisesBloc extends Bloc<ExerciseEvent, ExerciseState>{
  ExerciseDao _exerciseDao = ExerciseDao();

  @override
  ExerciseState get initialState => ExercisesLoading();

  @override
  Stream<ExerciseState> mapEventToState(ExerciseEvent event) async*{
    if(event is LoadExercises){
      yield ExercisesLoading();
      try{
        Workout selected = event.props[0];
        List<ExerciseDto> workoutExercises = List();
        final List<Exercise> exercises = await _exerciseDao.findAll();

        for(var w_exercises in selected.exercises){
          var found = false;
          for(var exercise in exercises) {
            if(exercise.name == w_exercises[0]){
              found = true;
              workoutExercises.add(
                  ExerciseDto(
                    name:exercise.name,
                    image: exercise.image,
                    videoUrl:exercise.videoUrl,
                    repetitions:w_exercises[1],
                      description: exercise.description,
                  )
              );
            }
          }

          if( ! found ){
            workoutExercises.add(
                ExerciseDto(
                  name:w_exercises[0],
                  image: DEFAULT_IMAGE,
                  videoUrl: DEFAULT_VIDEO,
                  repetitions: w_exercises[1],
                  description: "",
                )
            );
          } else {
            found = false;
          }

        }
        if (workoutExercises.length == 0)
          workoutExercises.add(
              ExerciseDto(
                name:" No Hay Ejercicios",
                image: DEFAULT_IMAGE,
                videoUrl: DEFAULT_VIDEO,
                repetitions: "",
                description: "",
              )
          );

        //List<Exercise> filtered = selected.exercises.map((exercise)=> exercises.firstWhere((e) => e.name == exercise.nam)).toList();
        yield ExercisesLoaded(workoutExercises, selected);
      } catch (_) {
        yield ExercisesFailure();
      }
    }

  }

}