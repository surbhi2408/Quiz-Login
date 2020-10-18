// import 'dart:io';
//
// import 'package:demo_app/services/auth.dart';
// import 'package:flutter/material.dart';
//
// class ImagesInput extends StatefulWidget {
//
//   String fileName;
//
//   @override
//   _ImagesInputState createState() => _ImagesInputState(fileName);
// }
//
// class _ImagesInputState extends State<ImagesInput> {
//
//   String fileName;
//   _ImagesInputState(fileName);
//   File _imageFile;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Align(
//           alignment: Alignment.topCenter,
//           child: CircleAvatar(
//             radius: 50.0,
//             backgroundColor: Colors.blueAccent,
//             child: ClipOval(
//               child: SizedBox(
//                 width: 100,
//                 height: 100,
//                 child: (_imageFile == null)
//                     ? NetworkImage(
//                     imageUrl,
//                 )
//                     : Image.file(_imageFile, fit: BoxFit.fill),
//               ),
//             ),
//           ),
//         ),
//         Align(
//           alignment: Alignment.topCenter,
//           child: FlatButton.icon(
//             onPressed: (){
//               //_openImagePicker(context);
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
