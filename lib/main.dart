import 'package:employee_app/Models/model.dart';
import 'package:employee_app/Theme/colors.dart';
import 'package:employee_app/Theme/fontStyle.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const MyHomePage(title: 'Flutter jSON API- Http Get Method '),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  final url= Uri.parse('https://reqres.in/api/users');
  int counter=0;
  var employeeResult;

  Future callingEmployee() async{
    try{
      final response = await http.get(url); //get employee list
      if(response.statusCode == 200){
        var result = employeeFromJson(response.body);
        if(mounted){
          setState(() {
            counter =result.data!.length;
            employeeResult =result;
          });
          return result;
        }
      }else{
        print(response.statusCode);
      }
    }
    catch (e){
      print((e.toString()));
    }
  }

  @override

  void initState() {
    super.initState();
    callingEmployee();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Employee List'),
        backgroundColor: blueGray,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(

          child: counter!= null? //waiting for the employee data
          ListView.builder(

              itemCount:counter,
              itemBuilder: (context,index){
               return ListTile(
                 title: Text(employeeResult.data[index].firstName +
                     ' ' + employeeResult.data[index].lastName, style: titleStyle),
                 subtitle: Text(employeeResult.data[index].email, style: subTitleStyle),
                 leading: CircleAvatar(
                   backgroundImage:
                   NetworkImage(employeeResult.data[index].avatar),
                 ),
               );
              }
          ): Center (child: CircularProgressIndicator()), //view loading until data shows up
        ),
      ),
      floatingActionButton:  FloatingActionButton(
        child: Icon(Icons.refresh), //or use resfreshIcon in icons
        onPressed: (){
          callingEmployee();
        },
      ),
    );
  }
}
