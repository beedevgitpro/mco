
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// final formats = {
//   // InputType.both: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
//   InputType.date: DateFormat('yyyy-MM-dd'),
//   InputType.time: DateFormat("HH:mm"),
// };

//date time method
// DateTimePickerFormField buildDateTimePickerFormField(
//     TextEditingController inputController,
//     String label,
//     InputType inputType,
//     IconData icon) {
//   return DateTimePickerFormField(
//       inputType: inputType,
//       controller: inputController,
//       format: formats[inputType],
//       editable: false,

//       // decoration:
//       //     InputDecoration(labelText: label, hasFloatingPlaceholder: false),
//       decoration: new InputDecoration(
//           prefixIcon: Icon(icon),
//           border: new OutlineInputBorder(
//             // gapPadding: 10.0,
//             borderRadius: new BorderRadius.circular(5.0),
//             borderSide: new BorderSide(),
//           )));
// }

Widget formTextField(
    TextEditingController variable, String hint, TextInputType inputtype,
    [int maxlines]) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      keyboardType: inputtype,
      
      validator: (value) {
         if (value.isEmpty) {
      return 'Required';
    }
    return null;
      },
    //   onChanged: (value) {
    //      if (value.isEmpty) {
    //   return 'Please enter some text';
    // }
    // return null;},

      controller: variable,
      decoration: new InputDecoration(
        contentPadding: EdgeInsets.all(8),
        hintText: hint,
        enabledBorder:  OutlineInputBorder(
          borderRadius:  BorderRadius.circular(10.0),
          borderSide:  BorderSide(color: Colors.black),
        ),
        focusedBorder:  OutlineInputBorder(
          borderRadius:  BorderRadius.circular(10.0),
          borderSide:  BorderSide(color: Colors.black),
        ),
        errorBorder:  OutlineInputBorder(
          borderRadius:  BorderRadius.circular(10.0),
          borderSide:  BorderSide(color: Colors.red),
        ),
        focusedErrorBorder:  OutlineInputBorder(
          borderRadius:  BorderRadius.circular(10.0),
          borderSide:  BorderSide(color: Colors.red),
        ),
      ),
      maxLines: maxlines == 3 ? 3 : 1,
    ),
  );
}
