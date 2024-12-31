import "package:internet_connection_checker/internet_connection_checker.dart";

abstract class NetworkInfo{
  Future<bool> get isDeviceConnected;
}

class NetworkInfoImpl implements NetworkInfo{
  final InternetConnectionChecker _connectionChecker;

  NetworkInfoImpl(this._connectionChecker);

  @override
  Future<bool> get isDeviceConnected => _connectionChecker.hasConnection;
}