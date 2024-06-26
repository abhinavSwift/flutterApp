import 'package:flutter/material.dart';
import 'package:passenger_app/wallet/addmoney.dart';
import 'package:passenger_app/wallet/card.dart';
import 'package:passenger_app/wallet/voucher.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildWalletBalance(),
            const SizedBox(height: 20),
            _buildSavedCardsSection(context),
            const SizedBox(height: 20),
            _buildOptionButton(
              icon: Icons.account_balance_wallet,
              text: 'Top Up Wallet',
              onTap: () {
                // Handle Top Up Wallet tap
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TopUpScreen()),
                );
              },
            ),
            const SizedBox(height: 10),
            _buildOptionButton(
              icon: Icons.card_giftcard,
              text: 'Voucher',
              onTap: () {
                // Handle Voucher tap
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const VoucherScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWalletBalance() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue[400],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '\$ 0.00',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            
          ),
          Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildSavedCardsSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Saved Cards',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const Icon(
            Icons.credit_card,
            color: Colors.purple,
            size: 50,
          ),
          const SizedBox(height: 10),
          const Text(
            'No cards found.\nPlease tap the button below to add a card.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddCardPage()),
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              child: Text(
                'ADD NEW CARD',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () => {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.purple),
            const SizedBox(width: 10),
            Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
