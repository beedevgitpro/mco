import 'package:flutter/material.dart';
import 'package:mco/app/components/appbar.dart';
import 'package:mco/app/components/pagenavigator.dart';
import 'package:mco/app/models/clinic_model.dart';
import 'package:mco/app/pages/clinic/clinic_details.dart';
import 'package:mco/app/pages/hospital/hospital_presenter.dart';
import 'package:rounded_letter/rounded_letter.dart';

import '../../colors.dart';

ListView listView(List<ClinicData> names, List<ClinicData> filteredNames,bool isLarge) {
  return ListView.builder(
    itemCount: names == null ? 0 : filteredNames.length,
    itemBuilder: (BuildContext context, int index) {
      return Padding(
        padding: EdgeInsets.only(left:15,right:15,bottom: 5),
        child: Card(
          elevation: listElevation,
          shape: listItemShape,
          child: Padding(
              padding: const EdgeInsets.all(5.0),
            child: new ListTile(
                  // leading: RoundedLetter.withBlueCircle(filteredNames[index].name.substring(0,1).toUpperCase(), 40, 20),
leading: new LeadingLetter(filteredNames[index].name),

              trailing: Icon(Icons.arrow_right,color: leadingColor,),
              title: Text(filteredNames[index].name,style: listPageTitleStyle),
              subtitle: Row(
                children: <Widget>[
                  Icon(
                    Icons.pin_drop,color: secondaryFontColor,
                    size: 15.0,
                  ),
                  SizedBox(
                    width: 1.0,
                  ),
                  (isLarge?(filteredNames[index].addressLine1).length > 20:(filteredNames[index].addressLine1).length > 14)
                      ? Text(filteredNames[index].addressLine1.substring(0, isLarge?20:14),style: TextStyle(color: secondaryFontColor),)
                      : Text(filteredNames[index].addressLine1,style: TextStyle(color: secondaryFontColor),),
                ],
              ),
              onTap: () {
                Navigator.push(
                    context,
                    new MyCustomRoute(
                        builder: (BuildContext context) =>
                            new ClinicDetailsPage(filteredNames[index])));
              },
            ),
          ),
        ),
      );
    },
  );
}
