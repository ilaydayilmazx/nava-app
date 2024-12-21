import 'package:cloud_firestore/cloud_firestore.dart';

class PostService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Post Oluşturma
  Future<void> createPost({
    required String userId,
    required String emotion,
    required String province,
    required String music,
    required DateTime time,
  }) async {
    try {
      await _firestore.collection('posts').add({
        'userId': userId,
        'emotion': emotion,
        'province': province,
        'music': music,
        'time': Timestamp.fromDate(time),
      });
      print('Post created successfully.');
    } catch (e) {
      print('Error creating post: $e');
    }
  }

  // Kullanıcının Postlarını Getirme
  Future<List<Map<String, dynamic>>> getUserPosts(String userId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('posts')
          .where('userId', isEqualTo: userId)
          .orderBy('time', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          ...data,
          'id': doc.id,
        };
      }).toList();
    } catch (e) {
      print('Error fetching user posts: $e');
      return [];
    }
  }

  // Tüm Postları Getirme (örneğin haritada göstermek için)
  Future<List<Map<String, dynamic>>> getAllPosts() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('posts')
          .orderBy('time', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          ...data,
          'id': doc.id,
        };
      }).toList();
    } catch (e) {
      print('Error fetching all posts: $e');
      return [];
    }
  }

  // Post Silme
  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
      print('Post deleted successfully.');
    } catch (e) {
      print('Error deleting post: $e');
    }
  }
}
