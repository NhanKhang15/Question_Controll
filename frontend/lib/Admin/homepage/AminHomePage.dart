import 'package:flutter/material.dart';
import 'package:frontend/Admin/add_new_question/add_question_pages.dart';
import '../slide_bar/sidebar_menu.dart';
import '../list_of_questions/pages/question_home_page.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.maybePop(context);
    });
  }

  Widget _getBodyContent() {
    switch (_selectedIndex) {
      case 0:
        return QuestionHomePage();
      case 1:
        return AddQuestionPage();
      default:
        return QuestionHomePage();
    }
  }

  String get _appBarTitle {
    switch (_selectedIndex) {
      case 0:
        return '📋 Danh sách câu hỏi';
      case 1:
        return '➕ Thêm Câu Hỏi Mới';
      default:
        return '📋 Danh sách câu hỏi';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   drawer: widget.userAccount != null
      // ? SidebarMenu(
      //     // userAccount: widget.userAccount!,
      //     selectedIndex: _selectedIndex, // Pass selectedIndex
      //     onItemSelected: _onItemSelected, // Pass callback
      //   )
      // : null,
      drawer: SidebarMenu(
        // userAccount: widget.userAccount,
        selectedIndex: _selectedIndex, // Pass selectedIndex
        onItemSelected: _onItemSelected, // Pass callback
      ),
      appBar: AppBar(
        title: Text(_appBarTitle),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: _getBodyContent(),
    );
  }
}
