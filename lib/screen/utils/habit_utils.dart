// given a habit list of completion days
// is the habit completed today
import 'package:habit_tracker/screen/models/habit.dart';

bool isHabitCompletedToday(List<DateTime> completedDays) {
  final today = DateTime.now();
  return completedDays.any((date) =>
      date.year == today.year &&
      date. month == today.month &&
      date.day == today.day);
}

//prepare heat map dataset

Map<DateTime,int>prepHeatMapDataset(List<habit>Habit)
{
  Map<DateTime,int>dateset={};
  for(var Habit in Habit)
    {
      for(var date in  Habit.completedDays)
        {
            // normalize date to avoid time mismatch
          final normalizedDate =DateTime(date.year,date.month,date.day);
          //if the date already exits in the dataset , increment its count
          if (dateset.containsKey(normalizedDate))
            {
              dateset[normalizedDate]=dateset[normalizedDate]!+1;
            }
          else
            {
              // else initialize it with a count  of 1
              dateset[normalizedDate]=1;
            }
        }
    }
  return dateset;
}