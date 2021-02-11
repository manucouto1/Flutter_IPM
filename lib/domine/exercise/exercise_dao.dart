import 'package:ipm1920_p2/app_database.dart';
import 'package:ipm1920_p2/domine/exercise/exercise.dart';
import 'package:mongo_dart/mongo_dart.dart';

class ExerciseDao{
  static const String EXERCISE_COLLECTION_NAME = 'exercises';

  Future<DbCollection> get _exercisesCollection async =>
      (await AppDatabase.instance.database).collection(EXERCISE_COLLECTION_NAME);

  Future insert(Exercise exercise) async {
    (await _exercisesCollection).insert(exercise.toMap());
  }

  Future update(Exercise exercise) async {
    (await _exercisesCollection).update(where.id(exercise.id), exercise.toMap());
  }

  Future delete(Exercise exercise) async {
    (await _exercisesCollection).remove(where.id(exercise.id));
  }

  Future<List<Exercise>> findAll() async {
    final resultStream = (await _exercisesCollection).find();
    return resultStream.map((x) => Exercise.fromMap(x)).toList();
  }


}