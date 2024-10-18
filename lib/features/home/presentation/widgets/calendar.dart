// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';
//
// class HabitCalendar extends StatefulWidget {
//   @override
//   _HabitCalendarState createState() => _HabitCalendarState();
// }
//
// class _HabitCalendarState extends State<HabitCalendar> {
//   late DateTime _selectedDay;
//   late DateTime _focusedDay;
//
//   @override
//   void initState() {
//     super.initState();
//     _selectedDay = DateTime.now();
//     _focusedDay = DateTime.now();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TableCalendar(
//           firstDay: DateTime.utc(2020, 1, 1),
//           lastDay: DateTime.utc(2030, 12, 31),
//           focusedDay: _focusedDay,
//           selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
//           onDaySelected: (selectedDay, focusedDay) {
//             setState(() {
//               _selectedDay = selectedDay;
//               _focusedDay = focusedDay;
//
//
//               fetchHabitsById(userId , selectedDay);
//             });
//           },
//           calendarStyle: const CalendarStyle(
//             // يمكنك تخصيص مظهر التقويم هنا
//             selectedDecoration: BoxDecoration(
//               color: Colors.blue,
//               shape: BoxShape.circle,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
