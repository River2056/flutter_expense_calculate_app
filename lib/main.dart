import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'Expense.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ExpenseApp());
  }
}

class ExpenseApp extends StatefulWidget {
  @override
  ExpenseAppState createState() => ExpenseAppState();
}

typedef void RemoveExpense(Widget expense);

class ExpenseAppState extends State<ExpenseApp> {
  int totalExp = 0;
  List<Widget> expenseList;

  final expenseDescription = TextEditingController();
  final amount = TextEditingController();

  @override
  void initState() {
    super.initState();
    expenseList = [
      Expense(
        expDesc: 'rent: 6500',
        amount: 6500,
        changeExp: chageTotalExp,
        removeExpense: removeExp,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expense Tracker',
        ),
      ),
      backgroundColor: Colors.blueGrey,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // exp card
              Card(
                child: ListTile(
                  leading: Text('Expenses: '),
                  title: Text(totalExp.toString()),
                  trailing: FlatButton(
                    onPressed: () {},
                    child: Icon(Icons.check_box),
                  ),
                ),
              ),

              // list of expenses
              Column(
                children: expenseList,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // adds a new expense
          addNewExpense(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void chageTotalExp(int value) => setState(() => this.totalExp += value);

  void addExpenseToList() {
    String expDesc = expenseDescription.text;
    int amt = int.parse(amount.text);
    setState(() {
      expenseList.add(Expense(
        expDesc: expDesc,
        amount: amt,
        changeExp: chageTotalExp,
        removeExpense: removeExp,
      ));
    });
    expenseDescription.clear();
    amount.clear();
  }

  void addNewExpense(BuildContext ctx) {
    Alert(
      context: context,
      title: "Add New Expense...",
      content: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.assignment),
              labelText: 'Exp desc',
            ),
            controller: expenseDescription,
          ),
          TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.local_atm),
              labelText: 'Amount',
            ),
            controller: amount,
          ),
        ],
      ),
      buttons: [
        DialogButton(
          onPressed: () {
            addExpenseToList();
            Navigator.pop(context);
          },
          child: Text(
            "SUBMIT",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        )
      ],
      closeFunction: () {},
    ).show();
  }

  void removeExp(Widget exp) {
    setState(() => expenseList.remove(exp));
  }
}
