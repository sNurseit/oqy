import 'package:flutter/material.dart';

class ModuleTypes extends StatefulWidget {
  final ValueChanged<int> onSelectItem;
  final int? selectedIndex;

  const ModuleTypes({Key? key, required this.onSelectItem, this.selectedIndex}) : super(key: key);

  @override
  State<ModuleTypes> createState() => _ModuleTypesState();
}

class _ModuleTypesState extends State<ModuleTypes> {
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildSelectableItem(0, 'Default module'),
            const SizedBox(width: 10),
            _buildSelectableItem(1, 'Quiz'),
            const SizedBox(width: 10),
            _buildSelectableItem(2, 'Online lesson'),
          ],
        ),
      ],
    );
  }

  void _selectItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onSelectItem(index);  
  }

  Widget _buildSelectableItem(int index, String content) {
    final theme = Theme.of(context);
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _selectItem(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        decoration: BoxDecoration(
          color: isSelected ? theme.primaryColor : Colors.transparent,
          border: Border.all(color: theme.primaryColor, width: 1.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Text(
            content,
            style: TextStyle(
              fontSize: 14,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}