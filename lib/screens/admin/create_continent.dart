import 'package:flutter/material.dart';

class CreateContinent extends StatelessWidget {
  const CreateContinent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

// import 'package:flutter/material.dart';

// class FactsInput extends StatefulWidget {
//   @override
//   _FactsInputState createState() => _FactsInputState();
// }

// class _FactsInputState extends State<FactsInput> {
//   List<Map<String, String>> facts = [];

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Text(
//           'Facts:',
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 10),
//         ListView.builder(
//           shrinkWrap: true,
//           itemCount: facts.length,
//           itemBuilder: (context, index) {
//             return Padding(
//               padding: const EdgeInsets.symmetric(vertical: 5),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextFormField(
//                       decoration: InputDecoration(
//                         labelText: 'Key',
//                         border: OutlineInputBorder(),
//                       ),
//                       onChanged: (value) {
//                         facts[index]['key'] = value;
//                       },
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   Expanded(
//                     child: TextFormField(
//                       decoration: InputDecoration(
//                         labelText: 'Value',
//                         border: OutlineInputBorder(),
//                       ),
//                       onChanged: (value) {
//                         facts[index]['value'] = value;
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//         SizedBox(height: 10),
//         ElevatedButton(
//           onPressed: () {
//             setState(() {
//               facts.add({'key': '', 'value': ''});
//             });
//           },
//           child: Text('Add Fact'),
//         ),
//       ],
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: Scaffold(
//       appBar: AppBar(
//         title: Text('Facts Input Example'),
//       ),
//       body: FactsInput(),
//     ),
//   ));
// }
