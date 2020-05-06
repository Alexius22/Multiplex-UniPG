// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

/*
class SnackSelector extends StatefulWidget {
  final SnackTypology snackTypology;
  final Map<String, int> initialQuantities;
  final Function onSnackChanged;

  SnackSelector({
    this.snackTypology,
    this.initialQuantities,
    this.onSnackChanged,
  });

  @override
  _State createState() => _State();
}

class _State extends State<SnackSelector> {
  Map<String, Snack> _snacks = {};

  @override
  void initState() {
    for (String _dim in widget.snackTypology.priceList.keys) {
      _snacks[_dim] = Snack(
        widget.snackTypology.label,
        _dim,
        widget.initialQuantities[_dim],
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_snacks.length == 1)
      return _buildSnackEntry('');
    else {
      List<Widget> _snackEntries = [];
      for (var dim in widget.snackTypology.priceList.keys)
        _snackEntries.add(
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 14,
            ),
            child: _buildSnackEntry(dim),
          ),
        );
      return ExpansionTile(
        title: Text(
          widget.snackTypology.label,
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

  Widget _buildSnackEntry(String dim) {
    ClipOval _buildButton(
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
                widget.onSnackChanged(_snacks[dim]);
            },
          ),
        ),
      );
    }

    return ListTile(
      title: Text(
        dim == '' ? _snacks[dim].label : _snacks[dim].dim,
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.height / 40,
          letterSpacing: 1,
        ),
      ),
      subtitle: Text(
        "€ ${widget.snackTypology.priceList[dim]}",
        style: TextStyle(
          letterSpacing: 1,
        ),
      ),
      trailing: Wrap(
        spacing: 10,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          if (_snacks[dim].quantity > 0)
            _buildButton(
              icon: Icons.remove,
              onTap: () => setState(() => _snacks[dim].quantity--),
            ),
          Text(
            "${_snacks[dim].quantity}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          _buildButton(
            icon: Icons.add,
            onTap: () => setState(() => _snacks[dim].quantity++),
          ),
        ],
      ),
    );
  }
}
*/