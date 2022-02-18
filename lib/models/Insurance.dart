import 'dart:convert';

List<Insurance> postFromJson(String str) =>
    List<Insurance>.from(json.decode(str).map((x) => Insurance.fromMap(x)));

class Insurance {
  Insurance(
      {required this.familyID,
      required this.uRN,
      required this.insuranceCompanyCode,
      required this.schemeCode,
      required this.insurancePolicyNo,
      required this.split,
      required this.amountAllotedMainCard,
      required this.amountAllotedAddOnCard,
      required this.travelClaimAllotedMainCard,
      required this.travelClaimAllotedAddOnCard,
      required this.dateIssuance,
      required this.dateActivation,
      required this.dateExpiry});

  String? familyID;
  String? uRN;
  String? insuranceCompanyCode;
  String? schemeCode;
  String? insurancePolicyNo;
  String? split;
  String? amountAllotedMainCard;
  String? amountAllotedAddOnCard;
  String? travelClaimAllotedMainCard;
  String? travelClaimAllotedAddOnCard;
  Null? dateIssuance;
  String? dateActivation;
  String? dateExpiry;

  factory Insurance.fromMap(Map<String, dynamic> json) => Insurance(
      familyID: json['FamilyID'],
      uRN: json['URN'],
      insuranceCompanyCode: json['InsuranceCompanyCode'],
      schemeCode: json['SchemeCode'],
      insurancePolicyNo: json['InsurancePolicyNo'],
      split: json['Split'],
      amountAllotedMainCard: json['AmountAlloted_Main_Card'],
      amountAllotedAddOnCard: json['AmountAlloted_AddOnCard'],
      travelClaimAllotedMainCard: json['TravelClaimAlloted_MainCard'],
      travelClaimAllotedAddOnCard: json['TravelClaimAlloted_AddOnCard'],
      dateIssuance: json['Date_Issuance'],
      dateActivation: json['Date_Activation'],
      dateExpiry: json['Date_Expiry']);
}
