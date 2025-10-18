import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProgressView extends StatefulWidget {
  const ProgressView({super.key});

  @override
  State<ProgressView> createState() => _ProgressViewState();
}

class _ProgressViewState extends State<ProgressView> {
  // NEW: demo state for task completion and progress
  bool _readingDone = false;
  bool _exerciseDone = false;
  bool _mindfulnessDone = false;

  final int _readingCurrent = 30, _readingTarget = 40;
  final int _exerciseCurrent = 20, _exerciseTarget = 40;
  final int _mindCurrent = 10, _mindTarget = 40;

  // Colors
  final Color _bg = const Color(0xFF0E1621);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.menu, color: Colors.white),
                  ),
                  const Spacer(),
                  const Text(
                    'Progress',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                "Today's Progress",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  height: 1.15,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 16),

              // Task cards
              _TaskCard(
                color: const Color(0xFFFC8EAC),
                icon: Icons.menu_book_rounded,
                title: 'Reading',
                subtitle: 'Read for 30 minutes',
                value: _readingDone,
                onChanged: (v) => setState(() => _readingDone = v ?? false),
              ),
              const SizedBox(height: 12),
              _TaskCard(
                color: const Color(0xFFFFD166),
                icon: Icons.directions_run_rounded,
                title: 'Exercise',
                subtitle: 'Run 5 kilometers',
                value: _exerciseDone,
                onChanged: (v) => setState(() => _exerciseDone = v ?? false),
              ),
              const SizedBox(height: 12),
              _TaskCard(
                color: const Color(0xFF6EA8FE),
                icon: Icons.self_improvement_rounded,
                title: 'Mindfulness',
                subtitle: 'Meditate for 15 minutes',
                value: _mindfulnessDone,
                onChanged: (v) => setState(() => _mindfulnessDone = v ?? false),
              ),

              const SizedBox(height: 28),
              const Text(
                'Overall Progress',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 20),

              _ProgressRow(
                label: 'Reading',
                current: _readingCurrent,
                target: _readingTarget,
                color: const Color(0xFFFF5A6E),
              ),
              const SizedBox(height: 16),
              _ProgressRow(
                label: 'Exercise',
                current: _exerciseCurrent,
                target: _exerciseTarget,
                color: const Color(0xFFFFC107),
              ),
              const SizedBox(height: 16),
              _ProgressRow(
                label: 'Mindfulness',
                current: _mindCurrent,
                target: _mindTarget,
                color: const Color(0xFF5AA2FF),
              ),

              const SizedBox(height: 28),
              const Text(
                'Streaks',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 16),

              Row(
                children: const [
                  Expanded(
                    child: _StreakCard(
                      emoji: '🔥',
                      days: 3,
                      label: 'Reading',
                      color: Color(0xFF2A1A1A),
                      accent: Color(0xFFFF5A6E),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _StreakCard(
                      emoji: '🚀',
                      days: 5,
                      label: 'Exercise',
                      color: Color(0xFF2A241A),
                      accent: Color(0xFFFFC107),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Helpers

class _TaskCard extends StatelessWidget {
  const _TaskCard({
    required this.color,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final Color color;
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF121C26),
        borderRadius: BorderRadius.circular(22),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: color.withOpacity(.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF8EA0B4),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: color,
            side: const BorderSide(color: Color(0xFF2F3C4A), width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressRow extends StatelessWidget {
  const _ProgressRow({
    required this.label,
    required this.current,
    required this.target,
    required this.color,
  });

  final String label;
  final int current;
  final int target;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final double value = (target == 0) ? 0 : current / target;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            const Spacer(),
            Text(
              '$current/$target days',
              style: const TextStyle(color: Color(0xFF8EA0B4), fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: value.clamp(0, 1),
            minHeight: 10,
            backgroundColor: const Color(0xFF273242),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}

class _StreakCard extends StatelessWidget {
  const _StreakCard({
    required this.emoji,
    required this.days,
    required this.label,
    required this.color,
    required this.accent,
  });

  final String emoji;
  final int days;
  final String label;
  final Color color;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: accent.withOpacity(.25), width: 1),
        gradient: LinearGradient(
          colors: [color, const Color(0xFF121C26)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Text(emoji, style: const TextStyle(fontSize: 28)),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.white),
                children: [
                  TextSpan(
                    text: '$days day streak\n',
                    style: TextStyle(
                      color: accent,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  TextSpan(
                    text: label,
                    style: const TextStyle(
                      color: Color(0xFF8EA0B4),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
