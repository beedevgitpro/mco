import 'dart:async';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mco/app/components/appbar.dart';
import 'package:mco/app/components/pagenavigator.dart';
import 'package:mco/app/controllers/bookformController.dart';
import 'package:mco/app/models/clinic_model.dart';
import 'package:mco/app/models/hospital_model.dart';
import 'package:mco/app/pages/bookform/bookmethods.dart';
import 'package:mco/app/pages/home/home_page.dart';
import 'package:mco/app/pages/myaccount/ecard/ecardmethods.dart';
import 'package:mco/app/pages/myaccount/ecard/ecardmodel.dart';
import 'package:mco/app/utils/auth_utils.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' as io;
import '../../../alert.dart';
import '../../constants.dart';

class BookForm extends StatefulWidget {
  final HospitalData hospitalData;

  BookForm(this.hospitalData);
  @override
  BookFormState createState() => new BookFormState();
}

class BookFormState extends State<BookForm> {
 
  FileType pickingType = FileType.any;
  TextEditingController _controller = new TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String responseStatus = '';
  Dio dio = new Dio();
  BuildContext context;
  final ecardApi = EcardApiRepository();
  List<McoCardDetail> ecardApidata = [];
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences _sharedPreferences;
  String authToken,userProfileCode;

  int userId;
    String nric, relation,name,dropdownItemIdentifier;
  bool _loading=true;
  Future fetchToken() async {
    _sharedPreferences = await _prefs;
    authToken = AuthUtils.getToken(_sharedPreferences);
    userId = AuthUtils.getUserId(_sharedPreferences);
    userProfileCode = AuthUtils.getUserProfileCode(_sharedPreferences);
    ecardApi.getUserCardFromProfileCode(
        authToken, false, getEcardApi, userProfileCode).then((value){
          ecardApidata=value;
          setState(() {
            _loading=false;
          });
        });
  }
  List<bool> completedStep=[false,false,false,false];
 
  static TextEditingController _phoneNo = new TextEditingController();

  static TextEditingController _issue = new TextEditingController();

