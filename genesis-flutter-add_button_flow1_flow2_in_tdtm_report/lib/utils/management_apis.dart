import 'dart:convert' show json, jsonDecode, utf8;

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:management_app/models/base_model.dart';
import 'package:management_app/models/item_model.dart';
import 'package:management_app/models/otp_verify_model.dart';
import 'package:xml/xml.dart' as xml;

class ManagementApis {
  static final ManagementApis _apiHandler = ManagementApis._internal();

  factory ManagementApis() {
    return _apiHandler;
  }

  //GetVerifierReportIOS32
  //flow2

  ManagementApis._internal();

  static const String baseURL =
      "http://hac.centralindia.cloudapp.azure.com/Reportapp_dev/webservice.asmx";
  static var uri = Uri.parse(baseURL);

  var platform = const MethodChannel('flutter_to_native');

  Future<List<BaseModel>> getVerifireReport(String reportType,
      String pickUpDate, String platformType, String flowType) async {
    String bodyEnvelope = '''
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <GetVerifierReportIOS32 xmlns="http://hac.centralindia.cloudapp.azure.com/Reportapp_dev/webservice.asmx">
      <reportType>$reportType</reportType>
      <pickupDate>$pickUpDate</pickupDate>
      <flow2>$flowType</flow2>
      <etype>$platformType</etype>
    </GetVerifierReportIOS32>
  </soap:Body>
</soap:Envelope>
''';

    return callAPI(bodyEnvelope, "GetVerifierReportIOS32Response",
        "GetVerifierReportIOS32Result");
  }

  Future<List<BaseModel>> getInboundReport(
      String currentMonth, String currentTimeslot, String platformType) async {
    String bodyEnvelope = '''
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <GET_INBOUND_CALL_FLOW xmlns="http://hac.centralindia.cloudapp.azure.com/Reportapp_dev/webservice.asmx">
      <month>$currentMonth</month>
      <timeInterval>$currentTimeslot</timeInterval>
      <etype>$platformType</etype>
    </GET_INBOUND_CALL_FLOW>
  </soap:Body>
</soap:Envelope>
''';

    return callAPI(bodyEnvelope, "GET_INBOUND_CALL_FLOWResponse",
        "GET_INBOUND_CALL_FLOWResult");
  }

  Future<List<BaseModel>> getHotSpotReport(String currentMonth,
      String currentTimeslot, String reportType, String platformType) async {
    String bodyEnvelope = '''
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <GET_HOTSPOT_CALL_FLOW_V1 xmlns="http://hac.centralindia.cloudapp.azure.com/Reportapp_dev/webservice.asmx">
      <month>$currentMonth</month>
      <timeInterval>$currentTimeslot</timeInterval>
      <type>$reportType</type>
      <etype>$platformType</etype>
    </GET_HOTSPOT_CALL_FLOW_V1>
  </soap:Body>
</soap:Envelope>
''';

    return callAPI(bodyEnvelope, "GET_HOTSPOT_CALL_FLOW_V1Response",
        "GET_HOTSPOT_CALL_FLOW_V1Result");
  }

  Future<List<BaseModel>> getAgentPickupReport(String date, String userRole,
      String location, String platformType) async {
    String bodyEnvelope = '''
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <VerifyReport_and xmlns="http://hac.centralindia.cloudapp.azure.com/Reportapp_dev/webservice.asmx">
      <Date>$date</Date>
      <USER_ROLE>$userRole</USER_ROLE>
      <Location>$location</Location>
      <etype>$platformType</etype>
    </VerifyReport_and>
  </soap:Body>
</soap:Envelope>
    ''';

    return callAPI(
        bodyEnvelope, "VerifyReport_andResponse", "VerifyReport_andResult");
  }

  //Lead Wise Conversion API Call
  Future<List<BaseModel>> getLeadWiseConversionReport(
      String leadDate, String platformType) async {
    String bodyEnvelope = '''
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <LEAD_SUMMARY_and xmlns="http://hac.centralindia.cloudapp.azure.com/Reportapp_dev/webservice.asmx">
      <leadDate>$leadDate</leadDate>
      <etype>$platformType</etype>
    </LEAD_SUMMARY_and>
  </soap:Body>
</soap:Envelope>
''';

    return callAPI(
        bodyEnvelope, "LEAD_SUMMARY_andResponse", "LEAD_SUMMARY_andResult");
  }

