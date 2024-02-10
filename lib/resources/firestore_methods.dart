import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:instagram_clone/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  String res = "Some error occured";

  // upload post to firestore

  Future<String> uploadPost(String caption, Uint8List file, String uid,
      String username, String profImage) async {
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);

      String postId = Uuid().v1();

      Post post = Post(
        captions: caption,
        uid: uid,
        username: username,
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profImage: profImage,
        likes: [],
      );

      _firebaseFirestore.collection('posts').doc(postId).set(post.toJson());
      res = "success";

      // return res;
    } catch (e) {
      res = e.toString();
      // throw e.toString();
    }
    print(res);
    return res;
  }
}