  @override
  void initState() {
    print("${widget.hospitalData.name} inside");
    super.initState();
    fetchToken();
    _issue.clear();

  }
  int currentStep = 0;
  var format = DateFormat('MMM dd, yyyy');
  var selectedDate = DateTime.now().add(Duration(days: 1));
  var selectedTime = TimeOfDay.now();
  String filePath='';
  @override
  Widget build(BuildContext context) {
    Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: selectedDate,
      lastDate: selectedDate.add(Duration(days: 30)),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData(
              colorScheme: ColorScheme.light(primary: Colors.indigo),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
              primaryColor: Colors.indigo, //Head background
              accentColor: Colors.indigo //selection color
              //dialogBackgroundColor: Colors.white,//Background color
              ),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData(
              colorScheme: ColorScheme.light(primary: Colors.indigo),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
              primaryColor: Colors.indigo, //Head background
              accentColor: Colors.indigo //selection color
              //dialogBackgroundColor: Colors.white,//Background color
              ),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = picked;
      });
  }
    List<Step> mySteps = [
       Step(
          title: Text("User Details"),
          state:currentStep==0?StepState.editing:(completedStep[0]?StepState.complete:StepState.indexed),
          content: Column(
            children: <Widget>[

              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                   decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all()
                  ),
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButtonFormField(
                      isExpanded: true,
                    
                      decoration: InputDecoration(
                       enabledBorder: InputBorder.none,
                      ),
                        hint: Text('Select Policy No.',
                            ),
                        value: dropdownItemIdentifier,
                        items: [
                          for (McoCardDetail card in ecardApidata)
                            DropdownMenuItem(
                                child: Text(card.policyNo.toString()+"  "+card.name, ),
                                value: card.policyNo+card.nricCode+card.mcoCardNo)
                        ],
                        onChanged: (value) {
                          setState(() {
                            for(McoCardDetail card in ecardApidata)
                              
                              {
                                if(card.policyNo+card.nricCode+card.mcoCardNo==value)
                                {
                                  name=card.name;
                                  nric=card.nricCode;
                                  }}
                            dropdownItemIdentifier = value;
                          });
                        }),
                  ),
                ),
                              
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all()
                  ),
                  child: 
                Text(name??'Name'
                ,style: TextStyle(
                 color:name!=null?Colors.black:Colors.black54 
                ),
                ),),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all()
                  ),
                  child: 
                Text(nric??'NRIC No.'
                ,style: TextStyle(
                 color:nric!=null?Colors.black:Colors.black54 
                ),
                ),),
              ),
              // Padding(
              //   padding: EdgeInsets.all(8.0),
              //   child: Container(
              //     padding: EdgeInsets.all(15),
              //     width: double.infinity,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(10),
              //       border: Border.all()
              //     ),
              //     child: 
              //   Text(relation??'Relation Type'
              //   ,style: TextStyle(
              //    color:relation!=null?Colors.black:Colors.black54 
              //   ),
              //   ),),
              // ),
              formTextField(_phoneNo, "Phone No", TextInputType.number),
            ],
          ),
          isActive: true),
      new Step(
          title: new Text("Schedule"),
          state:currentStep==1?StepState.editing:(completedStep[1]?StepState.complete:StepState.indexed),
          content: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all()
                  ),
                  child: ListTile(
                      leading: Icon(Icons.calendar_today,color: leadingColor,),
                      title: Text("${format.format(selectedDate)}"),
                      trailing: FlatButton(color:Colors.indigo,child: Text('Select',style: TextStyle(color:Colors.white),),onPressed: (){
                         _selectDate(context);
                      },),
                    ),
                ),
              //   buildDateTimePickerFormField(
              //       _date, "Date", InputType.date, Icons.date_range),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all()
                  ),
                  child: ListTile(
                    leading: Icon(Icons.access_time,color: leadingColor,),
                    title: Text('${(selectedTime.hour>12?selectedTime.hour-12:selectedTime.hour).toString()+":"+selectedTime.minute.toString()+" "+(selectedTime.hour>12?"PM":"AM").toString()}'),
                    trailing: FlatButton(color:Colors.indigo,child: Text('Select',style: TextStyle(color:Colors.white),),onPressed: (){
                      _selectTime(context);
                    },),
                  ),
                )
              ),
            ],
          ),
     
          isActive: true),
      new Step(
          state:currentStep==2?StepState.editing:(completedStep[2]?StepState.complete:StepState.indexed),
          title: new Text("Upload Documents"),
          content: Center(child: Column(
            children: [
              FlatButton(onPressed: ()async{
                // files.add(await FilePicker.getFile());
                filePath.isEmpty?
                filePath=await FilePicker.getFilePath(
              type: FileType.custom,
              allowedExtensions: ['jpg', 'pdf', 'doc'],
        ):filePath='';
        setState(() { });
              }, color:filePath.isEmpty?Colors.indigo:Colors.red,child: Text(filePath.isEmpty?'Upload Document':'Remove Document',style: TextStyle(color:Colors.white),),),
            if(filePath.isNotEmpty)
            Text(filePath.split('/').last)
            ],
          ),),
          isActive: true),
          new Step(
          state:currentStep==3?StepState.editing:(completedStep[3]?StepState.complete:StepState.indexed),
          title: new Text("Issues"),
          content: Column(
            children: <Widget>[
                            formTextField(_issue, "Issues", TextInputType.text, 3),
            ],
          ),
          isActive: true),
    ];

    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text('${widget.hospitalData.name} Form'),
      ),
      body: _loading? Center(child:CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),)):Container(
          child: GestureDetector(
            onPanDown: (_){
              FocusScope.of(context).requestFocus(FocusNode());
            },
                      child: new Stepper(
        currentStep: this.currentStep,
        steps: mySteps,
        onStepCancel: () {
            setState(() {
              if (currentStep > 0) {
                currentStep = currentStep - 1;
              } else {
                currentStep = 0;
              }
            });
            print("onStepCancel : " + currentStep.toString());
        },
        onStepTapped: (index) {
            setState(() {
              currentStep = index;
            });
        },
        onStepContinue: () {
            setState(() {
         
              if (currentStep < mySteps.length - 1) {
                completedStep[currentStep]=true;
                currentStep = currentStep + 1;
              } else {
                if (
                    _phoneNo.text != '' &&
                    dropdownItemIdentifier.isEmpty??false) {
 
                  sendDataHospital(
                    filePath,
                    filePath.split('/').last,
                    name,
                    nric,
                    _phoneNo.text,
                    format.format(selectedDate),
                    (selectedTime.hour>12?selectedTime.hour-12:selectedTime.hour).toString()+":"+selectedTime.minute.toString()+" "+(selectedTime.hour>12?"PM":"AM").toString(),
                    dropdownItemIdentifier,
                    _issue.text,
                    authToken,
                    userId,
                    widget.hospitalData.id,
                  ).then((onValue) => {
                        alertShow(context, "Appointment Booked", "Successfully",
                            AlertType.success, "Done", true)
                      });
                }
              }
            });
            print("onStepContinue : " + currentStep.toString());
        },
      ),
          )),
    );
  }

  AlertDialog alertDialog(BuildContext context, String s) {
    return AlertDialog(
      title: new Text(s),
      content: Icon(Icons.check_circle),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        new FlatButton(
          child: new Text("Close"),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MyCustomRoute(builder: (context) => HomePage()),
              (Route<dynamic> route) => false,
            );
          },
        ),
      ],
    );
  }
}
