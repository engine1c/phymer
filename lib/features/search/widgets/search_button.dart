import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({
    super.key,
    required this.onTap,
    required this.controller,
  });

  final VoidCallback onTap;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 8),
        width: double.infinity,
        decoration: BoxDecoration(
            color: theme.hintColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            const Icon(Icons.search_rounded),
            const SizedBox(
              width: 8,
            ),
            AnimatedBuilder(
                animation: controller,
                builder: (context, _) {
                  return Text(
                    controller.text.isEmpty
                        ? 'Поиск рифм......'
                        : controller.text,
                    style: TextStyle(
                        fontSize: 18,
                        color: theme.hintColor.withOpacity(0.4),
                        fontWeight: FontWeight.w700),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
