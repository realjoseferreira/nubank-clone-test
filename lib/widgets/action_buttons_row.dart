import 'package:flutter/material.dart';

class ActionButtonsRow extends StatelessWidget {
  const ActionButtonsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = [
      {'icon': Icons.qr_code, 'label': 'Área Pix'},
      {'icon': Icons.barcode, 'label': 'Pagar'},
      {'icon': Icons.savings, 'label': 'Pegar\nemprestado'},
      {'icon': Icons.phone_android, 'label': 'Recarga\nde celular'},
      {'icon': Icons.attach_money, 'label': 'Cobrar'},
      {'icon': Icons.money_off_csred_rounded, 'label': 'Depositar'},
    ];

    return SizedBox(
      height: 100,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.horizontal,
        itemCount: actions.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, index) {
          final item = actions[index];
          return Column(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.grey.shade200,
                child: Icon(item['icon'] as IconData, size: 28, color: Colors.black),
              ),
              const SizedBox(height: 4),
              Text(
                item['label'] as String,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          );
        },
      ),
    );
  }
}
