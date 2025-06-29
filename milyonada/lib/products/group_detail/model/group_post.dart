// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GroupPost {
  final String postId;
  final String content;
  final String timestamp;
  final String authorId;

  GroupPost({
    required this.postId,
    required this.content,
    required this.timestamp,
    required this.authorId,
  });

  GroupPost copyWith({
    String? postId,
    String? content,
    String? timestamp,
    String? authorId,
  }) {
    return GroupPost(
      postId: postId ?? this.postId,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      authorId: authorId ?? this.authorId,
    );
  }

  Map<String, dynamic> toMap() 
    => <String, dynamic>{
      'postId': postId,
      'content': content,
      'timestamp': timestamp,
      'authorId': authorId,
    };
  

  factory GroupPost.fromjSON(Map<String, dynamic> map) 
    => GroupPost(
      postId: map['postId'] as String,
      content: map['content'] as String,
      timestamp: map['timestamp'] as String,
      authorId: map['authorId'] as String,
    );
  
}
