import 'package:flutter/material.dart';
import 'package:latihan_crud_firebase/state_util.dart';
import '../../add_data_page/view/add_data_page_view.dart';
import '../view/home_page_view.dart';

class HomePageController extends State<HomePageView> implements MvcController {
  static late HomePageController instance;
  late HomePageView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  goToAddDataPage() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const AddDataPageView()));
  }
}
