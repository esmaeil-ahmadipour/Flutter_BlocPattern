import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterblocsqflite/db/database_provider.dart';
import 'package:flutterblocsqflite/event/delete_food.dart';
import 'package:flutterblocsqflite/event/set_foods.dart';
import 'package:flutterblocsqflite/food_form.dart';
import 'package:flutterblocsqflite/model/food_model.dart';
import 'package:flutterblocsqflite/ui/themes/settings_page.dart';

import 'bloc/food_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    DatabaseProvider.db.getFoods().then(
      (foodList) {
        BlocProvider.of<FoodBloc>(context).add(SetFoods(foodList));
      },
    );
  }

  showFoodDialog(BuildContext context, Food food, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(food.name),
        content: Text("ID ${food.id}"),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => FoodForm(food: food, foodIndex: food.id),
              ),
            ),
            child: Text("Update"),
          ),
          FlatButton(
            onPressed: () => DatabaseProvider.db.delete(food.id).then((_) {
              BlocProvider.of<FoodBloc>(context).add(
                DeleteFood(index),
              );
              Navigator.pop(context);
            }),
            child: Text("Delete"),
          ),
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
   String _title = "Food List";
    return Scaffold(
      appBar: AppBar(
          title: Text(_title),
        actions: <Widget>[
          InkWell(child: Icon(Icons.settings , color: Colors.white,) , onTap: (){
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => SettingsPage(
                    title: _title,
                  )),
            );
          },),
        ],

      ),
      body: Container(
        child: BlocConsumer<FoodBloc, List<Food>>(
          builder: (context, foodList) {
            return ListView.separated(
              itemBuilder: (BuildContext context, int index) {


                Food food = foodList[index];
                return ListTile(
                    title: Text(food.name , style: TextStyle(fontSize: 30)),
                    subtitle: Text(
                      "Calories: ${food.calories}\n Vegetarian: ${food.isVegetarian}",
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () => showFoodDialog(context, food, index));
              },
              itemCount: foodList.length,
              separatorBuilder: (BuildContext context, int index) =>
                  Divider(color: Colors.black),
            );
          },
          listener: (BuildContext context, foodList) {},
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) => FoodForm()),
        ),
      ),
    );
  }
}
