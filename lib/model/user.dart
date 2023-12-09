import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String? username;
  final String? email;
  final String? phoneNumber;
  final String? photoURL;
  final bool? isLoggedIn;

  const User({
    required this.id,
    this.username,
    this.email,
    this.phoneNumber,
    this.photoURL,
    this.isLoggedIn,
  });

  static const empty = User(id: '', isLoggedIn: false);

  bool get isEmpty => this == User.empty;

  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props =>
      [id, username, email, phoneNumber, photoURL, isLoggedIn];

  User copyWith({
    String? id,
    String? username,
    String? email,
    String? phoneNumber,
    String? photoURL,
    bool? isLoggedIn,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photoURL: photoURL ?? this.photoURL,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }
}
