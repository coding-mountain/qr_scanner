// import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

// class QRScannerWidget extends StatefulWidget {
//   @override
//   _QRScannerWidgetState createState() => _QRScannerWidgetState();
// }

// class _QRScannerWidgetState extends State<QRScannerWidget> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   QRViewController? controller;
//   Barcode? result;
//   String? qrCodeImage;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         QRView(
//           key: qrKey,
//           onQRViewCreated: _onQRViewCreated,
//         ),
//         Positioned(
//           bottom: 16.0,
//           left: 16.0,
//           right: 16.0,
//           child: Column(
//             children: [
//               Text(
//                 result != null ? 'QR Code Image:' : 'Scan a QR code',
//                 style: TextStyle(fontSize: 16.0),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 8.0),

//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   void _onQRViewCreated(QRViewController controller) {
//     this.controller = controller;
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         result = scanData;
//         qrCodeImage = scanData.rawContent;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
// }
