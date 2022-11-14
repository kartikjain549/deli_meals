import '/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import './category_meals_screen.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = 'Filters';
  final Function saveFilters;
  final Map<String, bool> _currrentFilters;
  FiltersScreen(this._currrentFilters, this.saveFilters);

  @override
  State<FiltersScreen> createState() => FiltersScreenState();
}

class FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;
  @override
  void initState() {
    _glutenFree = widget._currrentFilters['gluten']!;
    _lactoseFree = widget._currrentFilters['lactose']!;
    _vegetarian = widget._currrentFilters['vegetarian']!;
    _vegan = widget._currrentFilters['vegan']!;
    super.initState();
  }

  Widget _buildSwitchListTile(String title, String description,
      bool currentValue, Function updateValue) {
    return SwitchListTile(
        title: Text(title),
        value: currentValue,
        subtitle: Text(description),
        onChanged: (newValue) {
          updateValue(newValue);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
        actions: [
          IconButton(
              onPressed: () {
                final selectedFilters = {
                  'gluten': _glutenFree,
                  'vegetarian': _vegetarian,
                  'vegan': _vegan,
                  'lactose': _lactoseFree,
                };
                widget.saveFilters(selectedFilters);
                Navigator.of(context).pop(CategoryMealsScreen.routeName);
              },
              icon: Icon(Icons.save)),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text('Adjust your Meal Selection'),
          ),
          Expanded(
              child: ListView(children: <Widget>[
            _buildSwitchListTile(
                'Gluten Free', 'Only Includes gluten free Recipes', _glutenFree,
                (newValue) {
              setState(() {
                _glutenFree = newValue;
              });
            }),
            _buildSwitchListTile('Lactose Free',
                'Only Includes Lactose free Recipes', _lactoseFree, (newValue) {
              setState(() {
                _lactoseFree = newValue;
              });
            }),
            _buildSwitchListTile(
                'Vegetarian', 'Only includes Vegetarian Recipes', _vegetarian,
                (newValue) {
              setState(() {
                _vegetarian = newValue;
              });
            }),
            _buildSwitchListTile('Vegan', 'Only includes Vegan Recipes', _vegan,
                (newValue) {
              setState(() {
                _vegan = newValue;
              });
            }),
          ]))
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
