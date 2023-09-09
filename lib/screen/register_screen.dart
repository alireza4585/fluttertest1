// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertest1/data/firebase_servise/storage.dart';
// import 'package:image_picker/image_picker.dart';

// // ignore: camel_case_types
// class Register_Screen extends StatefulWidget {
//   const Register_Screen({super.key});

//   @override
//   State<Register_Screen> createState() => _Register_ScreenState();
// }

// FocusNode _focusNode1 = FocusNode();
// FocusNode _focusNode2 = FocusNode();
// final username = TextEditingController();
// final bio = TextEditingController();

// bool visibil = true;
// String? _image;

// StorageMethods _methods = StorageMethods();

// // ignore: camel_case_types
// class _Register_ScreenState extends State<Register_Screen> {
//   Future<void> uploadImage(String inputsource) async {
//     final picker = ImagePicker();
//     final XFile? pickImage = await picker.pickImage(
//       source:
//           inputsource == 'cammera' ? ImageSource.camera : ImageSource.gallery,
//     );
//     if (pickImage == null) {
//       return;
//     }
//     File imagefile = File(pickImage.path);
//     String image = await _methods.uploadImageToStorage('prfile', imagefile);
//     setState(() {
//       _image = image;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             SizedBox(width: 96.w, height: 100.h),
//             InkWell(
//               onTap: () {
//                 uploadImage('gallery');
//               },
//               child: CircleAvatar(
//                 radius: 32.r,
//                 backgroundColor: Colors.grey,
//                 child: CircleAvatar(
//                   radius: 30.r,
//                   backgroundColor: Colors.white,
//                   backgroundImage: _image != null
//                       ? NetworkImage(_image!)
//                       : const NetworkImage(
//                           'https://images.app.goo.gl/bb6pkn3CtygDP1xw9'),
//                 ),
//               ),
//             ),
//             SizedBox(height: 120.h),
//             textfild(username, _focusNode1, 'username', Icons.person),
//             SizedBox(height: 19.h),
//             textfild(bio, _focusNode2, 'bio', Icons.abc),
//             SizedBox(height: 25.h),
//             contune(username.text, bio.text,
//                 _),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget contune(String username, String bio, String image) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 15),
//       child: GestureDetector(
//         onTap: () {},
//         child: Container(
//           alignment: Alignment.center,
//           width: double.infinity,
//           height: 44.h,
//           decoration: BoxDecoration(
//             color: Colors.black,
//             borderRadius: BorderRadius.circular(10.r),
//           ),
//           child: Text(
//             'Continue',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 23.sp,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget textfild(TextEditingController controller, FocusNode focusNode,
//       String typeName, IconData iconss) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 15.w),
//       child: Container(
//         height: 44.h,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(5.r),
//         ),
//         child: TextField(
//           style: TextStyle(fontSize: 18, color: Colors.black),
//           controller: controller,
//           focusNode: focusNode,
//           decoration: InputDecoration(
//             hintText: typeName,
//             prefixIcon: Icon(
//               iconss,
//               color: focusNode.hasFocus ? Colors.black : Colors.grey[600],
//             ),
//             contentPadding:
//                 EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10.r),
//               borderSide: BorderSide(
//                 color: const Color(0xffc5c5c5),
//                 width: 2.w,
//               ),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10.r),
//               borderSide: BorderSide(
//                 width: 2.w,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
