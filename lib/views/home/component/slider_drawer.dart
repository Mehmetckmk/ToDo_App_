import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/extensions/space_exs.dart';
import 'package:to_do_app/utils/app_colors.dart';
import 'package:to_do_app/views/home/home_view.dart';
import 'package:to_do_app/views/slider_buton/profile_page.dart';
import 'package:to_do_app/views/slider_buton/settings_page.dart';

class CustomDrawer extends StatelessWidget {

  final List<IconData> icons=[
    CupertinoIcons.home,
    CupertinoIcons.person_fill,
    CupertinoIcons.settings,
  ];
  final List<String> texts=[
    "Home",
    "Profile",
    "Settings",
  ];


  @override
  Widget build(BuildContext context) {
    var textTheme=Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 90),
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: AppColors.primaryGradientColor,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          const  CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
              "https://static.vecteezy.com/system/resources/previews/007/698/902/original/geek-gamer-avatar-profile-icon-free-vector.jpg",
            ),
          ),
          10.h,
          Text("Mehmet Cakmak",style: textTheme.displayMedium,),
          Text("Banü Software Developer",style: textTheme.displaySmall,),
          Container(
            margin: EdgeInsets.symmetric(vertical: 30,horizontal: 10,),
            width: double.infinity,
            height: 300,
            child: ListView.builder(
              itemCount: icons.length,
                itemBuilder:(BuildContext context,int index){
                return InkWell(
                  onTap: (){
                    print("${texts[index]} Basıldı");
                    if(texts[index]=="Home"){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeView()));
                    }
                    if(texts[index]=="Profile"){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ProfilePage()));
                    }
                    if(texts[index]=="Settings"){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SettingsPage()));
                    }
                  },
                  child: Container(
                    margin:const EdgeInsets.all(3),
                    child: ListTile(
                      leading: Icon(icons[index],color: Colors.white,size: 30,),
                      title: Text(texts[index],style: TextStyle(color: Colors.white,fontSize: 20),),
                    ),
                  ),
                );
                },
            ),
          ),
        ],
      ),
    );
  }
}
