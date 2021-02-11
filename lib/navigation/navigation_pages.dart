import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ipm1920_p2/domine/exercise/bloc/exercise_bloc.dart';
import 'package:ipm1920_p2/domine/exercise/bloc/exercise_event.dart';
import 'package:ipm1920_p2/domine/exercise/view/details/details_view.dart';
import 'package:ipm1920_p2/domine/exercise/view/details/details_view_dto.dart';
import 'package:ipm1920_p2/domine/exercise/view/exercises_view.dart';
import 'package:ipm1920_p2/domine/workout/bloc/workout_bloc.dart';
import 'package:ipm1920_p2/domine/workout/bloc/workout_event.dart';
import 'package:ipm1920_p2/domine/workout/view/training/training_stepper.dart';
import 'package:ipm1920_p2/domine/workout/view/training/training_stepper_dto.dart';
import 'package:ipm1920_p2/domine/workout/view/workouts_view.dart';
import 'package:ipm1920_p2/domine/workout/workout.dart';

class WorkoutsPage extends StatefulWidget {
  static const routeName = '/';

  WorkoutPageState createState() => WorkoutPageState();
}

class WorkoutPageState extends State<WorkoutsPage>{

  ExercisesBloc _bloc = ExercisesBloc();

  Widget _buildPhoneLayout(){
    return BlocProvider<WorkoutBloc>(
      builder: (context) => WorkoutBloc()..add(LoadWorkouts()),
      child: WorkoutsView(
        workoutSelectedCallback: (workout) => Navigator.of(context).pushNamed(
          ExercisesPage.routeName,
          arguments: workout,
        ),
      ),
    );
  }

  Widget _buildTabletLayout(){
    return Row(
      children: <Widget>[
        Flexible(
          flex: 2,
          child: BlocProvider<WorkoutBloc>(
            builder: (context) => WorkoutBloc()..add(LoadWorkouts()),
            child: WorkoutsView(
              workoutSelectedCallback: (workout) => _bloc..add(LoadExercises(workout)),
            ),
          ),
        ),
        Flexible(
          flex: 3,
          child: BlocProvider<ExercisesBloc> (
            builder: (context) => _bloc,
            child: ExercisesView(),
          ),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    Widget content;

    if (MediaQuery.of(context).size.width > 600) {
      content = _buildTabletLayout();
    } else {
       content = _buildPhoneLayout();
    }

    return Scaffold(
      //Color(0xEFFFFFFF)
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: CardTitle('ipm1920_p2'),
        ),
        body: OrientationBuilder( builder: (context, orientation){
          return content;
        }),
      );
    }
}

class ExercisesPage extends StatelessWidget {
  static const routeName = '/exercises';

  @override
  Widget build(BuildContext context) {
    final Workout selected = ModalRoute.of(context).settings.arguments;

    return BlocProvider<ExercisesBloc> (
        builder: (context) => ExercisesBloc()..add(LoadExercises(selected)),
        child: ExercisesView(),
    );

  }
}

class ExercisesInfoPage extends StatelessWidget {
  static const routeName = '/info';

  @override
  Widget build(BuildContext context) {
    final ExerciseDto selected = ModalRoute.of(context).settings.arguments;

    return DetailsView(selected);
  }

}

class TrainingPage extends StatelessWidget {
  static const routeName = '/training';

  Widget _buildTabletLayout(workout){
    return TrainingStepper(workout);
  }

  Widget _buildPhoneLayout(workout) {
    return TrainingStepper(workout);
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    final WorkoutDto selected = ModalRoute.of(context).settings.arguments;

    if (MediaQuery.of(context).size.width > 600) {
      content = _buildTabletLayout(selected);
    } else {
      content = _buildPhoneLayout(selected);
    }

    return Scaffold(
      //Color(0xEFFFFFFF)
      appBar: AppBar(
        title: CardTitle('ipm1920_p2'),
      ),
      body: OrientationBuilder( builder: (context, orientation){
        return content;
      }),
    );
  }

}

// CARD TITLE

class CardTitle extends StatelessWidget {
  final String title;
  CardTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: ListTile(
            //leading:
              title: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(20.0,0.0,20.0,0.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      border: Border.all(
                        width: 2.0,
                        color: Theme.of(context).primaryTextTheme.title.color,
                      ),
                      borderRadius: BorderRadius.all(
                          Radius.circular(15.0)
                      ),
                    ),
                    child: Text(title,
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        color: Theme.of(context).primaryTextTheme.title.color,
                        fontSize: 18.0,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
          ),
        ),

      ],
    );
  }

}