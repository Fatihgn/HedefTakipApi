import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

enum _GoalType { numerical, habit, project }

class _HomeViewState extends State<HomeView> {
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _targetCtrl = TextEditingController(text: '12');
  final _milestoneCtrl = TextEditingController();
  final List<String> _milestones = [];

  _GoalType _selectedType = _GoalType.numerical;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    _targetCtrl.dispose();
    _milestoneCtrl.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration({
    String? hint,
    IconData? prefixIcon,
    Widget? suffix,
    int radius = 18,
  }) {
    final bg = Colors.white.withOpacity(0.06);
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius.toDouble()),
      borderSide: BorderSide(color: Colors.white.withOpacity(0.12)),
    );
    return InputDecoration(
      hintText: hint,
      prefixIcon: prefixIcon != null
          ? Icon(prefixIcon, color: Colors.greenAccent.shade400)
          : null,
      suffixIcon: suffix,
      filled: true,
      fillColor: bg,
      enabledBorder: border,
      focusedBorder: border.copyWith(
        borderSide: BorderSide(color: Colors.greenAccent.shade400, width: 1.2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textColor = Colors.white;
    final subtle = Colors.white.withOpacity(0.7);

    return Scaffold(
      backgroundColor: const Color(0xFF0B1015),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.maybePop(context),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      'New Goal ✨',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: textColor,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  const SizedBox(width: 48), // balance close button space
                ],
              ),

              const SizedBox(height: 16),

              // Goal Name
              Text('Goal Name', style: TextStyle(color: subtle)),
              const SizedBox(height: 8),
              TextField(
                controller: _nameCtrl,
                style: TextStyle(color: textColor),
                decoration: _inputDecoration(
                  hint: 'e.g., Run a 5k Marathon',
                  prefixIcon: Icons.flag_rounded,
                ),
              ),

              const SizedBox(height: 20),

              // Description
              Text('Description', style: TextStyle(color: subtle)),
              const SizedBox(height: 8),
              TextField(
                controller: _descCtrl,
                maxLines: 4,
                style: TextStyle(color: textColor),
                decoration: _inputDecoration(
                  hint: 'A short description of your goal.',
                ).copyWith(contentPadding: const EdgeInsets.all(16)),
              ),

              const SizedBox(height: 24),

              // Goal Type
              Text('Goal Type', style: TextStyle(color: subtle)),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _GoalTypeCard(
                      label: 'Numerical',
                      icon: Icons.onetwothree_rounded,
                      selected: _selectedType == _GoalType.numerical,
                      onTap: () =>
                          setState(() => _selectedType = _GoalType.numerical),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _GoalTypeCard(
                      label: 'Habit',
                      icon: Icons.autorenew_rounded,
                      selected: _selectedType == _GoalType.habit,
                      onTap: () =>
                          setState(() => _selectedType = _GoalType.habit),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _GoalTypeCard(
                      label: 'Project',
                      icon: Icons.rocket_launch_rounded,
                      selected: _selectedType == _GoalType.project,
                      onTap: () =>
                          setState(() => _selectedType = _GoalType.project),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Target Value (only visually; you can later validate based on type)
              Text('Target Value', style: TextStyle(color: subtle)),
              const SizedBox(height: 8),
              TextField(
                controller: _targetCtrl,
                keyboardType: TextInputType.number,
                style: TextStyle(color: textColor),
                decoration: _inputDecoration(
                  hint: '12',
                  prefixIcon: Icons.onetwothree_rounded,
                ),
              ),

              const SizedBox(height: 24),

              // Milestones / Sub-goals
              Text('Milestones / Sub-goals', style: TextStyle(color: subtle)),
              const SizedBox(height: 8),
              TextField(
                controller: _milestoneCtrl,
                style: TextStyle(color: textColor),
                decoration: _inputDecoration(
                  hint: 'Add a milestone',
                  suffix: IconButton(
                    onPressed: () {
                      final text = _milestoneCtrl.text.trim();
                      if (text.isNotEmpty) {
                        setState(() {
                          _milestones.add(text);
                          _milestoneCtrl.clear();
                        });
                      }
                    },
                    icon: const Icon(
                      Icons.add_circle_outline,
                      color: Colors.white,
                    ),
                  ),
                ),
                onSubmitted: (_) => FocusScope.of(context).unfocus(),
              ),
              if (_milestones.isNotEmpty) ...[
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _milestones
                      .asMap()
                      .entries
                      .map(
                        (e) => Chip(
                          label: Text(e.value),
                          labelStyle: const TextStyle(color: Colors.white),
                          backgroundColor: Colors.white.withOpacity(0.08),
                          deleteIcon: const Icon(
                            Icons.close,
                            size: 18,
                            color: Colors.white70,
                          ),
                          onDeleted: () =>
                              setState(() => _milestones.removeAt(e.key)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                            side: BorderSide(
                              color: Colors.white.withOpacity(0.12),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],

              const SizedBox(height: 28),

              // Create Goal button
              SizedBox(
                height: 56,
                width: double.infinity,
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF9B5CFF), Color(0xFFFF66C4)],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(28)),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      // ...submit or navigate...
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Goal created (demo)')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: const StadiumBorder(),
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    child: const Text('Create Goal'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GoalTypeCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _GoalTypeCard({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final selectedColor = Colors.greenAccent.shade400;
    final borderColor = selected
        ? selectedColor
        : Colors.white.withOpacity(0.12);
    final bg = selected
        ? Colors.white.withOpacity(0.06)
        : Colors.white.withOpacity(0.04);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        height: 88,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: borderColor, width: selected ? 1.4 : 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: selected ? selectedColor : Colors.white70),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
