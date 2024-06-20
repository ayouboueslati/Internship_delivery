class HotelListData {
  static int? searchPhoneNumber;

  HotelListData({
    this.code = '',
    this.namePerson = '',
    this.phone = 0,
    this.reviews = 0,
    this.amount = 0,
    this.colieState = '',
    this.time = '',
    this.barcode = '',
    this.recipientInfo = '',
    this.supplierInfo = '',
    this.address = '',
  });

  String code;
  String namePerson;
  int phone;
  int reviews;
  int amount;
  String colieState;
  String time;
  String barcode;
  String recipientInfo;
  String supplierInfo;
  String address;

  static List<HotelListData> get hotelList {
    if (searchPhoneNumber != null && searchPhoneNumber != 0) {
      return _hotelList
          .where((hotel) => hotel.phone == searchPhoneNumber)
          .toList();
    } else {
      return _hotelList;
    }
  }

  static List<HotelListData> _hotelList = <HotelListData>[
    HotelListData(
      code: '12323287',
      namePerson: 'Ahmed',
      phone: 29564230,
      reviews: 80,
      amount: 180,
      colieState: 'en cours',
      time: '10:00 AM',
      barcode: '123456789',
      recipientInfo: 'Tunis',
      supplierInfo: 'Benzart',
      address: 'Ariana',
    ),
    HotelListData(
      code: '76556309',
      namePerson: 'Salma',
      phone: 43460766,
      reviews: 74,
      amount: 200,
      colieState: 'livré',
      time: '12:30 PM',
      barcode: '987654321',
      recipientInfo: 'Address',
      supplierInfo: ' Address',
      address: 'Hotel Address',
    ),
    HotelListData(
      code: '86554478',
      namePerson: 'Amine',
      phone: 92336340,
      reviews: 62,
      amount: 60,
      colieState: 'en cours',
      time: '09:00 AM',
      barcode: '654321987',
      recipientInfo: 'Address',
      supplierInfo: 'Address',
      address: 'Hotel Address',
    ),
    HotelListData(
      code: '86765645',
      namePerson: 'Hassen',
      phone: 96546098,
      reviews: 90,
      amount: 170,
      colieState: 'livré',
      time: '02:00 PM',
      barcode: '789456123',
      recipientInfo: 'Address',
      supplierInfo: 'Address',
      address: 'Hotel Address',
    ),
    HotelListData(
      code: '875765376',
      namePerson: 'Adem',
      phone: 21231232,
      reviews: 240,
      amount: 200,
      colieState: 'livré',
      time: '03:30 PM',
      barcode: '456123789',
      recipientInfo: 'Address',
      supplierInfo: 'Address',
      address: 'Hotel Address',
    ),
  ];
}
