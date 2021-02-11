import 'package:ipm1920_p2/app_database.dart';
import 'package:ipm1920_p2/domine/workout/workout.dart';
import 'package:mongo_dart/mongo_dart.dart';

class WorkoutDao {
  static const String WORKOUT_COLLECTION_NAME = 'workouts';

  Future<DbCollection> get _workoutCollection async =>
      (await AppDatabase.instance.database).collection(WORKOUT_COLLECTION_NAME);


  Future insert(Workout workout) async {
    (await _workoutCollection).insert(workout.toMap());
  }

  Future update(Workout workout) async {
    (await _workoutCollection).update(where.id(workout.id), workout.toMap());
  }

  Future delete(Workout workout) async {
    (await _workoutCollection).remove(where.id(workout.id));
  }

  Future<List<Workout>> findAll() async {
    final resultStream = (await _workoutCollection).find();
    return resultStream.map((x) => Workout.fromMap(x)).toList();
  }

}