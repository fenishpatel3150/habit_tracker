import 'package:flutter/material.dart';
import 'package:habit_tracker/screen/database/habit_database.dart';
import 'package:habit_tracker/screen/models/habit.dart';
import 'package:habit_tracker/screen/utils/habit_utils.dart';
import 'package:habit_tracker/screen/view/commponets/my_drawer.dart';
import 'package:habit_tracker/screen/view/commponets/my_habit_tile.dart';
import 'package:habit_tracker/screen/view/commponets/my_heat_map.dart';
import 'package:provider/provider.dart';


class Home_Screen extends StatefulWidget {
  Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  @override
  void initState() {
    // read existing habits on app startup
    Provider.of<HabitDatabase>(context, listen: false).readHabits();
    super.initState();
  }

  final TextEditingController textcontroller = TextEditingController();

  //createNewHabit
  void createNewHabit() {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            content: TextField(
              controller: textcontroller,
              decoration: InputDecoration(
                hintText: "Create a new Habit",
              ),
            ),
            actions: [
              // save button
              MaterialButton(
                onPressed: () {
                  // get new habit name
                  String newHabitName = textcontroller.text;
                  //save to db
                  context.read<HabitDatabase>().addHabit(newHabitName);
                  //pop box
                  Navigator.pop(context);
                  // clear controller
                  textcontroller.clear();
                },
                child: Text('Save'),
              ),
              //cancel button
              MaterialButton(
                onPressed: () {
                  //pop box
                  Navigator.pop(context);
                  //clear controller
                  textcontroller.clear();
                },
                child: Text('Cancel'),
              ),
            ],
          ),
    );
  }

  // check habit on && off
  void checkHabitOnOff(bool? value, habit Habit) {
    // update habit completion status
    if (value != null) {
      context.read<HabitDatabase>().updateHabitCompletion(Habit.id, value);
    }
  }

  //edit habit
  void editHabitBox(habit Habit) {
    textcontroller.text = Habit.name;
    showDialog(context: context, builder: (context) =>
        AlertDialog(
          content: TextField(
            controller: textcontroller,
          ),
          actions: [
            // save button
            MaterialButton(
              onPressed: () {
                // get new habit name
                String newHabitName = textcontroller.text;
                //save to db
                context.read<HabitDatabase>().updateHabitName(
                    Habit.id, newHabitName);
                //pop box
                Navigator.pop(context);
                // clear controller
                textcontroller.clear();
              },
              child: Text('Save'),
            ),
            //cancel button
            MaterialButton(
              onPressed: () {
                //pop box
                Navigator.pop(context);
                //clear controller
                textcontroller.clear();
              },
              child: Text('Cancel'),
            ),
          ],
        ),);
  }

  //delete habit

  void delteHabitBox(habit Habit) {
    showDialog(context: context, builder: (context) =>
        AlertDialog(
          title: Text('Are you sure you want to delted ?'),
          actions: [
            // deleted button
            MaterialButton(
              onPressed: () {
                //save to db
                context.read<HabitDatabase>().deletehabit(Habit.id);
                //pop box
                Navigator.pop(context);
              },
              child: Text('Deleted'),
            ),
            //cancel button
            MaterialButton(
              onPressed: () {
                //pop box
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        ),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Theme
              .of(context)
              .colorScheme
              .inversePrimary,
        ),
        drawer: My_Deawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewHabit,
          elevation: 0,
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .onSecondary,
          child: Icon(
            Icons.add,color: Theme
              .of(context)
              .colorScheme
              .onPrimary,
          ),
        ),
        body: ListView(
          children: [
            //heatmap
            _buildHeatMap(),
            //habitlist
            _buildHabitList()
          ],
        )
    );
  }

  //build heat map

  Widget _buildHeatMap() {
    // habit database
    final Habitdatabase = context.watch<HabitDatabase>();
    //current habit
    List<habit>currentHabits = Habitdatabase.currentHabit;
    //return heat map UI
    return FutureBuilder<DateTime?>(
      future: Habitdatabase.getFirstLaunchDate(),
      builder: (context, snapshot) {
        //once the data is  available -> build heatmap
        if (snapshot.hasData) {
          return MyHeatMap(startDate: snapshot.data!,
              datasets: prepHeatMapDataset(currentHabits));
        }
        // handle case where no data is returned
        else {
          return Container();
        }
      },
    );
  }


//build Habit List
  Widget _buildHabitList() {
    // habit db
    final habitDatabase = context.watch<HabitDatabase>();
    //current habit
    List<habit> currentHabits = habitDatabase.currentHabit;
    // return list of habits UI
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: currentHabits.length,
      itemBuilder: (context, index) {
        // get each individual habit
        final habit = currentHabits[index];
        // check if the habit is completed today
        bool isCompletedToday = isHabitCompletedToday(habit.completedDays);
        // return habit tile Ui
        return My_habit_tile(
          isCompleted: isCompletedToday,
          text: habit.name,
          onChanged: (value) => checkHabitOnOff(value, habit),
          editHabit: (context) => editHabitBox(habit),
          deleteHabit: (context) => delteHabitBox(habit),
        );
      },
    );
  }
}
