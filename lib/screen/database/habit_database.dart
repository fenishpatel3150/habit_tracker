import 'package:flutter/material.dart';
import 'package:habit_tracker/screen/models/app_setings.dart';
import 'package:habit_tracker/screen/models/habit.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class HabitDatabase extends ChangeNotifier {
  static late Isar isar;

  /*
        S E T U P
   */

  // I N I T I A L I Z E - DATA-BASE
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar =
        await Isar.open([HabitSchema, AppSettingsSchema], directory: dir.path);
  }

// save first date of app startup  (for heatmap)
  static Future<void> saveFirstLaunchDate() async {
    final exitingSettings = await isar.appSettings.where().findFirst();
    if (exitingSettings == null) {
      final settings = AppSettings()..firstLaunchDate = DateTime.now();
      await isar.writeTxn(() => isar.appSettings.put(settings));
    }
  }

// get free date of app startup (for heatmap)
  Future<DateTime?> getFirstLaunchDate() async {
    final settings = await isar.appSettings.where().findFirst();
    return settings?.firstLaunchDate;
  }

/*
    C R U D X operations
 */
// List of habit
  final List<habit> currentHabit = [];

//CREATE = ADD  A NEW HABIT

  Future<void> addHabit(String habitName) async {
    // create a new habit
    final newHabit = habit()..name = habitName;
    //save to db
    await isar.writeTxn(() => isar.habits.put(newHabit));
    //  re- read for db
    readHabits();
  }

  //READ = READ SAVED HABIT FROM DB
  Future<void> readHabits() async {
    // fetch all habits from db
    List<habit> fetchedhabits = await isar.habits.where().findAll();
    // give to current habit
    currentHabit.clear();
    currentHabit.addAll(fetchedhabits);
    // update UI
    notifyListeners();
  }

  //UPDATE = CHECK HABIT ON AND OFF
  Future<void> updateHabitCompletion(int id, bool iscompleted) async {
    //find the specific habit
    final habit = await isar.habits.get(id);
    //update completion status
    if (habit != null) {
      await isar.writeTxn(() async {
        // if habit is completed -> add the current date to the completedDays list
        if (iscompleted && !habit.completedDays.contains(DateTime.now())) {
          //today
          final today = DateTime.now();
          //add the current date if it's not already in the list
          habit.completedDays.add(DateTime(today.year, today.month, today.day));
        }
        //if habit is NOT completed -> remove the current date from the list
        else {
          // remove the current date if the habit is marked as not completed
          habit.completedDays.removeWhere((date) =>
              date.year == DateTime.now().year &&
              date.year == DateTime.now().month &&
              date.year == DateTime.now().day);
        }
        // save the updated habit back to the db
        await isar.habits.put(habit);
      });
    }
    // re-read from db
    readHabits();
  }

//UPDATE  = EDIT HABIT NAME
  Future<void> updateHabitName(int id, String newName) async {
    //find the specific habit
    final habit = await isar.habits.get(id);
    // update habit db
    if (habit != null) {
      //update name
      await isar.writeTxn(() async {
        habit.name=newName;
        //save updated habit back to the db
        await isar.habits.put(habit);
      });
    }
    // re- read from db
    readHabits();
  }

//DELETE = DELETE HABIT
  Future<void>deletehabit(int id)
  async {
    //perform the delete
    await isar.writeTxn(()async {
      await isar.habits.delete(id);

    });
    //re-read from db
    readHabits();
  }
}
