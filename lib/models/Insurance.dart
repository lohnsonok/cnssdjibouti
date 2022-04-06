import 'dart:convert';

List<TxnInsurance> postFromJson(String str) => List<TxnInsurance>.from(
    json.decode(str).map((x) => TxnInsurance.fromMap(x)));

class TxnInsurance {
  TxnInsurance(
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

  factory TxnInsurance.fromMap(Map<String, dynamic> json) => TxnInsurance(
      familyID: json['FamilyID'],
      uRN: json['URN'],
      insuranceCompanyCode: json['TxnInsuranceCompanyCode'],
      schemeCode: json['SchemeCode'],
      insurancePolicyNo: json['TxnInsurancePolicyNo'],
      split: json['Split'],
      amountAllotedMainCard: json['AmountAlloted_Main_Card'],
      amountAllotedAddOnCard: json['AmountAlloted_AddOnCard'],
      travelClaimAllotedMainCard: json['TravelClaimAlloted_MainCard'],
      travelClaimAllotedAddOnCard: json['TravelClaimAlloted_AddOnCard'],
      dateIssuance: json['Date_Issuance'],
      dateActivation: json['Date_Activation'],
      dateExpiry: json['Date_Expiry']);
}