  Future<List<BaseModel>> getPerformanceOfTheDayReport(String process,
      String location, String count, String platformType) async {
    String bodyEnvelope = '''
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <GET_TOP_PERFORMER_TODAY xmlns="http://hac.centralindia.cloudapp.azure.com/Reportapp_dev/webservice.asmx">
      <process>$process</process>
      <location>$location</location>
      <count>$count</count>
      <etype>$platformType</etype>
    </GET_TOP_PERFORMER_TODAY>
  </soap:Body>
</soap:Envelope>
''';

    return callAPI(bodyEnvelope, "GET_TOP_PERFORMER_TODAYResponse",
        "GET_TOP_PERFORMER_TODAYResult");
  }

  Future<List<BaseModel>> getCorporateReport(
      String date, String platformType) async {
    String bodyEnvelope = '''
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <CorporateReportAndroid xmlns="http://hac.centralindia.cloudapp.azure.com/Reportapp_dev/webservice.asmx">
      <Date>$date</Date>
      <etype>$platformType</etype>
    </CorporateReportAndroid>
  </soap:Body>
</soap:Envelope>
''';

    return callAPI(bodyEnvelope, "CorporateReportAndroidResponse",
        "CorporateReportAndroidResult");
  }

  Future<List<BaseModel>> getRMCollectionReport(
      String fromDate, String toDate, String type, String platformType) async {
    String bodyEnvelope = '''
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <GetRMReportand xmlns="http://hac.centralindia.cloudapp.azure.com/Reportapp_dev/webservice.asmx">
      <fromDate>$fromDate</fromDate>
      <toDate>$toDate</toDate>
      <type>$type</type>
      <etype>$platformType</etype>
    </GetRMReportand>
  </soap:Body>
</soap:Envelope>
''';

    return callAPI(
        bodyEnvelope, "GetRMReportandResponse", "GetRMReportandResult");
  }

  Future<List<BaseModel>> getTDTMReport(
      String fromDate1,
      String toDate1,
      String fromDate2,
      String toDate2,
      String fromDate3,
      String toDate3,
      String fromDate4,
      String toDate4,
      String flowType,
      String specialPackage,
      String platformType) async {
    String bodyEnvelope = '''
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <GetTDTM_1 xmlns="http://hac.centralindia.cloudapp.azure.com/Reportapp_dev/webservice.asmx">
      <FromDate1>$fromDate1</FromDate1>
      <ToDate1>$toDate1</ToDate1>
      <FromDate2>$fromDate2</FromDate2>
      <ToDate2>$toDate2</ToDate2>
      <FromDate3>$fromDate3</FromDate3>
      <ToDate3>$toDate3</ToDate3>
      <FromDate4>$fromDate4</FromDate4>
      <ToDate4>$toDate4</ToDate4>
      <flow2>$flowType</flow2>
      <SpecialPackage>$specialPackage</SpecialPackage>
      <etype>$platformType</etype>
    </GetTDTM_1>
  </soap:Body>
</soap:Envelope>
''';

    return callAPI(bodyEnvelope, "GetTDTM_1Response", "GetTDTM_1Result");
  }

  // govt lab report
  Future<List<BaseModel>> getgovtLaReport(
      String fromDate, String toDate, String platformType) async {
    String bodyEnvelope = '''
<?xml version="1.0" encoding="utf-8"?>
 <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
   <soap:Body>
<send_gov_report_sms xmlns="http://hac.centralindia.cloudapp.azure.com/Reportapp_dev/webservice.asmx">
<FromDate>$fromDate</FromDate>
<ToDate>$toDate</ToDate>
<etype>$platformType</etype>
</send_gov_report_sms>
</soap:Body>
 </soap:Envelope>
''';

    return callAPI(bodyEnvelope, "send_gov_report_smsResponse",
        "send_gov_report_smsResult");
  }

  Future<OTPVerifyModel> otpVerifyAPIRequest(
      String mobileno, String pin, String? imei, String platformType) async {
    // String mobilenosend =
    //     await platform.invokeMethod("encrypt", {"data": mobileno});
    // String otp = await platform.invokeMethod("encrypt", {"data": pin});
    // String imeisend = await platform.invokeMethod("encrypt", {"data": imei});
    var soapEnvelope = '''
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <GetLogin xmlns="http://hac.centralindia.cloudapp.azure.com/Reportapp_dev/webservice.asmx">
      <mobileNo>$mobileno</mobileNo>
      <pin>$pin</pin>
      <iemi>$imei</iemi>
      <etype>$platformType</etype>
    </GetLogin>
  </soap:Body>
</soap:Envelope>
''';

    print("OTP Request: " + soapEnvelope);

    return otpVerifyAPIResponse(
        soapEnvelope, "GetLoginResponse", "GetLoginResult");
  }

