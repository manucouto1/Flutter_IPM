import 'package:bloc/bloc.dart';
import 'workout_event.dart';
import 'workout_state.dart';
import '../workout_dao.dart';
import 'dart:async';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  WorkoutDao _workoutDao = WorkoutDao();

  @override
  WorkoutState get initialState => WorkoutsLoading();

  @override
  Stream<WorkoutState> mapEventToState(WorkoutEvent event) async*{
    if(event is LoadWorkouts){
      yield WorkoutsLoading();
      try {
        final workouts = await _workoutDao.findAll();
        yield WorkoutsLoaded(workouts);
      } catch (_){
        yield WorkoutsFailure();
      }
    }

  }

}