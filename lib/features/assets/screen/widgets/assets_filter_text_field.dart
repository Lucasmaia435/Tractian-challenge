import 'package:flutter/material.dart';

class AssetsFilterTextField extends StatelessWidget {
  const AssetsFilterTextField({
    super.key,
    required this.onChanged,
  });

  final void Function(String value) onChanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: "Buscar Ativo ou Local",
        prefixIcon: const Icon(
          Icons.search,
          color: Color(0xFF8E98A3),
          // size: 50,
        ),
        fillColor: const Color(0xFFEAEFF3),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