  Future<ItemModel> loginAPIRequest(
      String mobileno, String? imei, String platformType) async {
    // String mobilenosend =
    //     await platform.invokeMethod("encrypt", {"data": mobileno});
    // String imeisend = await platform.invokeMethod("encrypt", {"data": imei});

    // String dec = await platform.invokeMethod("decrypt", {"data": imeisend});
    // String mob = await platform.invokeMethod("decrypt", {"data": mobilenosend});
    // print(dec + " ---- " + mob);
    var soapEnvelope = '''
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <SetupPinForAdminMisDcdt xmlns="http://hac.centralindia.cloudapp.azure.com/Reportapp_dev/webservice.asmx">
      <mobileNo>$mobileno</mobileNo>
      <iemi>$imei</iemi>
      <etype>$platformType</etype>
    </SetupPinForAdminMisDcdt>
  </soap:Body>
</soap:Envelope>
''';

    return loginAPIResponse(soapEnvelope, "SetupPinForAdminMisDcdtResponse",
        "SetupPinForAdminMisDcdtResult");
  }

  Future<OTPVerifyModel> otpVerifyAPIResponse(
      String soapEnvelope, String responseTag, String resultTag) async {
    print(soapEnvelope);
    http.Response response = await http
        .post(uri,
            headers: {
              "Content-Type": "text/xml; charset=utf-8",
              "Accept": "text/xml"
            },
            body: soapEnvelope)
        .timeout(const Duration(seconds: 40));

    print(response.body);

    var dataXML =
        await parsingXmlGetElement(response.body, responseTag, resultTag);

    if (response.statusCode == 200) {
      String decryptedJson =
          await platform.invokeMethod("decrypt", {"data": dataXML});

      List<dynamic> parsedListJson = jsonDecode(decryptedJson);
      List<OTPVerifyModel> itemsList = List<OTPVerifyModel>.from(
          parsedListJson.map((i) => OTPVerifyModel.fromJson(i)));
      return itemsList[0];
    } else {
      throw Exception("API call failed please check log");
    }
  }

  Future<ItemModel> loginAPIResponse(
      String soapEnvelope, String responseTag, String resultTag) async {
    print(soapEnvelope);
    http.Response response = await http
        .post(uri,
            headers: {
              "Content-Type": "text/xml; charset=utf-8",
              "Accept": "text/xml"
            },
            body: soapEnvelope)
        .timeout(const Duration(seconds: 40));

    print(response.body);

    var dataXML =
        await parsingXmlGetElement(response.body, responseTag, resultTag);

    if (response.statusCode == 200) {
      String decryptedJson =
          await platform.invokeMethod("decrypt", {"data": dataXML});

      ItemModel model = ItemModel();
      model.otp = decryptedJson;
      print("OTP " + model.otp!);

      return model;
    } else {
      throw Exception("API call failed please check log");
    }
  }

  //Hotspot zone wise API Call
  Future<List<BaseModel>> getHotspotZoneWiseReport(
      String date, String platformType) async {
    String bodyEnvelope = '''
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <Get_HotSpot_ZoneWise_Lead_and32 xmlns="http://hac.centralindia.cloudapp.azure.com/Reportapp_dev/webservice.asmx">
      <Date>$date</Date>
      <etype>$platformType</etype>
    </Get_HotSpot_ZoneWise_Lead_and32>
  </soap:Body>
</soap:Envelope>
''';

    return callAPI(bodyEnvelope, "Get_HotSpot_ZoneWise_Lead_and32Response",
        "Get_HotSpot_ZoneWise_Lead_and32Result");
  }

