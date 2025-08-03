import 'package:flutter/material.dart';
import 'package:flutter_taqwa_app/app/controllers/rosary_controller.dart';
import 'package:flutter_taqwa_app/app/widgets/app_bar_widgets.dart';
import 'package:flutter_taqwa_app/core/utils/app_colors.dart';
import 'package:provider/provider.dart';

class RosaryView extends StatelessWidget {
  const RosaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RosaryViewModel>(
      create: (_) => RosaryViewModel(),
      child: Consumer<RosaryViewModel>(
        builder: (context, controller, _) {
          return GestureDetector(
            onTap: () {
              if (controller.isLongPressedMode) {
                controller.setLongPressedMode(false);
              }
            },
            child: Scaffold(
              appBar: AppBarWidgets(showBackButton: false),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: SafeArea(
                child: Column(
                  children: [
                    Expanded(flex: 4, child: _DhikrListView()),
                    const SizedBox(height: 16),
                    Expanded(flex: 7, child: _DhikrCountDisplay()),
                    const SizedBox(height: 24),
                    Expanded(flex: 3, child: _CountUpButton()),
                    const SizedBox(height: 24),
                    Expanded(flex: 2, child: _ResetButton()),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DhikrListView extends StatelessWidget {
  const _DhikrListView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<RosaryViewModel>(context);
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: controller.dhikrList.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.add, color: Colors.black),
                onPressed: () => _showAddDhikrDialog(context, controller),
              ),
            ),
          );
        }
        final dhikr = controller.dhikrList[index - 1];
        final isSelected = controller.selectedDhikr == dhikr;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: _DhikrChip(
            text: dhikr,
            isSelected: isSelected,
            isLongPressedMode: controller.isLongPressedMode,
            onLongPress: () => controller.setLongPressedMode(true),
            onPressed: () {
              controller.selectDhikr(dhikr);
              controller.setLongPressedMode(false);
            },
            onRemove: () => controller.removeDhikrFromList(dhikr),
          ),
        );
      },
    );
  }

  void _showAddDhikrDialog(BuildContext context, RosaryViewModel controller) {
    final TextEditingController textController = TextEditingController();
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Text(
              'Yeni Zikir Ekle',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            content: TextField(
              controller: textController,
              decoration: InputDecoration(
                hintStyle: Theme.of(context).textTheme.bodyMedium,
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                hintText: 'Zikir İsmi',
              ),
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(backgroundColor: AppColors.redColor),
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Kapat',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: AppColors.whiteColor),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(backgroundColor: AppColors.greenColor),
                onPressed: () {
                  if (textController.text.trim().isNotEmpty) {
                    controller.addDhikrToList(textController.text.trim());
                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                  'Ekle',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: AppColors.whiteColor),
                ),
              ),
            ],
          ),
    );
  }
}

class _DhikrChip extends StatelessWidget {
  final String text;
  final bool isSelected;
  final bool isLongPressedMode;
  final VoidCallback onLongPress;
  final VoidCallback onPressed;
  final VoidCallback onRemove;

  const _DhikrChip({
    required this.text,
    required this.isSelected,
    required this.isLongPressedMode,
    required this.onLongPress,
    required this.onPressed,
    required this.onRemove,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      onTap: onPressed,
      child: Chip(
        side: BorderSide.none,
        avatar: isSelected ? const Icon(Icons.check, color: Colors.white) : null,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16) * 2),
        label: Text(
          text,
          style: TextStyle(
            color: isSelected ? AppColors.whiteColor : AppColors.blackColor,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        backgroundColor: isSelected ? AppColors.greenColor : Colors.grey[300],
        deleteIcon: isLongPressedMode ? const Icon(Icons.delete) : null,
        onDeleted: isLongPressedMode ? onRemove : null,
      ),
    );
  }
}

class _DhikrCountDisplay extends StatelessWidget {
  const _DhikrCountDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<RosaryViewModel>(context);
    if (controller.selectedDhikr.isEmpty) {
      return const Center(child: Text('Please select a dhikr', style: TextStyle(color: Colors.grey, fontSize: 16)));
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text('${controller.rosaryCount}', style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold))],
    );
  }
}

class _CountUpButton extends StatelessWidget {
  const _CountUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<RosaryViewModel>(context, listen: false);
    return GestureDetector(
      onTap: controller.incrementRosaryCount,
      child: Container(decoration: BoxDecoration(color: AppColors.greenColor, shape: BoxShape.circle)),
    );
  }
}

class _ResetButton extends StatelessWidget {
  const _ResetButton({super.key});

  Future<bool?> _showResetConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder:
          (_) => AlertDialog(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text(
              'Sayacı Sıfırla',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            content: Text(
              'Sayacı Sıfırlamak istediğinizden emin misiniz?',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(backgroundColor: AppColors.redColor),
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  'Çıkış',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: AppColors.whiteColor),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(backgroundColor: AppColors.greenColor),
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(
                  'Sıfırla',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: AppColors.whiteColor),
                ),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<RosaryViewModel>(context);
    return Center(
      child: ElevatedButton(
        onPressed:
            controller.rosaryCount > 0
                ? () async {
                  final shouldReset = await _showResetConfirmationDialog(context);
                  if (shouldReset == true) {
                    controller.resetRosaryCount();
                  }
                }
                : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: controller.rosaryCount > 0 ? AppColors.redColor : Colors.grey,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text('Sıfırla', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
