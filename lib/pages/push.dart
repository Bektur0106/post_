import 'dart:core';


class Data{
  String? familiya;
  String? name;
  String? otchestvo;
  String seriya;
  String inn;

  Data({required this.familiya, required this.name, required this.otchestvo, required this.seriya, required this.inn});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
        familiya: json['familiya'],
        name: json['name'],
        otchestvo: json['otchestvo'],
        seriya: json['seriya'],
        inn:json['inn'],
    );
  }
//Future<Davlenie> fromJson(decode) {}
}