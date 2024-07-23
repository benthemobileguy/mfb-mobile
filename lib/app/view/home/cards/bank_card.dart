import 'package:flutter/material.dart';

class BankCard extends StatelessWidget {
  final String bankCardBgAsset;
  final String balance;
  final String bankCardNumber;
  const BankCard({
    super.key,
    required this.bankCardBgAsset,
    required this.balance,
    required this.bankCardNumber,
  });
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          image: DecorationImage(
            image: AssetImage(bankCardBgAsset),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/visa.png',
              height: 22,
            ),
            const SizedBox(height: 60),
            const Text(
              'Total balance',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$$balance',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  '***** $bankCardNumber',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
