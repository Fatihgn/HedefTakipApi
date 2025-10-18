import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hedef_takip_app/core/app/enums/goal_type_enums.dart';
import 'package:hedef_takip_app/core/app/theme/app_colors.dart';
import 'package:hedef_takip_app/core/models/goal_model.dart';
import 'package:hedef_takip_app/features/home/states/home_view_state.dart';
import 'package:hedef_takip_app/features/home/widgets/goal_type_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with HomeViewState {
  // Single project date state
  DateTime? _projectDate;

  String _fmtDate(DateTime? d) {
    if (d == null) return 'Select date';
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '${d.year}-$m-$day';
  }
  Future<void> _createGoal(GoalType goalType) async {
    // Form validasyonu
    if (nameCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen hedef adını girin')),
      );
      return;
    }
    
    if (descCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen açıklama girin')),
      );
      return;
    }
    
    if (goalType == GoalType.project && targetCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen hedef değerini girin')),
      );
      return;
    }
    
    if (goalType == GoalType.project && _projectDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen tarih seçin')),
      );
      return;
    }

    try {
      print('🚀 Hedef oluşturma işlemi başlıyor...');
      print('📝 Form verileri:');
      print('   - Ad: ${nameCtrl.text.trim()}');
      print('   - Açıklama: ${descCtrl.text.trim()}');
      print('   - Tip: $goalType');
      print('   - Hedef değeri: ${targetCtrl.text}');
      print('   - Tarih: $_projectDate');
      
      // Firebase bağlantısını test et
      print('🔍 Firebase bağlantısı test ediliyor...');
  
      
      final goal = GoalModel(
        id: firebaseServices.generateId(),
        name: nameCtrl.text.trim(),
        description: descCtrl.text.trim(),
        targetValue: goalType == GoalType.project ? int.tryParse(targetCtrl.text) : null,
        deadline: goalType == GoalType.project ? _projectDate : null,
        goalType: goalType,
      );
      
      print('📦 GoalModel oluşturuldu: ${goal.toJson()}');
      try {
        await firebaseServices.addGoal(goal);
        print('✅ Firebase kayıt işlemi tamamlandı!');
      } catch (e) {
        print('❌ Firebase kayıt hatası: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hata: $e')),
        );
      }
      
      
      
      print('✅ Firebase kayıt işlemi tamamlandı!');
      
      // Başarılı kayıt sonrası formu temizle
      nameCtrl.clear();
      descCtrl.clear();
      targetCtrl.clear();
      setState(() {
        _projectDate = null;
        selectedType = GoalType.habit;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Hedef başarıyla oluşturuldu!')),
      );
      
    } catch (e) {
      print('❌ Hedef oluşturma hatası: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hata: $e')),
      );
    }
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _projectDate ?? now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      helpText: 'Select date',
    );
    if (picked == null) return;
    setState(() => _projectDate = picked);
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
          ? Icon(prefixIcon, color: Colors.deepPurpleAccent)
          : null,
      suffixIcon: suffix,
      filled: true,
      fillColor: bg,
      enabledBorder: border,
      focusedBorder: border.copyWith(
        borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 1.2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Center(
                child: Text(
                  'New Goal ✨',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Goal Name
              Text(
                'Goal Name',
                style: TextStyle(color: AppColors.textColor.withOpacity(0.8)),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: nameCtrl,
                style: TextStyle(color: AppColors.textColor),
                decoration: _inputDecoration(
                  hint: 'e.g., Run a 5k Marathon',
                  prefixIcon: Icons.flag_rounded,
                ),
              ),

              const SizedBox(height: 20),

              // Description
              Text(
                'Description',
                style: TextStyle(color: AppColors.textColor.withOpacity(0.8)),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: descCtrl,
                maxLines: 4,
                style: TextStyle(color: AppColors.textColor),
                decoration: _inputDecoration(
                  hint: 'A short description of your goal.',
                ).copyWith(contentPadding: const EdgeInsets.all(16)),
              ),
              const SizedBox(height: 24),
              // Goal Type
              Text(
                'Goal Type',
                style: TextStyle(color: AppColors.textColor.withOpacity(0.8)),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: GoalTypeCard(
                      label: 'Habit',
                      icon: Icons.autorenew_rounded,
                      selected: selectedType == GoalType.habit,
                      onTap: () =>
                          setState(() => selectedType = GoalType.habit),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GoalTypeCard(
                      label: 'Project',
                      icon: Icons.rocket_launch_rounded,
                      selected: selectedType == GoalType.project,
                      onTap: () =>
                          setState(() => selectedType = GoalType.project),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              if (selectedType == GoalType.project) ...[
                Text(
                  'Target Value',
                  style: TextStyle(color: AppColors.textColor.withOpacity(0.8)),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: targetCtrl,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: AppColors.textColor),
                  decoration: _inputDecoration(
                    hint: '12',
                    prefixIcon: Icons.onetwothree_rounded,
                  ),
                ),
              ],

              const SizedBox(height: 24),

              // Show single date picker only when Project is selected
              if (selectedType == GoalType.project) ...[
                Text(
                  'Date',
                  style: TextStyle(color: AppColors.textColor.withOpacity(0.8)),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: _pickDate,
                  child: InputDecorator(
                    decoration: _inputDecoration(
                      hint: 'Select date',
                      prefixIcon: Icons.event_rounded,
                      suffix: const Icon(
                        Icons.calendar_today_rounded,
                        color: Colors.white70,
                        size: 20,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 2.0,
                        horizontal: 2.0,
                      ),
                      child: Text(
                        _fmtDate(_projectDate),
                        style: TextStyle(color: AppColors.textColor),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
              if (selectedType == GoalType.project) ...[SizedBox(height: 8)],

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
                    onPressed: () async {
                      await _createGoal(selectedType);
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
