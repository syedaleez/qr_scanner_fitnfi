// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// /// Define the state for the QR Scanner
// class QrScannerState {
//   final String qrCode; // Holds the scanned QR code result
//   final bool isScanning; // Tracks if the scanner is active

//   const QrScannerState({this.qrCode = "", this.isScanning = false});
// }

// class QrScannerCubit extends Cubit<QrScannerState> {
//   QrScannerCubit() : super(const QrScannerState());

//   /// Function to scan the QR code
//   Future<void> scanQrCode() async {
//     try {
//       // Emit the scanning state
//       emit(const QrScannerState(isScanning: true));

//       // Call the QR scanner
//       String scannedCode = await FlutterBarcodeScanner.scanBarcode(
//         "#ff6666", // Scanner overlay color (red)
//         "Cancel",  // Cancel button text
//         true,      // Show flashlight option
//         ScanMode.QR, // Specifically for QR scanning
//       );

//       if (scannedCode == "-1") {
//         // User canceled the scan
//         emit(const QrScannerState(qrCode: "", isScanning: false));
//       } else {
//         // Successfully scanned
//         emit(QrScannerState(qrCode: scannedCode, isScanning: false));
//       }
//     } catch (e) {
//       // Handle errors
//       emit(const QrScannerState(qrCode: "Error scanning QR code", isScanning: false));
//     }
//   }
// }
//mobile scanner pkgg


import 'package:flutter_bloc/flutter_bloc.dart';

import '../../state/qr_scanner_state/qr_scanner_state.dart';

class QRScannerCubit extends Cubit<QRScannerState> {
  QRScannerCubit() : super(QRScannerInitial());

  void startScanning() {
    emit(QRScannerScanning());
  }

  void onQRCodeScanned(String qrCode) {
    if (qrCode.isNotEmpty) {
      emit(QRScannerSuccess(qrCode));
    } else {
      emit(QRScannerError('Invalid QR Code'));
    }
  }
}
