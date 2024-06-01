import 'package:flutter/material.dart';

class TransactionHistoryScreen extends StatelessWidget {
   TransactionHistoryScreen({super.key});


  List<Transaction> transactions = [
  Transaction(description: 'Coffee', date: '2024-05-30', amount: 5.50, isCredit: false),
  Transaction(description: 'Salary', date: '2024-05-28', amount: 1500.00, isCredit: true),
  Transaction(description: 'Groceries', date: '2024-05-25', amount: 45.30, isCredit: false),
  Transaction(description: 'Electricity Bill', date: '2024-05-20', amount: 60.75, isCredit: false),
  // Add more transactions here
];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction History'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: Icon(
                transaction.isCredit ? Icons.arrow_downward : Icons.arrow_upward,
                color: transaction.isCredit ? Colors.green : Colors.red,
              ),
              title: Text(transaction.description),
              subtitle: Text(transaction.date),
              trailing: Text(
                (transaction.isCredit ? '+ ' : '- ') + '\$${transaction.amount.toStringAsFixed(2)}',
                style: TextStyle(
                  color: transaction.isCredit ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class Transaction {
  final String description;
  final String date;
  final double amount;
  final bool isCredit;

  Transaction({
    required this.description,
    required this.date,
    required this.amount,
    required this.isCredit,
  });
}
