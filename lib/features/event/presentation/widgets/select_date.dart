// import 'package:flutter/material.dart';

// class SelectDateWiget extends StatefulWidget {
//   const SelectDateWiget({super.key});

//   @override
//   State<SelectDateWiget> createState() => _SelectDateWigetState();
// }

// class _SelectDateWigetState extends State<SelectDateWiget> {
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () async {
//         final selectedDate = await showDatePicker(
//           context: context,
//           initialDate: DateTime.now(),
//           firstDate: DateTime.now(),
//           lastDate: DateTime(2100),
//         );

//         if (selectedDate != null) {
//           setState(() {
//             _selectedDate = selectedDate;
//           });
//         }
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(
//           horizontal: 12,
//           vertical: 14,
//         ),
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.grey),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Row(
//           children: [
//             const Icon(Icons.calendar_today, size: 18),
//             const SizedBox(width: 8),
//             Text(
//               _selectedDate == null
//                   ? 'Select Date'
//                   : '${_selectedDate!.day}/'
//                       '${_selectedDate!.month}/'
//                       '${_selectedDate!.year}',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
