import 'package:flutter/material.dart';

class landing extends StatefulWidget {
  const landing({Key? key}) : super(key: key);

  @override
  State<landing> createState() => _landingState();
}

class _landingState extends State<landing> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
         padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width * 0.50,
                              left: MediaQuery.of(context).size.width * 0.03,
                              bottom: MediaQuery.of(context).size.width * 0.01,
                              right: MediaQuery.of(context).size.width * 0.03),
        children: [
           Container(
            child:Column(
              children: [
                CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 60.0,
                        child: Icon(
                          Icons.web_stories,
                          color: Colors.redAccent,
                          size: 60.0,
                        ),
                      ),
              ],
            )
           ),
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                ),
              ),
              child: Text(' Login',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05))
              ),
               SizedBox(height: MediaQuery.of(context).size.height*0.07,),
              ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                ),
              ),
              child: Text(' Lost mobile',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05),)
              ),
       SizedBox(height: MediaQuery.of(context).size.height*0.07,),
              ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                ),
              ),
              child: Text(' Join Member ',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05))
              )
        ],
      ),
    );
  }
}
