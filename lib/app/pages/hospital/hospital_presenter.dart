import 'package:flutter/material.dart';
import 'package:mco/app/components/appbar.dart';
import 'package:mco/app/components/pagenavigator.dart';
import 'package:mco/app/models/hospital_model.dart';
import 'package:rounded_letter/rounded_letter.dart';
import 'package:rounded_letter/shape_type.dart';
import '../../colors.dart';
import 'hospital_detail.dart';

ListView listViewHospital(
  
    List<HospitalData> names, List<HospitalData> filteredNames,bool isLarge) {
     
  return ListView.builder(
    itemCount: names == null ? 0 : filteredNames.length,
    itemBuilder: (BuildContext context, int index) {
      return Padding(
        padding: EdgeInsets.only(left:15,right:15,bottom: 5),
              child: Card(
          shape: listItemShape,
          elevation: listElevation,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: new ListTile(
              leading: new LeadingLetter(filteredNames[index].name),
              trailing: Icon(Icons.arrow_right,color: leadingColor,),
              title: Text(filteredNames[index].name,style: listPageTitleStyle),
              subtitle: Row(
                children: <Widget>[
                  Icon(
                    Icons.pin_drop,
                    size: 20.0,color: secondaryFontColor,
                  ),
                  SizedBox(
                    width: 2.0,
                  ),
                  (isLarge?(filteredNames[index].addressLine1).length > 20:(filteredNames[index].addressLine1).length > 14)
                      ? Text(
                          filteredNames[index].addressLine1.substring(0,isLarge?20:14),
                          style: TextStyle(color: secondaryBoldFontColor),
                        )
                      : Text(
                          filteredNames[index].addressLine1,
                         style: TextStyle(color: secondaryBoldFontColor),
                        ),
                ],
              ),
              onTap: () {
                Navigator.push(
                    context,
                    new MyCustomRoute(
                        builder: (BuildContext context) =>
                            new HospitalDetailPage(filteredNames[index])));
              },
            ),
          ),
        ),
      );
    },
  );
}

class LeadingLetter extends StatelessWidget {
  final String name;
  LeadingLetter(this.name);
  @override
  Widget build(BuildContext context) {
    return RoundedLetter(
      text: name.substring(0, 1).toUpperCase(),
      shapeType: ShapeType.circle,
      fontColor: leadingColor,
      shapeColor: circularAvator,
      shapeSize: 40,
      fontSize: 20,
      borderWidth: 2,
      // borderColor: Colors.grey,
    );
  }
}