  //INBOUND_TODAY_STATUS API Call
  Future<List<BaseModel>> getInboundTodayStatusReport(
      String today, String platformType) async {
    String bodyEnvelope = '''
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <INBOUND_TODAY_STATUS_and32 xmlns="http://hac.centralindia.cloudapp.azure.com/Reportapp_dev/webservice.asmx">
      <Today>$today</Today>
      <etype>$platformType</etype>
    </INBOUND_TODAY_STATUS_and32>
  </soap:Body>
</soap:Envelope>
''';

    return callAPI(bodyEnvelope, "INBOUND_TODAY_STATUS_and32Response",
        "INBOUND_TODAY_STATUS_and32Result");
  }

  //Route Tracking API Call
  Future<List<BaseModel>> getGetRouteTrackingReport(
      String uesrId, String platformType) async {
    String bodyEnvelope = '''
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <get_route_tracking xmlns="http://hac.centralindia.cloudapp.azure.com/Reportapp_dev/webservice.asmx">
      <Location>0</Location>
      <userId>$uesrId</userId>
      <etype>$platformType</etype>
    </get_route_tracking>
  </soap:Body>
</soap:Envelope>
''';

    return callAPI(
        bodyEnvelope, "get_route_trackingResponse", "get_route_trackingResult");
  }

  //Team Wise Revenue API Call
  Future<List<BaseModel>> getTeamWiseRevenueReport(String fromDate,
      String toDate, String specialPackage, String platformType) async {
    String bodyEnvelope = '''
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <GetTeamWiseRevenue32 xmlns="http://hac.centralindia.cloudapp.azure.com/Reportapp_dev/webservice.asmx">
      <FromDate>$fromDate</FromDate>
      <ToDate>$toDate</ToDate>
      <SpecialPackage>$specialPackage</SpecialPackage>
      <etype>$platformType</etype>
    </GetTeamWiseRevenue32>
  </soap:Body>
</soap:Envelope>
''';

    return callAPI(bodyEnvelope, "GetTeamWiseRevenue32Response",
        "GetTeamWiseRevenue32Result");
  }

  //Team Wise Revenue API Call
  Future<List<BaseModel>> getPhleboAttendancePickupReport(
      String selectedRM, String searchDate, String platformType) async {
    String bodyEnvelope = '''
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <GET_Phlebo_Attendance_Pickup_and32 xmlns="http://hac.centralindia.cloudapp.azure.com/Reportapp_dev/webservice.asmx">
      <RmName>$selectedRM</RmName>
      <SearchDate>$searchDate</SearchDate>
      <etype>$platformType</etype>
    </GET_Phlebo_Attendance_Pickup_and32>
  </soap:Body>
</soap:Envelope>
''';

    return callAPI(bodyEnvelope, "GET_Phlebo_Attendance_Pickup_and32Response",
        "GET_Phlebo_Attendance_Pickup_and32Result");
  }

  Future<List<BaseModel>> callAPI(
      String soapEnvelope, String responseTag, String resultTag) async {
    print(soapEnvelope);
    http.Response response = await http
        .post(uri,
            headers: {
              "Content-Type": "text/xml; charset=utf-8",
              "Accept": "text/xml"
            },
            body: soapEnvelope)
        .timeout(const Duration(seconds: 80));

    print(response.body);

    var dataXML =
        await parsingXmlGetElement(response.body, responseTag, resultTag);

    if (response.statusCode == 200) {
      String decryptedJson =
          await platform.invokeMethod("decrypt", {"data": dataXML});

      print("ResponseBody: " + decryptedJson);

      List<dynamic> parsedListJson = jsonDecode(decryptedJson);
      List<BaseModel> itemsList = List<BaseModel>.from(
          parsedListJson.map((i) => BaseModel.fromJson(i)));

      return itemsList;
    } else {
      throw Exception("API call failed please check log");
    }
  }

  //Parse XML Data
  Future<String> parsingXmlGetElement(
      var rawResponse, String verifireResponse, String verifireResult) async {
    String resElement = "";
    var rawData = xml.XmlDocument.parse(rawResponse);
    Iterable<xml.XmlElement> items = rawData.findAllElements(verifireResponse);
    items.map((xml.XmlElement item) {
      item.findElements(verifireResult).map((xml.XmlElement node) {
        resElement = node.text;
      }).toList();
    }).toList();
    return resElement;
  }

  Future<String> encrypt(String normalText) async {
    return await platform.invokeMethod("encrypt", {"data": normalText});
  }

  Future<String> decrypt(String encryptedText) async {
    return await platform.invokeMethod("decrypt", {"data": encryptedText});
  }
}
