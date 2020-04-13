import 'package:flutterblocsqflite/db/main_db_provider.dart';

class Food {
  int id;
  String name;
  String calories;
  bool isVegetarian;

  Food({this.id, this.name, this.calories, this.isVegetarian});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.COLUMN_NAME: name,
      DatabaseProvider.COLUMN_CALORIES: calories,
      DatabaseProvider.COLUMN_VEGETARIAN: isVegetarian ? "1" : "0",
    };
    if (id != null) {
      map[DatabaseProvider.COLUMN_ID] = id;
    }
    return map;
  }

  Food.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseProvider.COLUMN_ID];
    calories = map[DatabaseProvider.COLUMN_CALORIES];
    name = map[DatabaseProvider.COLUMN_NAME];
    isVegetarian = map[DatabaseProvider.COLUMN_VEGETARIAN] == "0" ? false : true;
  }
}
