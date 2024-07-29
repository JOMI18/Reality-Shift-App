// import 'package:flutter/material.dart';
// import 'package:reality_shift/imports.dart';

// class CustomFolderWidget extends StatefulWidget {
//   final Folder folder;
//   final Function(Folder) onAddSubFolder;
//   final Function(Folder, String) onAddNote;
//   final Function(Folder) onEditFolder;

//   const CustomFolderWidget({
//     super.key,
//     required this.folder,
//     required this.onAddSubFolder,
//     required this.onAddNote,
//     required this.onEditFolder,
//   });

//   @override
//   _CustomFolderWidgetState createState() => _CustomFolderWidgetState();
// }

// class _CustomFolderWidgetState extends State<CustomFolderWidget> {
//   bool isExpanded = false;
//   late Folder folder;
//   late Function(Folder) onAddSubFolder;
//   late Function(Folder, String) onAddNote;
//   late Function(Folder) onEditFolder;

//   @override
//   void initState() {
//     super.initState();
//     folder = widget.folder;
//     onAddSubFolder = widget.onAddSubFolder;
//     onAddNote = widget.onAddNote;
//     onEditFolder = widget.onEditFolder;
//   }

//   @override
//   Widget build(BuildContext context) {
//     print(folder.route);
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(
//           height: 5.h,
//           child: ListTile(
//             title: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(folder.name),
//                 const Text(
//                     // folder[index]["number"] ??
//                     '0'),
//               ],
//             ),
//             leading: const Icon(
//               Icons.folder,
//               color: Colors.black,
//             ),
//             trailing: IconButton(
//               color: isExpanded
//                   ? const Color.fromARGB(255, 0, 162, 5)
//                   : Colors.black,
//               icon: Icon(
//                 isExpanded
//                     ? Icons.expand_more
//                     : Icons.keyboard_arrow_right_outlined,
//               ),
//               onPressed: () {
//                 setState(() {
//                   isExpanded = !isExpanded;
//                 });
//               },
//             ),
//             onTap: () {
//               // if (route == "") return;
//               //         Navigator.pushNamed(context, route);

//               // onEditFolder(folder);
//             },
//           ),
//         ),
//         if (isExpanded) ...[
//           Padding(
//             padding: const EdgeInsets.only(left: 16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 for (var subFolder in folder.subFolders)
//                   CustomFolderWidget(
//                     folder: subFolder,
//                     onAddSubFolder: onAddSubFolder,
//                     onAddNote: onAddNote,
//                     onEditFolder: onEditFolder,
//                   ),
//                 for (var note in folder.notes) ListTile(title: Text(note)),
//                 Row(
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.add),
//                       onPressed: () {
//                         onAddSubFolder(folder);
//                       },
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.note_add),
//                       onPressed: () {
//                         onAddNote(folder, "New Note");
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ],
//     );
//   }
// }
