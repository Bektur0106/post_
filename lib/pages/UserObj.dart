class UserObj{
  bool isAuthSuccessful;
  int? OtdelenieId;
  int? ItemId;
  String? LastName;
  String? Name;
  String? PatronomycName;
  String? ErrorMessages;


  UserObj({required this.isAuthSuccessful, this.OtdelenieId,this.ItemId, this.LastName,  this.Name, this.PatronomycName,this.ErrorMessages});

  factory UserObj.fromJson(Map<String, dynamic> json) {
    return UserObj(
        OtdelenieId: json['OtdelenieId'],
        ItemId: json['ItemId'] ,
        LastName: json['LastName'],
        Name: json['Name'],
        PatronomycName: json['PatronomycName'],
        isAuthSuccessful:json['isAuthSuccessful'],
        ErrorMessages: json['ErrorMessages']
    );
  }

//Future<Davlenie> fromJson(decode) {}
}