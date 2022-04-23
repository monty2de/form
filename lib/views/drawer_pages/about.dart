import 'package:flutter/material.dart';

import '../../drawer.dart';

// ignore: must_be_immutable
class About extends StatefulWidget {
  late int role;
  About(this.role);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(this.widget.role),
      appBar: AppBar(
        title: Text('نبذة عن القسم'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          children: <Widget>[
            Text(
              'إن التطور الهائل الذي حدث في مجال صناعة الحاسبات والبرمجيات'
              'وتأثيره على مختلف علوم المعرفة وتطبيقاته الواسعة جدا في شتى مجالات'
              'الحياة اقتضي تأمين وتهيئة كوادر علمية وهندسية يمكنها مواكبة هذا التطور البالغ الأهمية'
              '. من هنا جاء استحداث قسم هندسة الحاسبات والبرمجيات ليقدم مساهمة جادة في خلق القاعدة العلمية'
              'وتخريج الكوادر الهندسية المؤهلة للعمل في هذا المضمار . تأسس القسم'
              'عام 1996 بعدد محدود من الكوادر التدريسية وقد شهد توسعاً وتطوراً خلال فترة قصيرة جدا .'
              'باشر القسم باستقبال طلبة الدراسة الصباحية منذ تأسيسه كما استقبل طلبة الدراسات المسائية منذ عام 1998.'
              'يمتلك القسم خطط طموحة في التوسع وتحديث المناهج وفتح مختبرات جديدة واعادة فتح الدراسات العليا .',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'الرؤية :',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'يتطلع قسم هندسة الحاسوب إلى تحقيق تمع التميز في مجال التدريس لعلوم هندسة الحاسوب والبحث العلمي وخدمة | ضمن معايير الجودة الشاملة والسياقات الاكاديمية العالمية الرصينة .',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'الرسالة :',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'تنبثق رسالة القسم من رسالة الكلية والجامعة حيث يهدف قسم هندسة الحاسوب إلى إعداد كوادر هندسية متخصصة ومتميزة في مجال هندسة الحاسوب ، وتعزيز مشاريع البحث العلمي في هذا التخصص وتبني احدث الخطط وتقنيات التعلم لتطوير القدرات وصقل المهارات لكل من الطلبة والهيئة التدريسية ، ورفد سوق العمل المحلي والإقليمي بالكوادر الهندسية المتخصصة في مجال هندسة الحاسوب وإجراء البحوث العلمية التي تساهم في حل مشكلات المجتمع .',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'الاهداف التعليمية للبرنامج : ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '1. اعداد مهندسيم متخصصين متميزين في مجال هندسة الحاسوب قادرين على المنافسة والتطوير والتطور على المدى البعيد .',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '2. تطبيق احدث التقنيات والاساليب في العملية التعليمية والبحثية . ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '3. تطبيق معايير الجودة الشاملة في جميع الفعاليات المتعلقة بجميع عناصر العملية التعليمية التي يقدمها المجتمع . ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '4. المساهمة في تنمية البحث العلمي وتشجيع الابداع والابتكار والتميز في مجالات هندسة الحاسوب . ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '5. بناء وتعزيز الشراكات الفاعلة مع المؤسسات الحكومية والعامة خدمة للمصلحة العامة .',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
