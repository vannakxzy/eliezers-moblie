// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';

// class ConnectivityObserver extends StatefulWidget {
//   final Widget child;

//   const ConnectivityObserver({Key? key, required this.child}) : super(key: key);

//   @override
//   _ConnectivityObserverState createState() => _ConnectivityObserverState();
// }

// class _ConnectivityObserverState extends State<ConnectivityObserver> {
//   late StreamSubscription<ConnectivityResult> _connectivitySubscription;
//   final Connectivity _connectivity = Connectivity();

//   @override
//   void initState() {
//     StreamSubscription<List<ConnectivityResult>> subscription = Connectivity()
//         .onConnectivityChanged
//         .listen((List<ConnectivityResult> connectivityResult) {
//       if (connectivityResult.contains(ConnectivityResult.mobile)) {
//         debugPrint("mobile");
//         // Mobile network available.
//       } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
//         debugPrint("wifi");
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text("sdflksdgdoigh"),
//               duration: Duration(seconds: 3),
//             ),
//           );
//         });
//         // Wi-fi is available.
//         // Note for Android:
//         // When both mobile and Wi-Fi are turned on system will return Wi-Fi only as active network type
//       } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
//         // Ethernet connection available.
//       } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
//         // Vpn connection active.
//         // Note for iOS and macOS:
//         // There is no separate network interface type for [vpn].
//         // It returns [other] on any device (also simulator)
//       } else if (connectivityResult.contains(ConnectivityResult.bluetooth)) {
//         // Bluetooth connection available.
//       } else if (connectivityResult.contains(ConnectivityResult.other)) {
//         // Connected to a network which is not in the above mentioned networks.
//       } else if (connectivityResult.contains(ConnectivityResult.none)) {
//         // No available network types
//         debugPrint("no connection");
//       }
//     });
//     super.initState();
//   }

//   void _connectivityChange(ConnectivityResult result) {
//     final isConnected = result != ConnectivityResult.none;

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//             isConnected ? 'Connected to Internet' : 'Lost Internet Connection'),
//         duration: const Duration(seconds: 3),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _connectivitySubscription.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return widget.child;
//   }
// }
