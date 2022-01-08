import 'dart:convert';

List<TxnDependent> postFromJson(String str) =>
    List<TxnDependent>.from(json.decode(str).map((x) => TxnDependent.fromMap(x)));

class TxnDependent {
  TxnDependent({
    required this.FamilyID,
    required this.URN,
    required this.MemberID,
    required this.MemberName,
    required this.Gender,
    required this.RelationCode,
    required this.Age,
    required this.Dob,
    required this.Enrolled,
    required this.Dead,
    required this.Is_Photo,
    required this.Personalized,
    required this.CardsPrinted,
    required this.Emp_FamID,
    required this.CardsPrintedDate,
    required this.FName,
    required this.OName,
    required this.ChipSRNo,
    required this.Status,
    required this.IsHandicap,
  });

  String FamilyID;
  String URN;
  String MemberID;
  String MemberName;
  String Gender;
  String RelationCode;
  String Age;
  String Dob;
  String Enrolled;
  String Dead;
  String Is_Photo;
  String Personalized;
  String CardsPrinted;
  String Emp_FamID;
  String CardsPrintedDate;
  String FName;
  String OName;
  String ChipSRNo;
  String Status;
  String IsHandicap;

  factory TxnDependent.fromMap(Map<String, dynamic> json) => TxnDependent(
    FamilyID: json["FamilyID"],
    URN: json["URN"],
    MemberID: json["MemberID"],
    MemberName: json["MemberName"],
    Gender: json["Gender"],
    RelationCode: json["RelationCode"],
    Age: json["Age"],
    Dob: json["Dob"],
    Enrolled: json["Enrolled"],
    Dead: json["Dead"],
    Is_Photo: json["Is_Photo"],
    Personalized: json["Personalized"],
    CardsPrinted: json["CardsPrinted"],
    Emp_FamID: json["Emp_FamID"],
    CardsPrintedDate: json["CardsPrintedDate"],
    FName: json["FName"],
    OName: json["OName"],
    ChipSRNo: json["ChipSRNo"],
    Status: json["Status"],
    IsHandicap: json["IsHandicap"],
  );
}