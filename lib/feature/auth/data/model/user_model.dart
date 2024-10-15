
// class UserModel extends UserEntity {
//   const UserModel( {
//     required super.profileImage,
//     required super.id,
//     required super.firstName,
//     required super.lastName,
//     required super.username,
//     required super.email,
//     required super.phone, required super.password,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'firstName': firstName,
//       'lastName': lastName,
//       'username': username,
//       'email': email,
//       'phone': phone,
//       'profileImage': profileImage,
//     };
//   }

//   String get fullName => '$firstName $lastName';

//   getFormatedPhone(String phone) {
//     return TAppFormatter.formatePhoneNumber(phone);
//   }

//   factory UserModel.fromJson (Map<String, dynamic> json) {

//       return UserModel(

//         id: json['id'],
//         firstName: json['firstName'],
//         lastName: json['lastName'],
//         username: json['username'],
//         email: json['email'],
//         phone: json['phone'],
//         profileImage: json['profileImage'],
//         password: json['password'],
//       );

//   }

//   static emptyUser () {
//     return const UserModel(
//       id: '',
//       firstName: '',
//       lastName: '',
//       username: '',
//       email: '',
//       phone: '',
//       profileImage: '',
//       password: '',

//     );
//   }

//   //set id




// }
