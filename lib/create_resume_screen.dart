import 'package:flutter/material.dart';
//
//
// class CreateResume extends StatefulWidget{
//
//   CreateResume({super.key}) ;
//
//   @override
//   State<StatefulWidget> createState() {
//     return _CreateResumeState() ;
//   }
// }
//
// class _CreateResumeState extends State<CreateResume>{
//
//   final Widget data = const Text("Drag fields here ");
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       body: Column(
//         children: [
//           SingleChildScrollView(
//             child: Container(
//               color: Colors.grey,
//               child: DragTarget(
//                 builder: (context, List<dynamic> accepted,List<dynamic> rejected){
//                 },
//               ),
//             ),
//           ),
//           const Divider(color: Colors.black87,thickness: 1,),
//           const SingleChildScrollView(
//             child: Draggable(
//               feedback: TextField(
//               decoration: InputDecoration(
//               border: OutlineInputBorder(),
//               labelText: 'Draggable Text Field'),
//               ),
//               child: TextField(
//                 decoration: InputDecoration(
//                     border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
//                     labelText: 'Draggable Text Field'),
//               ),
//     ),
//               ),
//         ],
//
//       )
//     );
//   }
// }
//


class DragAndDrop extends StatefulWidget {
  @override
  _DragAndDropState createState() => _DragAndDropState();
}

class _DragAndDropState extends State<DragAndDrop> {
  String data = 'Drag me';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Draggable(
            data: data,
            child: Container(
              height: 100,
              width: 100,
              color: Colors.blue,
              child: Center(
                child: Text(data),
              ),
            ),
            feedback: Container(
              height: 100,
              width: 100,
              color: Colors.blue.withOpacity(0.5),
              child: Center(
                child: Text(data),
              ),
            ),
          ),
          SizedBox(height: 50),
          DragTarget(
            builder:
                (BuildContext context, List<dynamic> accepted, List<dynamic> rejected) {
              return Container(
                height: 100,
                width: 100,
                color:
                accepted.isEmpty ? Colors.grey : Colors.green,
                child: Center(
                  child: Text('Drop here'),
                ),
              );
            },
            onAccept: (dynamic receivedData) {
              setState(() {
                data = receivedData;
              });
            },
          ),
        ],
      ),
    );
  }
}