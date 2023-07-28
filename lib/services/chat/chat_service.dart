import 'package:chat_app_fire_base/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  // get instance of auth and firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //send message
  Future<void> sendMessage(
    String receiverId,
    String message,
  ) async {
    // get current user info
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timeStamp = Timestamp.now();

    //create new message
    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      recieverId: receiverId,
      message: message,
      timestamp: timeStamp,
    );

    //construct chat room id from current user id and receiver id (stored to ensure uniquness)
    List<String> ids = [
      currentUserId,
      receiverId,
    ];
    ids.sort(); // sort ids to make ensure that chat room ids is always the same for any two people
    String chatRoomId = ids.join(
        "_"); // combine the ids into a single string to use as a chatroomID

    //add new message to database
    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  //get message
  Stream<QuerySnapshot> getMessages(
    String userId,
    String otherUserId,
  ) {
    // construct chat room ids (sorted to ensure it matches the id used when sending messages
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection("messages")
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
