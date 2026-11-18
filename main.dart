import 'package:flutter/material.dart';

void main() => runApp(const JsccApp());

const forest = Color(0xFF075B35);
const gold = Color(0xFFD6A52B);

class JsccApp extends StatelessWidget {
  const JsccApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'JSCC Official',
    theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: forest), useMaterial3: true, scaffoldBackgroundColor: const Color(0xFFF7FAF7)),
    home: const HomeShell(),
  );
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});
  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int index = 0;
  final pages = const [DashboardPage(), AccountsPage(), MembersPage(), CommitteePage(), AdminPage()];
  final labels = const ['হোম', 'হিসাব', 'সদস্য', 'কমিটি', 'অ্যাডমিন'];
  final icons = const [Icons.home_rounded, Icons.account_balance_wallet, Icons.groups, Icons.groups_2, Icons.admin_panel_settings];
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(backgroundColor: forest, foregroundColor: Colors.white, title: Row(children: [Image.asset('assets/jscc_logo.jpg', width: 38, height: 38, fit: BoxFit.cover), const SizedBox(width: 10), const Expanded(child: Text('JSCC Official', style: TextStyle(fontWeight: FontWeight.bold))) ]), actions: [IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsPage())), icon: const Icon(Icons.notifications_active_outlined))]),
    body: pages[index],
    bottomNavigationBar: NavigationBar(selectedIndex: index, onDestinationSelected: (v) => setState(() => index = v), destinations: List.generate(labels.length, (i) => NavigationDestination(icon: Icon(icons[i]), label: labels[i]))),
  );
}

class SectionTitle extends StatelessWidget {
  final String text;
  const SectionTitle(this.text, {super.key});
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.only(bottom: 10, top: 18), child: Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: forest)));
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});
  Widget metric(String title, String value, IconData icon) => Card(child: Padding(padding: const EdgeInsets.all(14), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(icon, color: forest, size: 26), const SizedBox(height: 12), Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: forest)), Text(title, style: const TextStyle(fontSize: 12),)])));
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(16), children: [
    Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: forest, borderRadius: BorderRadius.circular(18)), child: Row(children: [ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.asset('assets/jscc_logo.jpg', width: 76, height: 76, fit: BoxFit.cover)), const SizedBox(width: 14), const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('জঙ্গলপট্টি সামাজিক কল্যাণ, ক্রীড়া ও সাংস্কৃতিক ক্লাব', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), SizedBox(height: 5), Text('একতা • সেবা • উন্নয়ন', style: TextStyle(color: Colors.white70))]))])),
    const SectionTitle('আর্থিক সারসংক্ষেপ'),
    GridView.count(crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), childAspectRatio: 1.65, children: [metric('মোট ব্যাংক ব্যালেন্স', '৳ --', Icons.account_balance), metric('সদস্যদের মাসিক চাঁদা', '৳ --', Icons.groups), metric('বাহিরের ডোনেশন', '৳ --', Icons.volunteer_activism), metric('১ মাসের মোট জমা', '৳ --', Icons.savings)]),
    const SectionTitle('তিনটি আলাদা ফান্ড'),
    const FundTile(title: 'সামাজিক কল্যাণ ফান্ড', icon: '♡', color: Color(0xFFB52B54)),
    const FundTile(title: 'ক্রীড়া ফান্ড', icon: '🏆', color: Color(0xFF2467B2)),
    const FundTile(title: 'সাংস্কৃতিক ফান্ড', icon: '♫', color: Color(0xFF8051A8)),
    const SectionTitle('সাম্প্রতিক বার্তা'),
    const Card(child: ListTile(leading: Icon(Icons.campaign, color: gold), title: Text('এখনো কোনো নতুন বার্তা নেই'), subtitle: Text('অনুমোদিত ঘোষণা এখানে দেখা যাবে.'))),
    const SizedBox(height: 20),
  ]);
}

class FundTile extends StatelessWidget {
  final String title; final String icon; final Color color;
  const FundTile({super.key, required this.title, required this.icon, required this.color});
  @override
  Widget build(BuildContext context) => Card(child: ListTile(leading: CircleAvatar(backgroundColor: color.withOpacity(.12), child: Text(icon, style: TextStyle(color: color, fontSize: 22))), title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)), trailing: const Text('৳ --', style: TextStyle(fontWeight: FontWeight.bold, color: forest))));
}

class AccountsPage extends StatelessWidget {
  const AccountsPage({super.key});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(16), children: [const Text('হিসাব', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: forest)), const Text('মাসিক ও বার্ষিক আর্থিক রেকর্ড'), const SizedBox(height: 14), for (final item in ['স্থায়ী রেকর্ড', 'মাসিক রেকর্ড', 'বার্ষিক রেকর্ড', 'PDF ডাউনলোড / প্রিন্ট']) Card(child: ListTile(leading: const Icon(Icons.receipt_long, color: forest), title: Text(item), trailing: const Icon(Icons.chevron_right))), const SizedBox(height: 12), const Text('হিসাবের ডেটাবেজ সংযুক্ত হলে এখানে অনুমোদিত লেনদেন ও রিপোর্ট দেখা যাবে.')]);
}

class MembersPage extends StatelessWidget {
  const MembersPage({super.key});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(16), children: [const Text('অনুমোদিত সদস্য তালিকা', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: forest)), const SizedBox(height: 12), const TextField(decoration: InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'নাম বা সদস্য নম্বর দিয়ে খুঁজুন', border: OutlineInputBorder())), const SizedBox(height: 12), FilledButton.icon(onPressed: () {}, icon: const Icon(Icons.person_add), label: const Text('সদস্য যোগ করুন')), const SizedBox(height: 10), const Text('সদস্যের তথ্য ডেটাবেজ যুক্ত হওয়ার পর প্রদর্শিত হবে।')]);
}

class CommitteePage extends StatelessWidget {
  const CommitteePage({super.key});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(16), children: [const Text('পরিচালনা কমিটি', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: forest)), const Text('১৫ জন সদস্যের কমিটি'), const SizedBox(height: 12), FilledButton.icon(onPressed: () {}, icon: const Icon(Icons.person_add), label: const Text('কমিটির সদস্য যোগ করুন')), const SizedBox(height: 12), for (var i=1; i<=15; i++) Card(child: ListTile(leading: CircleAvatar(child: Text(i.toString().padLeft(2,'0'))), title: Text('কমিটির সদস্য $i'), subtitle: const Text('নাম ও পদবি নির্ধারণ করতে হবে')))]);
}

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(16), children: [const Text('অ্যাডমিন ব্যবস্থা', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: forest)), const SizedBox(height: 12), const TextField(decoration: InputDecoration(labelText: 'ইউজারনেম', border: OutlineInputBorder())), const SizedBox(height: 12), const TextField(obscureText: true, decoration: InputDecoration(labelText: 'পাসওয়ার্ড', border: OutlineInputBorder())), const SizedBox(height: 12), FilledButton(onPressed: () {}, child: const Text('লগইন')), TextButton(onPressed: () {}, child: const Text('ইউজারনেম / পাসওয়ার্ড পরিবর্তন')) , const Text('নিরাপদ সার্ভার অথেনটিকেশন সংযুক্ত না হওয়া পর্যন্ত এই লগইনটি শুধু UI নমুনা।')]);
}

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('নতুন বার্তা')), body: const Center(child: Padding(padding: EdgeInsets.all(24), child: Text('সব অনুমোদিত পরিবর্তনের নোটিফিকেশন এখানে আসবে।'))));
}
