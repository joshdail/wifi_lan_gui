class Device {
  final String ip;
  final String mac;
  final String? hostname;
  final String? vendor;

  Device({required this.ip, required this.mac, this.hostname, this.vendor});

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      ip: json['ip'],
      mac: json['mac'],
      hostname: json['hostname'],
      vendor: json['vendor'],
    );
  }
}
