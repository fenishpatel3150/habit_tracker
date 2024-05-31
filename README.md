
<h2 align = "center"> 1. Habit Tracker Application  </h2>

<h1> Overview </h1>
The Habit Tracker Application is designed to help users build and maintain positive habits by tracking their daily activities. Users can set goals, mark their progress, and visualize their achievements over time. The app provides a user-friendly interface with interactive features to keep users motivated and engaged.

<h1>Key Features</h1>
1. **Daily Habit Tracking**: Users can create and manage a list of daily habits they want to track. Each habit can be marked as completed for the day.
2. **Visual Progress**: A heatmap calendar displays the user's progress over time, allowing them to see their streaks and overall consistency.
3. **Reminders and Notifications**: Users can set reminders for each habit to ensure they stay on track.
4. **Statistics and Insights**: The app provides insights into the user's habits, such as the longest streak, total completions, and more.
5. **Customizable Themes**: Users can choose from a variety of themes to personalize the look and feel of the app.

<h1> Packages Used</h1>

1. **flutter_heatmap_calendar: ^1.0.5**
   - This package is used to create a heatmap calendar, which visually represents the user's habit tracking data. It helps users see their progress at a glance.

2. **flutter_slidable: ^3.1.0**
   - This package provides a way to add swipeable actions to list items. It's used in the habit list to allow users to easily edit or delete habits by sliding the list items.

3. **isar: ^3.1.0+1**
   - Isar is a high-performance database solution used to store the user's habits and tracking data locally on their device. It ensures that data retrieval and storage are fast and efficient.

4. **isar_flutter_libs: ^3.1.0+1**
   - This package provides the necessary Flutter bindings for the Isar database, enabling seamless integration with the app.

5. **path_provider: ^2.1.3**
   - The `path_provider` package is used to locate the file system directories on the device, such as the documents directory. It's essential for accessing and storing the database files.

6. **provider: ^6.1.2**
   - The `provider` package is a state management solution that helps manage the state of the application efficiently. It is used to handle the state of the habit list, user settings, and other dynamic data.

7. **shared_preferences: ^2.2.3**
   - This package allows the app to store simple key-value pairs locally. It is used for storing user preferences, such as theme settings and notification preferences.

<h1> Implementation Outline </h1>

1. **User Interface**
   - Design the main screen with a list of habits.
   - Add a floating action button (FAB) to add new habits.
   - Integrate the heatmap calendar to visualize daily habit completions.
   - Use `flutter_slidable` for swipe actions on habit list items.

2. **State Management**
   - Use `provider` to manage the state of the habit list and user settings.
   - Implement ChangeNotifier classes to handle habit addition, deletion, and completion status updates.

3. **Data Storage**
   - Use `isar` to create a local database for storing habits and their completion status.
   - Implement methods for CRUD (Create, Read, Update, Delete) operations on habits.
   - Use `path_provider` to determine the location for storing the database file.

4. **User Preferences**
   - Use `shared_preferences` to store user preferences such as selected theme and notification settings.

5. **Notifications**
   - (Optional) Implement local notifications to remind users to complete their habits.

#### Example Code Snippets

- **Heatmap Calendar Integration**
  ```dart
  HeatMap(
    datasets: habitTrackingData,
    colorsets: {1: Colors.green},
  )
  ```

- **Slidable List Item**
  ```dart
  Slidable(
    actionPane: SlidableDrawerActionPane(),
    actions: [
      IconSlideAction(
        caption: 'Edit',
        color: Colors.blue,
        icon: Icons.edit,
        onTap: () => _editHabit(habit),
      ),
      IconSlideAction(
        caption: 'Delete',
        color: Colors.red,
        icon: Icons.delete,
        onTap: () => _deleteHabit(habit),
      ),
    ],
    child: ListTile(
      title: Text(habit.name),
      trailing: Checkbox(
        value: habit.isCompleted,
        onChanged: (bool? value) {
          setState(() {
            habit.isCompleted = value!;
          });
        },
      ),
    ),
  )
  ```

- **Provider Setup**
  ```dart
  class HabitProvider with ChangeNotifier {
    List<Habit> _habits = [];
    // CRUD methods for habits
  }

  // In main.dart
  ChangeNotifierProvider(
    create: (context) => HabitProvider(),
    child: MyApp(),
  );
  ```

#### Conclusion
This Habit Tracker Application provides a comprehensive solution for users looking to build and maintain positive habits. By leveraging the specified Flutter packages, the app ensures a smooth and efficient user experience with robust state management and data storage capabilities.

#### **Light Theme
<img src = "https://github.com/fenishpatel3150/habit_tracker/assets/143187609/25aee339-64ed-4039-999a-fe6c89f03cdf" width=22% height=35%>
<img src = "https://github.com/fenishpatel3150/habit_tracker/assets/143187609/6ebcfd8d-4ea3-4fd8-abac-9ee039105150" width=22% height=35%>

#### **Dark Theme
<img src = "https://github.com/fenishpatel3150/habit_tracker/assets/143187609/9e70efce-202c-4882-898f-b05bbbeab8f1" width=22% height=35%>
<img src = "https://github.com/fenishpatel3150/habit_tracker/assets/143187609/34b761d4-2b50-41e8-9a57-b6305ca71b78" width=22% height=35%>




https://github.com/fenishpatel3150/habit_tracker/assets/143187609/16966bd9-74e9-4d7b-bd62-c79c48b3a8fd








