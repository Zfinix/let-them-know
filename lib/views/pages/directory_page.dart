import 'package:call_them_app/utils/margin.dart';
import 'package:call_them_app/views/directory/senate_directory.dart';
import 'package:call_them_app/widgets/spring_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DirectoryPages extends StatefulHookWidget {
  DirectoryPages({Key key}) : super(key: key);

  @override
  _DirectoryPagesState createState() => _DirectoryPagesState();
}

class _DirectoryPagesState extends State<DirectoryPages> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight(context) - 90,
      child: ListView(
        children: <Widget>[
          SpringButton(
            child: Stack(
              children: <Widget>[
                Container(
                  width: screenWidth(context),
                  height: 180,
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[300],
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 0,
                        offset: Offset(0, 10),
                        color: Colors.grey.withOpacity(0.8),
                        blurRadius: 25,
                      ),
                    ],
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://i1.wp.com/www.icirnigeria.org/wp-content/uploads/2018/03/Senate-e1539271753468.png?fit=730%2C389&ssl=1')),
                  ),
                ),
                Container(
                  width: screenWidth(context),
                  height: 180,
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black38,
                  ),
                  child: Center(
                      child: Text(
                    'Senate',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  )),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                CustomPageRoute(
                  SenateDirectory(),
                ),
              );
            },
          ),
          /*   Hero(
            tag: 'national',
            child: SpringButton(
              SpringButtonType.OnlyScale,
              Stack(
                children: <Widget>[
                  Container(
                    width: screenWidth(context),
                    height: 180,
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 0,
                          offset: Offset(0, 10),
                          color: Colors.grey.withOpacity(0.8),
                          blurRadius: 25,
                        ),
                      ],
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://www.naijanews.com/wp-content/uploads/2017/07/National-Assembly.jpg')),
                    ),
                  ),
                  Container(
                    width: screenWidth(context),
                    height: 180,
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black38,
                    ),
                    child: Center(
                        child: Text(
                      'House of Reps',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    )),
                  ),
                ],
              ),
              onTap: () {},
            ),
          ),
          Hero(
            tag: 'governors',
            child: SpringButton(
              SpringButtonType.OnlyScale,
              Stack(
                children: <Widget>[
                  Container(
                    width: screenWidth(context),
                    height: 180,
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 0,
                          offset: Offset(0, 10),
                          color: Colors.grey.withOpacity(0.8),
                          blurRadius: 25,
                        ),
                      ],
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://i2.wp.com/media.premiumtimesng.com/wp-content/files/2018/02/Cross-section-of-Nigerian-governors.jpg?fit=960%2C640&ssl=1')),
                    ),
                  ),
                  Container(
                    width: screenWidth(context),
                    height: 180,
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black38,
                    ),
                    child: Center(
                        child: Text(
                      'Governors',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    )),
                  ),
                ],
              ),
              onTap: () {},
            ),
          ),
          Hero(
            tag: 'ministers',
            child: SpringButton(
              SpringButtonType.OnlyScale,
              Stack(
                children: <Widget>[
                  Container(
                    width: screenWidth(context),
                    height: 180,
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 0,
                          offset: Offset(0, 10),
                          color: Colors.grey.withOpacity(0.8),
                          blurRadius: 25,
                        ),
                      ],
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://lh3.googleusercontent.com/-qPOhBeGD-l4/VkXTZdT8iSI/AAAAAAAAEyA/0AWFewhOJEs/s444-Ic42/muhammadu-buhari-his-ministers-small.jpg')),
                    ),
                  ),
                  Container(
                    width: screenWidth(context),
                    height: 180,
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black38,
                    ),
                    child: Center(
                        child: Text(
                      'Ministers',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    )),
                  ),
                ],
              ),
              onTap: () {},
            ),
          ),
         */
        ],
      ),
    );
  }
}
