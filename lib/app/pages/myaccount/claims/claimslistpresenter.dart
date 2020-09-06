import 'package:flutter/material.dart';
import 'package:mco/app/colors.dart';
import 'package:mco/app/components/appbar.dart';
import 'package:mco/app/components/pagenavigator.dart';
import 'package:mco/app/pages/hospital/hospital_presenter.dart';
import 'package:mco/app/pages/myaccount/claims/claimdetailpage.dart';
import 'package:mco/app/pages/myaccount/claims/claimsmodel.dart';

ListView listViewClaims(List<GetClaims> names, List<GetClaims> filteredNames) {
  print(names[0].approvedAmount);
  return ListView.builder(
    itemCount: names == null ? 0 : filteredNames.length,
    itemBuilder: (BuildContext context, int index) {
      return Card(
        elevation: 8.0,
        child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              padding: EdgeInsets.all(10.0),
              height: MediaQuery.of(context).size.height * 1.5 / 6,
              child: Column(
                children: <Widget>[
                  Align(
                    child: Text(
                      "Claim Settled",
                      style:TextStyle(color: secondaryBoldFontColor,fontWeight: FontWeight.bold),
                    ),
                    alignment: Alignment.topRight,
                  ),
                  Row(children: <Widget>[
                    Text(
                      names[index].name,
                      style: TextStyle(color: secondaryBoldFontColor,fontWeight: FontWeight.bold),
                    ),
                  ]),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Claim Id",),
                        Text("Date of Admission")
                      ],
                    ),
                  ),
                                          SizedBox(height: 5.0,),

                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          names[index].caseId.toString(),
                          style: Styles.searchText,
                        ),
                        Text(
                          names[index].admissionDate,
                          style: Styles.searchText,
                        ),
                      ]),
                  Container(
                    padding: EdgeInsets.only(top: 15.0,bottom: 10.0,),
                    color: Colors.grey[100],
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Claim Amount"),
                            Text("Approved Amount(\$)")
                          ],
                        ),
                        SizedBox(height: 5.0,),

                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                names[index].engagedAmount.toString(),
                                style: Styles.searchText,
                              ),
                              Text(
                                names[index].approvedAmount.toString(),
                                style: Styles.searchText,
                              ),
                            ])
                      ],
                    ),
                  ),
                ],
              ),
            )),
      );
    },
  );
}
