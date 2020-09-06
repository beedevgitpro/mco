

import 'package:flutter/material.dart';
import 'package:mco/app/components/appbar.dart';
import 'package:mco/app/components/bottomnavbar.dart';

import 'claimsmodel.dart';

class ClaimDetailPage extends StatelessWidget {
  final GetClaims claims;
  const ClaimDetailPage(this.claims);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: leadingColor,
          // title: Text(policydetail.policyHolderName),
        ),
        bottomNavigationBar: BottomNavBar(activeTabNumber: 2,),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              CLaimRow(
                claims.name,
                "Policy Number:",
              ),
              
              SizedBox(
                height: 20.0,
              ),
              // Text("Beneficiaries ", style: Styles.cardTitleText),
              // SizedBox(
              //   height: 20.0,
              // ),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: <Widget>[
              //     Text("Name:",style: Styles.headlineName,),
              //     Text(
              //       policydetail.policyHolderName,
              //       style: Styles.headlineName,
              //       textAlign: TextAlign.left,
              //     )
              //   ],
              // )
            ],
          ),
        ));
  }
}

class CLaimRow extends StatelessWidget {
  final claimdetail;
  final String constString;
  CLaimRow(this.claimdetail, this.constString);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              constString,
              style: Theme.of(context).textTheme.display1.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0,
                  color: Colors.black38),
            ),
            Text(
              "$claimdetail",
              style: Theme.of(context).textTheme.display1.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0,
                  color: Colors.black38),
            ),
          ]),
    );
  }
}