import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hedef_takip_app/core/models/goal_model.dart';
import 'package:uuid/uuid.dart';

class FirebaseServices {
  
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Uuid uuid = Uuid();
  String generateId() {
    return uuid.v4();
  }
  
  // Firebase bağlantısını test et
  Future<bool> testConnection() async {
    try {
      print('🔍 Firebase bağlantısı test ediliyor...');
      print('📡 Firestore instance: $_firestore');
      print('🏗️ Firebase app: ${_firestore.app.name}');
      
      // Önce Firestore'un hazır olup olmadığını kontrol et
      print('⏳ Firestore hazır mı kontrol ediliyor...');
      await _firestore.enableNetwork();
      print('✅ Firestore ağ bağlantısı aktif');
      
      // Basit bir test dokümanı oluştur
      print('📝 Test dokümanı oluşturuluyor...');
      await _firestore.collection('test').doc('connection').set({
        'timestamp': FieldValue.serverTimestamp(),
        'test': true,
        'message': 'Firebase bağlantı testi',
      });
      
      print('✅ Firebase bağlantısı başarılı!');
      print('📄 Test dokümanı oluşturuldu');
      
      // Test dokümanını oku
      print('📖 Test dokümanı okunuyor...');
      final doc = await _firestore.collection('test').doc('connection').get();
      print('📖 Test dokümanı okundu: ${doc.data()}');
      
      return true;
    } catch (e) {
      print('❌ Firebase bağlantı hatası: $e');
      print('🔍 Hata türü: ${e.runtimeType}');
      print('📝 Hata detayı: ${e.toString()}');
      
      // Özel hata mesajları
      if (e.toString().contains('permission')) {
        print('🚨 SORUN: Firestore güvenlik kuralları yazma işlemini engelliyor!');
        print('💡 ÇÖZÜM: Firebase Console > Firestore Database > Rules');
        print('💡 Kuralları şu şekilde değiştirin: allow read, write: if true;');
      } else if (e.toString().contains('network')) {
        print('🚨 SORUN: Ağ bağlantısı sorunu!');
        print('💡 ÇÖZÜM: İnternet bağlantınızı kontrol edin');
      } else if (e.toString().contains('not-found')) {
        print('🚨 SORUN: Firestore Database oluşturulmamış!');
        print('💡 ÇÖZÜM: Firebase Console > Firestore Database > Create database');
      }
      
      return false;
    }
  }

  Future<void> addGoal(GoalModel goal) async {
    try {
      print('🔥 Firebase kayıt işlemi başlıyor...');
      print('📝 Hedef verisi: ${goal.toJson()}');
      
      // Önce basit bir test yap
      print('🧪 Basit test dokümanı oluşturuluyor...');
    //  await _firestore.collection('test').doc('simple');
      print('✅ Basit test başarılı!');
      
      // Şimdi asıl hedefi kaydet
      print('📝 Hedef kaydediliyor...');
      final docRef = await _firestore.collection('goals').add({
        ...goal.toJson(), 
        'id': generateId(),
        //'createdAt': FieldValue.serverTimestamp(),
      });
      
      
      
      
    } catch (e) {
      print('❌ Firestore kayıt hatası: $e');
      print('🔍 Hata türü: ${e.runtimeType}');
      print('📝 Hata detayı: ${e.toString()}');
      
      // Hata kodunu kontrol et
      if (e.toString().contains('permission')) {
        print('🚨 Firestore güvenlik kuralları hatası!');
        print('💡 Firebase Console > Firestore Database > Rules bölümünü kontrol edin');
      }
      
      rethrow; // Hatayı üst seviyeye fırlat
    }
  }

  Future<List<GoalModel>> getGoals() async {
    final snapshot = await _firestore.collection('goals').get();
    return snapshot.docs.map((doc) => GoalModel.fromJson(doc.data())).toList();
  }

  Future<void> updateGoal(GoalModel goal) async {
    await _firestore.collection('goals').doc(goal.id).update(goal.toJson());
  }

  Future<void> deleteGoal(String id) async {
    await _firestore.collection('goals').doc(id).delete();
  }
  Future<List<GoalModel>> searchGoal  (String name) async {
    final snapshot = await _firestore.collection('goals').where('name', isEqualTo: name).get();
    return snapshot.docs.map((doc) => GoalModel.fromJson(doc.data())).toList();
  }
  Future<void> toggleGoalCompletion(String id) async {
    final doc = await _firestore.collection('goals').doc(id).get();
    final goal = GoalModel.fromJson(doc.data() ?? {});
    await _firestore.collection('goals').doc(id).update({
      'isCompleted': !goal.isCompleted,
    });
  }
}
