import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

Future<Database> getDatabase() async {
  final directory = await getApplicationDocumentsDirectory();
  final path = join(directory.path, 'meal_counts.db');
  return openDatabase(
    path,
    version: 1,
    onCreate: (Database db, int version) {
      return db.execute(
        'CREATE TABLE MealCounts (mealName TEXT PRIMARY KEY, count INTEGER)',
      );
    },
  );
}

Future<void> saveMealCount(String mealName, int count) async {
  final db = await getDatabase();
  await db.insert(
    'MealCounts',
    {'mealName': mealName, 'count': count},
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<int> loadMealCount(String mealName) async {
  final db = await getDatabase();
  final maps = await db.query(
    'MealCounts',
    where: 'mealName = ?',
    whereArgs: [mealName],
  );
  if (maps.isNotEmpty) {
    return maps.first['count'] as int;
  } else {
    return 0;
  }
}
