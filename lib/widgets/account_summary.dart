import 'package:flutter/material.dart';

class AccountSummary extends StatefulWidget {
  const AccountSummary({super.key});

  @override
  State<AccountSummary> createState() => _AccountSummaryState();
}

class _AccountSummaryState extends State<AccountSummary> {
  bool _hidden = false;
  double _balance = 0.00;

  void _toggleBalance() {
    setState(() {
      _hidden = !_hidden;
    });
  }

  void _editBalance() async {
    final controller = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Editar Saldo"),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: "Novo saldo"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _balance = double.tryParse(controller.text) ?? _balance;
              });
              Navigator.of(context).pop();
            },
            child: const Text("Salvar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text("Conta", style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: GestureDetector(
        onTap: _editBalance,
        child: Text(
          _hidden ? "••••••" : "R\$ ${_balance.toStringAsFixed(2)}",
          style: const TextStyle(fontSize: 18),
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
