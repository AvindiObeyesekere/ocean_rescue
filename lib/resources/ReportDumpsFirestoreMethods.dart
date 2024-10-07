// services/report_dumps_firestore_methods.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';
import '../models/reportdump.dart';

class ReportDumpsFirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get the current user UID
  String getCurrentUserId() {
    return _auth.currentUser!.uid;
  }

  // Method to upload image and get the download URL
  Future<String> uploadImageToStorage(String id, File imageFile) async {
    Reference ref = _storage.ref().child('report_dumps').child(id);
    UploadTask uploadTask = ref.putFile(imageFile);

    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

 Future<void> saveReportDump({
  required String title,
  required String description,
  required String eventLocation,
  required String urgencyLevel,
  required File imageFile, required bool isReported,
}) async {
  try {
    // Generate a unique ID for the dump report
    String id = const Uuid().v1();

    // Upload the image to Firebase Storage and get the download URL
    String imageUrl = await uploadImageToStorage(id, imageFile);

    // Get current user id
    String uid = getCurrentUserId();

    // Create a map from the provided parameters
    Map<String, dynamic> data = {
      'id': id,
      'uid': uid,
      'title': title,
      'description': description,
      'eventLocation': eventLocation,
      'urgencyLevel': urgencyLevel,
      'imageUrl': imageUrl,
      'timestamp': FieldValue.serverTimestamp(), // Use Firestore's server timestamp
      'isReported': true, // Set to true when initially saving
    };

    // Save the report to Firestore
    await _firestore.collection('report_dumps').doc(id).set(data);
  } catch (e) {
    print('Failed to save dump report: $e');
  }
}


  // Method to fetch all dump reports
Future<List<ReportDump>> fetchReportedDumpReports() async {
  try {
    QuerySnapshot querySnapshot = await _firestore
        .collection('report_dumps')
        .where('isReported', isEqualTo: true) // Fetch only reported dumps
        .limit(15) 
        .get();
    
    print('Reported dump reports count: ${querySnapshot.docs.length}'); // Debugging info
    
    return querySnapshot.docs
        .map((doc) => ReportDump.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  } catch (e) {
    print('Failed to fetch reported dump reports: $e');
    return [];
  }
}


Future<List<ReportDump>> fetchClearedDumpReports() async {
  try {
    QuerySnapshot querySnapshot = await _firestore
        .collection('report_dumps')
        .where('isReported', isEqualTo: false) // Fetch only cleared dumps
        .get();
    
    print('Cleared dump reports count: ${querySnapshot.docs.length}'); // Debugging info
    
    return querySnapshot.docs
        .map((doc) => ReportDump.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  } catch (e) {
    print('Failed to fetch cleared dump reports: $e');
    return [];
  }
}

}
