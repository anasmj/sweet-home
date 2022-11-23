class DemoRenter {
  String name;
  String time;
  double amount;
  DemoRenter({required this.name, required this.time, required this.amount});
  static List<DemoRenter> pendingList = [
    DemoRenter(name: 'রাফি', time: '2/9/\'22', amount: 22030),
    DemoRenter(name: 'জামিউল', time: '1/9/\'22', amount: 2150),
    DemoRenter(name: 'হাসিবুর রহমান', time: '14/9/\'22', amount: 22300),
    DemoRenter(name: 'নায়িম হোসেন', time: '4/9/\'22', amount: 24010),
    DemoRenter(name: 'নাবিল সরকার', time: '2/9/\'22', amount: 20330),
    DemoRenter(name: 'রাফি', time: '4/9/\'22', amount: 26560),
    DemoRenter(name: 'রাফি', time: '5/9/\'22', amount: 24640),
  ];
}
