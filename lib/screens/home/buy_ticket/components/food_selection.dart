// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

class FoodSelection extends StatefulWidget {
  String title;
  List<double> prices;
  List<String> labelPrices;

  FoodSelection({
    this.title = "",
    this.prices = const [2.0, 3.0, 4.0],
    this.labelPrices = const ["Piccolo", "Medio", "Grande"],
  });

  @override
  _FoodSelectionState createState() => _FoodSelectionState();
}

class _FoodSelectionState extends State<FoodSelection> {
  List<int> _itemCount;

  @override
  void initState() {
    _itemCount = List<int>.generate(widget.prices.length, (i) => 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.prices.length == 1)
      return Padding(
        padding: EdgeInsets.only(left: 30),
        child: _buildFoodEntry(
          0,
          widget.title,
          "Prezzo: ${widget.prices[0]}",
        ),
      );
    else {
      List<Widget> _foodEntries = [];
      for (int i = 0; i < widget.prices.length; i++) {
        _foodEntries.add(_buildFoodEntry(
          i,
          widget.labelPrices[i],
          "€ ${widget.prices[i]}",
          padding: EdgeInsets.only(left: 30),
        ));
      }

      return Padding(
        padding: EdgeInsets.only(left: 30),
        child: ExpansionTile(
          title: Text(
            widget.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              letterSpacing: 1,
            ),
          ),
          children: _foodEntries,
        ),
      );
    }
  }

  Widget _buildFoodEntry(int i, title, subtitle,
      {padding = const EdgeInsets.all(0.0)}) {
    return Padding(
      padding: padding,
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height / 40,
            letterSpacing: 1,
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            letterSpacing: 1,
            color: Colors.grey.shade400,
          ),
        ),
        trailing: Wrap(
          children: <Widget>[
            _itemCount[i] != 0
                ? FloatingActionButton(
                    onPressed: () =>
                        setState(() => _itemCount[i] = _itemCount[i] - 1),
                    backgroundColor: Colors.transparent,
                    mini: true,
                    child: Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                  )
                : SizedBox(width: 48),
            Container(
              padding: EdgeInsets.only(top: 15),
              child: Text(
                _itemCount[i].toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            FloatingActionButton(
              onPressed: () =>
                  setState(() => _itemCount[i] = _itemCount[i] + 1),
              backgroundColor: Colors.transparent,
              mini: true,
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}