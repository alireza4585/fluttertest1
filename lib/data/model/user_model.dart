class Usermodel {
  String email;
  String username;
  String bi;
  String profileImage;
  List followers;
  List following;

  Usermodel(this.username, this.bi, this.email, this.profileImage,
      this.followers, this.following);
}
