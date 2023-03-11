import 'package:flutter/material.dart';

import '../const/const.dart';
import '../model/item_select.dart';

void showSelectItemDialog<T>({
  required BuildContext context,
  String? title,
  required List<ItemSelect<T>> items,
  required Function(ItemSelect<T>) onConfirm,
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.3),
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    pageBuilder: (_, __, ___) {
      return Container(
        alignment: Alignment.center,
        child: Material(
          color: Colors.transparent,
          child: _Dialog(
            title: title,
            items: items,
            onConfirm: onConfirm,
          ),
        ),
      );
    },
  );
}

class _Dialog<T> extends StatefulWidget {
  final String? title;
  final List<ItemSelect<T>> items;
  final Function(ItemSelect<T>) onConfirm;

  const _Dialog({
    super.key,
    this.title,
    required this.items,
    required this.onConfirm,
  });

  @override
  State<_Dialog> createState() => _DialogState<T>();
}

class _DialogState<T> extends State<_Dialog<T>> {
  ItemSelect<T>? selected;

  @override
  void dispose() {
    print('confirm dialog dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.title ?? 'Title...',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 8),
          ListView.separated(
            itemBuilder: (context, index) {
              final item = widget.items[index];
              return GestureDetector(
                  onTap: () {
                    selected = item;
                  },
                  child: Text(item.name));
            },
            separatorBuilder: (_, __) => const Divider(),
            itemCount: widget.items.length,
            shrinkWrap: true,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Huỷ'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (selected != null) {
                    widget.onConfirm(selected!);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Đồng ý'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
