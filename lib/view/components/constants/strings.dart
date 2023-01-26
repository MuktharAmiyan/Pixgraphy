import 'package:flutter/foundation.dart' show immutable;

@immutable
class Strings {
  const Strings._();

  //REG EXP
  static const emailRegExp =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  //LANDING SCREEN
  static const welcomeToText = 'Welcome To';
  static const appName = "Pixgraphy";
  static const appnameSplit = "PIX\nGRAPHY";
  static const smallLandingDes = "Place where creativity meets inspiration.";
  static const detailLandingDes =
      "Welcome to Pixgraphy, a place where creativity meets inspiration. Here, photographers of all levels can come together to share their passion for capturing life's beauty. Whether you're a professional photographer or just starting out, our community is dedicated to helping you grow as an artist and create stunning imagery. Join us in exploring the world through a different lens, and discover the beauty of photography in a new way. From snapshots to masterpieces, we're here to help you bring your vision to life and share it with the world. So come and capture life's beauty and share it with the world in Pixgraphy.";
  static const join = "Join";
  static const signIn = "Sign In";
  static const signOut = "Sign Out";
  static const accountDisabled =
      "your account has been suspended. please contact customer support";

  //SIGNUP SCREEN
  static const username = "Username";
  static const name = "Name";
  static const email = "Email";
  static const password = "Password";
  static const continueWithGoogle = "Continue With Google";
  static const alreadyhaveanaccount = "Already have an account? Sign in";
  static const letsdothis = " Let's do this";
  static const postId = "postId";
  static const post = "Post";

  //LOGIN SCREEN
  static const welcomeback = "Welcome back";
  static const donthaveanaccount = "Don't have an account? Join";
  //
  static const search = "Search";
  static const editprofile = "Edit Profile";
  static const photos = "Photos";
  static const following = "Following";
  static const followers = "Followers";
  static const follow = "Follow";
  static const followedYou = "followed you";
  static const unfollow = "Unfollow";
  static const caption = "Caption";
  static const upload = "Upload";
  static const isFollowing = "isFollowing";
  static const pickImage = "Pick Image";

  static const loading = "Loading...";
  static const unsplashExplore = "Unsplash Explore";

  //ERROR TEXTS

  static const shortPassword = "Short password";
  static const cantbeEmpty = " Cannot be empty";

  // AUTH FAILURE STRINGS
  static const serverError = 'Server error';
  static const invaliedEmail = "Invalied email";
  static const cancelByUser = 'Cancel by user';
  static const wrongEmailOrPassword = 'Wrong email or password';
  static const userNotFound = 'User not found';
  static const emailAlreadyInUse = 'Email already in use';
  static const userDisabled = 'User disabled';
  static const weakPassword = 'Weak password';
  //DRAWER ITEMS
  static const profile = 'Profile';
  static const settings = 'Settings';
  static const appearance = 'Appearance';
  static const uid = 'uid';
  //THEME
  static const themeMode = 'Theme Mode';
  static const darkMode = 'Dark Mode';
  static const light = 'Light';
  static const accentColor = 'Accent color';

  static const forYou = "For You";
  static const index = "index";
  static const addPost = "Add Post";
  static const explore = "Explore";
  static const profilePic = "Profile Pic";
  static const changePhoto = "Change photo";

  //ADD POST FORM
  static const titleForYourPic = "Title for your picture";
  static const description = "Description";
  static const shotOn = "Shot On";

  static const imageErrorMsg = 'There was an error loading this photo 😪😭';

  static const noPostYet = "No Post Yet 🤨";

  //ADD IMAGE FAILRE
  static const errorThumnailmsg = "While making thumbnail pic another Image";
  static const postUploadErrorMsg =
      "Something went wrong. image cannot be uploaded. Please try again.";
  static const somethingwentwrong = "Something went wrong.Please try again.";

  static const searchUser = "Search user";
  static const searchUnPosts = "Search unsplash posts";
  static const noUserFound = "No user found";
  static const followuserstoseetheirposts = "Follow users to see their posts.";
  static const likes = "Likes";
  static const likedYourPost = "liked your post";
  static const comments = "Comments";
  static const comment = "Comment";
  static const addAComment = "Add a comment...";
  static const noComments = "No Comments";
  static const showMore = "Show more..";
  static const report = "Report";
  static const delete = "Delete";
  static const cancel = "Cancel";
  static const ok = "Ok";
  static const signingOut = "Signing Out";

  static const confirmDelete = "Confirm delete";
  static const areYouSureYouWantToDelete =
      "Are you sure you want to delete this ";
  static const areYouSureYouWantToSignOut =
      "Are you  sure you want to sign out ?";
  static const postDeleted = "Post deleted";
  static const save = "Save";

  static const reportList = [
    'Violent or repulsive content',
    'Hateful or abusive content',
    'Harmful or dangerous acts',
    'sexual content',
    'spam or misleading',
    'child abuse'
  ];
}
