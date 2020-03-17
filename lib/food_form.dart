import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterblocsqflite/bloc/food_bloc.dart';
import 'package:flutterblocsqflite/db/database_provider.dart';
import 'package:flutterblocsqflite/event/add_food.dart';
import 'package:flutterblocsqflite/event/update_food.dart';
import 'package:flutterblocsqflite/home_page.dart';
import 'package:flutterblocsqflite/model/food_model.dart';

class FoodForm extends StatefulWidget {
  final Food food;
  final int foodIndex;

  FoodForm({this.food, this.foodIndex});

  @override
  State<StatefulWidget> createState() {
    return FoodFormState();
  }
}

class FoodFormState extends State<FoodForm> {
  String _name;
  String _calories;
  bool _isVegetarian = false;
  int _id;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      initialValue: _name,
      decoration: InputDecoration(labelText: 'Name'),
      maxLength: 15,
      style: TextStyle(fontSize: 28),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  Widget _buildCalories() {
    return TextFormField(
      initialValue: _calories,
      decoration: InputDecoration(labelText: 'Calories'),
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: 28),
      validator: (String value) {
        int calories = int.tryParse(value);

        if (calories == null || calories <= 0) {
          return 'Calories must be greater than 0';
        }

        return null;
      },
      onSaved: (String value) {
        _calories = value;
      },
    );
  }

  Widget _buildIsVegetarian() {
    return SwitchListTile(
      title: Text("Vegetarian?", style: TextStyle(fontSize: 20)),
      value: _isVegetarian,
      onChanged: (bool newValue) => setState(() {
        _isVegetarian = newValue;
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.food != null) {
      _name = widget.food.name;
      _calories = widget.food.calories;
      _isVegetarian = widget.food.isVegetarian;
      _id=widget.food.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Food Form")),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildName(),
                _buildCalories(),
                SizedBox(height: 16),
                _buildIsVegetarian(),
                SizedBox(height: 20),
                widget.food == null
                ? RaisedButton(
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }

                    _formKey.currentState.save();

                    Food food = Food(
                      name: _name,
                      calories: _calories,
                      isVegetarian: _isVegetarian,
                    );

                    DatabaseProvider.db.insert(food).then(
                          (storedFood) => BlocProvider.of<FoodBloc>(context).add(
                        AddFood(storedFood),
                      ),
                    );

                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => HomePage()));

                  },
                )
                : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      child: Text(
                        "Update",
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                      onPressed: () {
                        if (!_formKey.currentState.validate()) {
                          print("form");
                          return;
                        }
                        _formKey.currentState.save();
                        Food food = Food(
                          name: _name,
                          calories: _calories,
                          isVegetarian: _isVegetarian,
                          id: _id,
                        );

                        DatabaseProvider.db.update(food).then(
                              (_) => BlocProvider.of<FoodBloc>(context).add(
                            UpdateFood(widget.foodIndex, food),
                          ),
                        );

                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context) => HomePage()));
                      },
                    ),
                    RaisedButton(
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context) => HomePage()));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}