import 'package:flutter/material.dart';
import 'package:rhymer/ui/widgets/widgets.dart';

class SearchRhimerBottomSheet extends StatelessWidget {
  const SearchRhimerBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BaseBottomSheet(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          color: theme.hintColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12)),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: 'Слово для поиска......',
                            hintStyle: TextStyle(
                              color: theme.hintColor.withOpacity(0.4),
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 12),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide.none),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none)),
                      ))),
              const SizedBox(
                width: 8,
              ),
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: BorderRadius.circular(12)),
                child: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const Divider(
          height: 1,
        ),
        Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) => ListTile(
                      title: const Text('Автокомпл....'),
                      onTap: () {},
                    ),
                separatorBuilder: (context, _) => const Divider(
                      height: 1,
                    ),
                itemCount: 15))
      ],
    ));
  }
}
