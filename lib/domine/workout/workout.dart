import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:mongo_dart/mongo_dart.dart';

const String _DEFAULT_IMAGE = "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";

class Workout {

  final ObjectId id;
  final String name;
  final String image;
  final String description;
  final List<dynamic> exercises;

  Workout({
    @required this.id,
    @required this.name,
    @required this.image,
    @required this.description,
    @required this.exercises,
  });


  @override
  String toString() {
    return 'Workout{id: $id,\n name: $name,\n description: $description,\n exercises: $exercises\n}';
  }

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'name': name,
      'image': image,
      'description': description,
      'exercises': exercises,
    };
  }

  static Workout fromMap(Map<String, dynamic> map){
    return Workout(
      id: map['id'],
      name: map['name'],
      image: utf8.decode((map['image']!=''?map['image'].byteList:_DEFAULT_IMAGE.codeUnits)),
      description: (map['description'] as List).join("\n"),
      exercises: map['exercises'],
    );
  }

  bool defaultImage(){
    return image ==_DEFAULT_IMAGE;
  }
}