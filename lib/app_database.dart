import 'dart:async';
import 'dart:io';

import 'package:mongo_dart/mongo_dart.dart';

String host = Platform.environment['MONGO_DART_DRIVER_HOST'] ?? '83.165.246.168';
String port = Platform.environment['MONGO_DART_DRIVER_PORT'] ?? '27017';

class AppDatabase {

  static final AppDatabase _singleton = AppDatabase._();

  static AppDatabase get instance => _singleton;

  Completer<Db> _dbOpenCompleter;

  AppDatabase._();

  Future<Db> get database async {

    if(_dbOpenCompleter == null){
      _dbOpenCompleter = Completer();
      _openDatabase();
    }

    return _dbOpenCompleter.future;
  }

  Future _openDatabase() async {
    final Db db = new Db("mongodb://$host:$port/workouts");
    await db.open();
    _dbOpenCompleter.complete(db);
  }

}


