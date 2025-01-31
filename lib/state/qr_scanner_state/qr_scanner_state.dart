abstract class QRScannerState {}

class QRScannerInitial extends QRScannerState {}

class QRScannerScanning extends QRScannerState {}

class QRScannerSuccess extends QRScannerState {
  final String qrCode;
  QRScannerSuccess(this.qrCode);
}

class QRScannerError extends QRScannerState {
  final String errorMessage;
  QRScannerError(this.errorMessage);
}
