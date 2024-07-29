import 'package:flutter/material.dart';
import 'package:to_do_app/utils/app_str.dart';
import 'package:to_do_app/views/home/home_view.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool switchkontrol=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeView()));
        }, icon: Icon(Icons.arrow_back,size: 25,)),
      ),
      body: Column(
        children: [
          const Column(
            children: [
              Text("APP SETTİNGS",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage("https://static.vecteezy.com/system/resources/previews/007/698/902/original/geek-gamer-avatar-profile-icon-free-vector.jpg"),
              ),
              Text(AppStr.userName,style:TextStyle(fontWeight: FontWeight.w700, fontSize: 25),),
              Text(AppStr.title,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18),)
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(right: 8.0, bottom: 10),
            child: Divider(thickness: 2, indent: 10),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(AppStr.theme,style: TextStyle(fontWeight: FontWeight.w400,fontSize:30,fontFamily: "LibreBaskerville")),
              ),
              SizedBox(width: 200,
                child: SwitchListTile(
                    title:Text(switchkontrol ? "Dark" : "Light",style: TextStyle(fontSize: 20),),
                    controlAffinity: ListTileControlAffinity.leading,
                    value: switchkontrol,
                    onChanged:(veri){
                    setState(() {
                    switchkontrol=veri;
                    });
                }),
              ),
            ],
          )
        ],
      ),
    );
  }
}
