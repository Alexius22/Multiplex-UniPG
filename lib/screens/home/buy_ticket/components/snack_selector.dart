// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

// Models
import 'package:cinema_app/models/snack.dart';
import 'package:cinema_app/models/ticket_snack.dart';

class SnackSelector extends StatefulWidget {
  final Snack snackTypology;
  final Function onSnackChanged;
  final List<TicketSnack> snackSelections;

  SnackSelector({
    this.snackTypology,
    this.onSnackChanged,
  }) : snackSelections = snackTypology.priceList.keys
            .map((String size) => TicketSnack(snackTypology.name, size, 0))
            .toList();

  @override
  _State createState() => _State();
}

class _State extends State<SnackSelector> {
  List<TicketSnack> _snacksSelections;

  @override
  void initState() {
    _snacksSelections = widget.snackSelections;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_snacksSelections.length == 1)
      return _buildSnackEntry(0);
    else {
      List<Widget> _snackEntries = [];
      for (int i = 0; i < _snacksSelections.length; i++)
        _snackEntries.add(
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 14,
            ),
            child: _buildSnackEntry(i),
          ),
        );
      return ExpansionTile(
        title: Text(
          widget.snackTypology.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.of(context).size.height / 40,
            letterSpacing: 1,
          ),
        ),
        children: _snackEntries,
      );
    }
  }

  Widget _buildSnackEntry(int index) {
    ClipOval _quantityModifier(
        {IconData icon, Function onTap, double buttonDim = 26.0}) {
      return ClipOval(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            child: SizedBox(
              width: buttonDim + 5,
              height: buttonDim + 5,
              child: Icon(
                icon,
                size: buttonDim,
                color: Theme.of(context).textTheme.title.color.withOpacity(0.6),
              ),
            ),
            onTap: () {
              onTap();
              if (widget.onSnackChanged != null)
                widget.onSnackChanged(_snacksSelections[index]);
            },
          ),
        ),
      );
    }

    return ListTile(
      title: Text(
        _snacksSelections.length > 1 ? _snacksSelections[index].size : _snacksSelections[index].name,
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.height / 40,
          letterSpacing: 1,
        ),
      ),
      subtitle: Text(
        "€ ${widget.snackTypology.priceList[_snacksSelections[index].size]}",
        style: TextStyle(
          letterSpacing: 1,
        ),
      ),
      trailing: Wrap(
        spacing: 10,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          if (_snacksSelections[index].quantity > 0)
            _quantityModifier(
              icon: Icons.remove,
              onTap: () => setState(() => _snacksSelections[index].quantity--),
            ),
          Text(
            "${_snacksSelections[index].quantity}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          _quantityModifier(
            icon: Icons.add,
            onTap: () => setState(() => _snacksSelections[index].quantity++),
          ),
        ],
      ),
    );
  }
}
