import 'package:flutter/material.dart';
import 'package:manageresume/model/resume_data.dart';
import 'package:manageresume/user_login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserDataScreen extends StatefulWidget{

  const UserDataScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _UserDataScreenState() ;
  }
}

class _UserDataScreenState extends State<UserDataScreen>{
  List<Resumes> resumeList = [
    Resumes(title: 'Flutter Developer resume for Ahmedabad', url: ''),
    Resumes(title: 'Python Developer resume for Ahmedabad', url: ''),
    Resumes(title: 'QA Resume', url: ''),
  ];

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.remove("access");
    prefs.remove("refresh");
    print(prefs.getString('access'));
    print(prefs.getString('refresh'));
    Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => UserLoginScreen())) ;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const SizedBox(
          height: 50,
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
              hintText: 'Search...',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        actions:[

          IconButton(onPressed: logout, icon: const Icon(Icons.add))
        ],
      ),
      body:
      ListView.builder(itemCount: resumeList.length, itemBuilder: (ctx, index) => ShowResumes(resume: resumeList[index],)
      ),
    );
  }
}

class ShowResumes extends StatelessWidget{

  const ShowResumes({super.key, required this.resume});

  final Resumes resume ;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Chip(
        label: Row(
          children: [
            Expanded(child: Text(resume.title)),
            const Spacer(),
            IconButton(onPressed: (){}, icon: const Icon(Icons.download)),

          ],
        )
      ),
    ) ;
  }
}