import 'package:flutter/material.dart';
import 'package:hedef_takip_app/core/app/enums/goal_type_enums.dart';
import 'package:hedef_takip_app/core/services/firebase_services.dart';
import 'package:hedef_takip_app/features/home/view/home_view.dart';

//enum GoalType { habit, project }

mixin HomeViewState on State<HomeView> {
  final FirebaseServices firebaseServices = FirebaseServices();
  final nameCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  final targetCtrl = TextEditingController(text: '12');
  final milestoneCtrl = TextEditingController();
  final List<String> milestones = [];

  GoalType selectedType = GoalType.habit;

  @override
  void dispose() {
    nameCtrl.dispose();
    descCtrl.dispose();
    targetCtrl.dispose();
    milestoneCtrl.dispose();
    super.dispose();
  }
}
