import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double balance = 0.00;
  bool isBalanceVisible = true;
  String greeting = "Olá, José";
  File? _profileImage;

  void toggleBalanceVisibility() {
    setState(() {
      isBalanceVisible = !isBalanceVisible;
    });
  }

  void editGreeting() async {
    final controller = TextEditingController(text: greeting);
    final newName = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar saudação'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Digite sua saudação'),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, null),
              child: const Text('Cancelar')),
          TextButton(
              onPressed: () => Navigator.pop(context, controller.text),
              child: const Text('Salvar')),
        ],
      ),
    );

    if (newName != null && newName.isNotEmpty) {
      setState(() {
        greeting = newName;
      });
    }
  }

  void editBalance() async {
    final controller = TextEditingController(text: balance.toString());
    final newBalance = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar saldo'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: 'Digite o novo saldo'),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, null),
              child: const Text('Cancelar')),
          TextButton(
              onPressed: () => Navigator.pop(context, controller.text),
              child: const Text('Salvar')),
        ],
      ),
    );

    if (newBalance != null && double.tryParse(newBalance) != null) {
      setState(() {
        balance = double.parse(newBalance);
      });
    }
  }

  void pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho roxo
            Container(
              color: const Color(0xFF8A05BE),
              padding: const EdgeInsets.only(left: 16, right: 16, top: 40, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: pickImage,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 20,
                          backgroundImage:
                              _profileImage != null ? FileImage(_profileImage!) : null,
                          child: _profileImage == null
                              ? const Icon(Icons.camera_alt, color: Colors.black)
                              : null,
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: editGreeting,
                        child: Text(
                          greeting,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: Icon(
                          isBalanceVisible ? Icons.visibility : Icons.visibility_off,
                          color: Colors.white,
                        ),
                        onPressed: toggleBalanceVisibility,
                      ),
                      IconButton(
                        icon: const Icon(Icons.help_outline, color: Colors.white),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.mail_outline, color: Colors.white),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Saldo e atalhos
            GestureDetector(
              onTap: editBalance,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Conta', style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 4),
                    Text(
                      isBalanceVisible ? 'R\$ ${balance.toStringAsFixed(2)}' : '•••••••',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 90,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildIcon('pix.png', 'Área Pix'),
                          _buildIcon('pagar.png', 'Pagar'),
                          _buildIcon('fgts.png', 'Pegar\nemprestado'),
                          _buildIcon('recarga.png', 'Recarga de\ncelular'),
                          _buildIcon('cobrar.png', 'Cobrar'),
                          _buildIcon('depositar.png', 'Depositar'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Benefícios Nubank+ e Meus Cartões
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/icons/beneficios.png',
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Benefícios Nubank+',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/icons/cartoes.png',
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Meus Cartões',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(String iconName, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFF1F1F1),
            ),
            child: Center(
              child: Image.asset(
                'assets/icons/$iconName',
                width: 28,
                height: 28,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
