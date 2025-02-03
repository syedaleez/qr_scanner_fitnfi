
// //mobile scanner
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import '../logic/qr_code_cubit/qr_scanner_cubit.dart';
// import '../state/qr_scanner_state/qr_scanner_state.dart';



// class QRScannerPage extends StatelessWidget {
//   const QRScannerPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => QRScannerCubit(),
//       child: const QRScannerView(),
//     );
//   }
// }

// class QRScannerView extends StatefulWidget {
//   const QRScannerView({Key? key}) : super(key: key);

//   @override
//   State<QRScannerView> createState() => _QRScannerViewState();
// }

// class _QRScannerViewState extends State<QRScannerView> {
//   final MobileScannerController scannerController = MobileScannerController();
//   final ValueNotifier<bool> isTorchOn = ValueNotifier<bool>(false);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('QR Code Scanner'),
//         actions: [
//           IconButton(
//             icon: ValueListenableBuilder<bool>(
//               valueListenable: isTorchOn,
//               builder: (context, isOn, child) {
//                 return Icon(isOn ? Icons.flash_on : Icons.flash_off);
//               },
//             ),
//             onPressed: () {
//               scannerController.toggleTorch();
//               isTorchOn.value = !isTorchOn.value;
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.cameraswitch),
//             onPressed: () => scannerController.switchCamera(),
//           ),
//         ],
//       ),
//       body: BlocConsumer<QRScannerCubit, QRScannerState>(
//         listener: (context, state) {
//           if (state is QRScannerSuccess) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('QR Code: ${state.qrCode}')),
//             );
//           } else if (state is QRScannerError) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Error: ${state.errorMessage}')),
//             );
//           }
//         },
//         builder: (context, state) {
//           return MobileScanner(
//             controller: scannerController,
//             onDetect: (barcodeCapture) {
//               final barcode = barcodeCapture.barcodes.first;
//               if (barcode.rawValue != null) {
//                 final String code = barcode.rawValue!;
//                 context.read<QRScannerCubit>().onQRCodeScanned(code);
//               } else {
//                 context.read<QRScannerCubit>().onQRCodeScanned('');
//               }
//             },
//           );
//         },
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     scannerController.dispose();
//     super.dispose();
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../logic/qr_code_cubit/qr_scanner_cubit.dart';
import '../state/qr_scanner_state/qr_scanner_state.dart';

class QRScannerPage extends StatelessWidget {
  const QRScannerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QRScannerCubit(),
      child: const QRScannerView(),
    );
  }
}

class QRScannerView extends StatefulWidget {
  const QRScannerView({Key? key}) : super(key: key);

  @override
  State<QRScannerView> createState() => _QRScannerViewState();
}

class _QRScannerViewState extends State<QRScannerView> {
  final MobileScannerController scannerController = MobileScannerController();
  final ValueNotifier<bool> isTorchOn = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,  // Background set to white
      appBar: AppBar(
        backgroundColor: Color(0xFF4CAF50),  // Light green color
        title: const Text(
          'Fitnfi Scanner',  // New name for the app
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            icon: ValueListenableBuilder<bool>(
              valueListenable: isTorchOn,
              builder: (context, isOn, child) {
                return Icon(
                  isOn ? Icons.flash_on : Icons.flash_off,
                  color: Colors.white,  // Icon color set to white
                );
              },
            ),
            onPressed: () {
              scannerController.toggleTorch();
              isTorchOn.value = !isTorchOn.value;
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.cameraswitch,
              color: Colors.white,  // Icon color set to white
            ),
            onPressed: () => scannerController.switchCamera(),
          ),
        ],
      ),
      body: BlocConsumer<QRScannerCubit, QRScannerState>(
        listener: (context, state) {
          if (state is QRScannerSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('QR Code: ${state.qrCode}')),
            );
          } else if (state is QRScannerError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.errorMessage}')),
            );
          }
        },
        builder: (context, state) {
          return MobileScanner(
            controller: scannerController,
            onDetect: (barcodeCapture) {
              final barcode = barcodeCapture.barcodes.first;
              if (barcode.rawValue != null) {
                final String code = barcode.rawValue!;
                context.read<QRScannerCubit>().onQRCodeScanned(code);
              } else {
                context.read<QRScannerCubit>().onQRCodeScanned('');
              }
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    scannerController.dispose();
    super.dispose();
  }
}
