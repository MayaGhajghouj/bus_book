// import 'package:bus_book/shared/Appcubitt/appcubit.dart';
// import 'package:bus_book/shared/Appcubitt/appstates.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class MyConnect extends StatefulWidget {
//   @override
//   State<MyConnect> createState() => _MyConnectState();
// }

// class _MyConnectState extends State<MyConnect> {
//   // const MyConnect({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AppCubit, AppStates>(
//         listener: (BuildContext context, Object? state) {
//       print(state.toString());
//     }, builder: (BuildContext context, state) {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text(
//             state.toString(),
//             style: TextStyle(
//               fontSize: 20.0,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         body: Container(
//           color: Colors.grey,
//           child: ListView.builder(
//             itemBuilder: (context, index) {
//               return Text(
//                 AppCubit.get(context).mydata[index],
//                 style: TextStyle(
//                   fontSize: 15.0,
//                 ),
//               );
//             },
//             itemCount: AppCubit.get(context).mydata.length,
//           ),
//         ),
//         floatingActionButton: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             FloatingActionButton(
//               child: Text(
//                 'connect',
//               ),
//               onPressed: () {
//                 AppCubit.get(context).connectToDB();
//                 print(state.toString());
//               },
//             ),
//             FloatingActionButton(
//               child: Text(
//                 'disconnect',
//               ),
//               onPressed: () {
//                 AppCubit.get(context).disconnectToDB();
//                 print(state.toString());
//               },
//             ),
//             FloatingActionButton(
//               child: Text(
//                 'GEt',
//               ),
//               onPressed: () {
//                 AppCubit.get(context).getDriver();
//                 print(state.toString());
//               },
//             ),
//           ],
//         ),
//       );
//     });
//   }
// }
