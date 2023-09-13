class PostModel {
  String postImage;
  String username;
  String profileImage;
  String caption;
  String location;
  String uid;
  String postId;
  List like;
  PostModel({
    required this.caption,
    required this.like,
    required this.location,
    required this.postId,
    required this.postImage,
    required this.profileImage,
    required this.uid,
    required this.username,
  });
}
