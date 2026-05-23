class SettingsResponse {
  bool? status;
  String? message;
  List<Data>? data;

  SettingsResponse({this.status, this.message, this.data});

  SettingsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  dynamic siteName;
  dynamic siteLogo;
  dynamic siteFavicon;
  dynamic siteDescription;
  dynamic siteAddress;
  dynamic phoneContact;
  dynamic tax;
  dynamic serviceFees;

  Data({
    this.id,
    this.siteName,
    this.siteLogo,
    this.siteFavicon,
    this.siteDescription,
    this.siteAddress,
    this.phoneContact,
    this.tax,
    this.serviceFees,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    siteName = json['site_name'];
    siteLogo = json['site_logo'];
    siteFavicon = json['site_favicon'];
    siteDescription = json['site_description'];
    siteAddress = json['site_address'];
    phoneContact = json['phone_contact'];
    tax = json['tax'];
    serviceFees = json['service_fees'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['site_name'] = siteName;
    data['site_logo'] = siteLogo;
    data['site_favicon'] = siteFavicon;
    data['site_description'] = siteDescription;
    data['site_address'] = siteAddress;
    data['phone_contact'] = phoneContact;
    data['tax'] = tax;
    data['service_fees'] = serviceFees;
    return data;
  }
}
