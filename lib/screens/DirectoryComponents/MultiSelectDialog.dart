import 'package:flutter/material.dart';

class MultiSelectItem<int> {
  const MultiSelectItem(this.value, this.label);

  final int value;
  final dynamic label;
}

class MultiSelectDialog<int> extends StatefulWidget {
  MultiSelectDialog(
      {Key key, this.title, this.initialSelectedValues, this.items})
      : super(key: key);

  final String title;
  final List<MultiSelectItem<int>> items;
  final Set<int> initialSelectedValues;

  @override
  _MultiSelectDialogState createState() => _MultiSelectDialogState<int>();
}

class _MultiSelectDialogState<int> extends State<MultiSelectDialog> {
  final Set<int> _selectedFilterValues = Set<int>();

  void initState() {
    super.initState();
    if (widget.initialSelectedValues != null &&
        widget.initialSelectedValues.isNotEmpty) {
      _selectedFilterValues
          .addAll(widget.initialSelectedValues.map((e) => e as int).toList());
    }
  }

  void _onItemCheckedChange(int itemValue, bool checked) {
    setState(() {
      if (checked) {
        _selectedFilterValues.add(itemValue);
      } else {
        _selectedFilterValues.remove(itemValue);
      }
    });
  }

  void _onClose() {
    Navigator.pop(context);
  }

  void _onSave() {
    Navigator.pop(context, _selectedFilterValues);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      contentPadding: EdgeInsets.only(top: 12.0),
      content: SingleChildScrollView(
        child: ListTileTheme(
          contentPadding: EdgeInsets.fromLTRB(15.0, 0.0, 25.0, 0.0),
          child: ListBody(
            children: widget.items.map((item) => _buildItem(item)).toList(),
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel'),
          onPressed: _onClose,
        ),
        FlatButton(
          child: Text('Save'),
          onPressed: _onSave,
        )
      ],
    );
  }

  Widget _buildItem(MultiSelectItem<int> item) {
    final checked = _selectedFilterValues.contains(item.value);
    return CheckboxListTile(
      value: checked,
      title: Text(item.label.toString()),
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (checked) => _onItemCheckedChange(item.value, checked),
    );
  }
}
