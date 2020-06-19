import 'package:expense_tracker/main.dart';
import 'package:flutter/material.dart';

class Expense extends StatefulWidget {
  final String expDesc;
  final int amount;
  final Function changeExp;
  final RemoveExpense removeExpense;
  const Expense(
      {this.expDesc, this.amount, this.changeExp, this.removeExpense});

  ExpenseState createState() => ExpenseState();
}

class ExpenseState extends State<Expense> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          leading: FlatButton(
            onPressed: () => setState(() {
              this.isChecked = !this.isChecked;
              widget.changeExp(this.isChecked ? widget.amount : -widget.amount);
            }),
            child: this.isChecked
                ? Icon(Icons.check_box, color: Colors.green)
                : Icon(Icons.check_box),
          ),
          title: Text(widget.expDesc),
          trailing: FlatButton(
            onPressed: () => widget.removeExpense(widget),
            child: Icon(
              Icons.close,
              color: Colors.red,
            ),
          )),
    );
  }
}
