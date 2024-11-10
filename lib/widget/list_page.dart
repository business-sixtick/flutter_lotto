import 'package:flutter/material.dart';

class ListPage extends StatelessWidget{
  List<List<int>> list;
  ListPage(this.list);

  @override
  Widget build(BuildContext context) {
    debugPrint(MediaQuery.of(context).size.width.toString());
    debugPrint(list.length.toString());
    return Container(
              margin: const EdgeInsets.all(2),
              color: Colors.white,
              child: Center(
                child: ListView.separated(
                  itemCount: list.length,
                  // itemCount: 0,
                  itemBuilder: (context, index){
                    return ListTile(
                      // leading: CircleAvatar(radius: 25, child: Text(' >> '),),
                      title: Text(
                        '${list[list.length - (index + 1)][2]}, '
                        '${list[list.length - (index + 1)][3]}, '
                        '${list[list.length - (index + 1)][4]}, '
                        '${list[list.length - (index + 1)][5]}, '
                        '${list[list.length - (index + 1)][6]}, '
                        '${list[list.length - (index + 1)][7]}, '
                        '(${list[list.length - (index + 1)][8]})'
                      , textAlign: TextAlign.center, style: TextStyle(fontSize: MediaQuery.of(context).size.width / 20),),
                      subtitle: Text(
                        "<${list[list.length - (index + 1)][0]}회> " 
                        "${DateTime.fromMillisecondsSinceEpoch(list[list.length - (index + 1)][1]).toString().split(' ')[0]}"
                      , textAlign: TextAlign.center, style: TextStyle(fontSize: MediaQuery.of(context).size.width / 25)),
                      // trailing: Container(
                      //   width: 500,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       CircleNumber('${list[list.length - (index + 1)][2]}'),
                      //       CircleNumber('${list[list.length - (index + 1)][3]}'),
                      //       CircleNumber('${list[list.length - (index + 1)][4]}'),
                      //       CircleNumber('${list[list.length - (index + 1)][5]}'),
                      //       CircleNumber('${list[list.length - (index + 1)][6]}'),
                      //       CircleNumber('${list[list.length - (index + 1)][7]}'),
                      //       Icon(Icons.add),
                      //       CircleNumber('${list[list.length - (index + 1)][8]}'),
                      //     ],
                      //   ),
                      // ),

                    );
                  } ,
                  separatorBuilder: (context, index){
                    return Divider(height: 4,);
                  },
                  )
              ),
            );
  }
}