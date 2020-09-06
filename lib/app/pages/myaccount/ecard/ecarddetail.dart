import 'package:flutter/material.dart';
import 'package:mco/app/components/appbar.dart';
import 'package:mco/app/pages/myaccount/ecard/ecardlist.dart';

import 'ecardmodel.dart';

class EcardDetail extends StatefulWidget {
  final McoCardDetail ecardDetail;
  EcardDetail(this.ecardDetail);

  @override
  _EcardDetailState createState() => _EcardDetailState();
}

class _EcardDetailState extends State<EcardDetail> {
  Map cardRows={};
  Widget eCardLayout(context){
      cardRows={"NRIC/Passport No":widget.ecardDetail.nricCode,"Insurer":widget.ecardDetail.insuranceCompanyName,"Policy Number":widget.ecardDetail.policyNo,"Plan Name":widget.ecardDetail.policyName,"Effective From":widget.ecardDetail.coverageStartDate};
      return Column(children:[
      for(var key in cardRows.keys)
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Expanded(flex:2,child: buildText(key,isLarge(context)?16:12)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal:10.0),
              child: buildText(": ",isLarge(context)?16:12),
            ),
            Expanded(flex:3,child: buildText(cardRows[key],isLarge(context)?16:12))
          ],),
          SizedBox(height:5),
        ],
      ),
      ]);
  }
  bool isLarge(context){
    print(MediaQuery.of(context).size.width);
    if(MediaQuery.of(context).size.width>350)
      return true;
    return false;
  }
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("E-Card Details"),
        backgroundColor: leadingColor,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width*0.95,
          height:isLarge(context)? MediaQuery.of(context).size.height * 0.7:MediaQuery.of(context).size.height * 0.9,
          child: Card(
            shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(20) 
            ),
              elevation: 8.0,
              child: ClipRRect(
                             borderRadius: BorderRadius.circular(10),
                              child: RotatedBox(
                    quarterTurns: 1,
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal:isLarge(context)?30:20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                 Container(
                                  alignment: Alignment.centerLeft,
                                  height: isLarge(context)?75.0:65,
                                  width: isLarge(context)?300:250,
                                  decoration: new BoxDecoration(
                                    image: DecorationImage(
                                      image: new AssetImage('lib/app/assets/logo.png'),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                               mainAxisSize:MainAxisSize.min,
                               crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("ABC Malaysia SND BHD",
                                            style: TextStyle(
                                              fontSize: isLarge(context)?16.0:12.0,
                                              fontWeight: FontWeight.w700,
                                            ),),
                                      (widget.ecardDetail.relationshipCheck==1)?
                                        Text(
                                            "${widget.ecardDetail.name} (Principal)",
                                            style: TextStyle(
                                              fontSize: isLarge(context)?16.0:12,
                                              fontWeight: FontWeight.w700,
                                            ),):
                                            (widget.ecardDetail.relationshipCheck==2)?
                                        Text(
                                            "${widget.ecardDetail.name} (Dependent)",
                                            style: TextStyle(
                                              fontSize: isLarge(context)?16.0:12,
                                              fontWeight: FontWeight.w700,
                                            ),):
                                             Text(
                                            "${widget.ecardDetail.name} (Spouse)",
                                            style: TextStyle(
                                              fontSize: isLarge(context)?16.0:12,
                                              fontWeight: FontWeight.w700,
                                            ),),
                              ],
                            ),
                            eCardLayout(context),
                          ],
                        ),
                     
                    )),
              )),
        ),
      ),
    );
  }

  Text buildText(String text,double fontSize) => Text(text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
      ));
}
