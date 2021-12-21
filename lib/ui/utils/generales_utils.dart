import 'package:flutter/material.dart';

Future<DateTime> pickDate(BuildContext context,DateTime pickedDate,DateTime firstDate,DateTime lastDate) async{
  DateTime? date=await showDatePicker(
    context: context, 
    initialDate: pickedDate, 
    firstDate: firstDate,
    lastDate: lastDate,
   // firstDate: DateTime(DateTime.now().year-5), 
    //lastDate: DateTime(DateTime.now().year+5),
    confirmText: "Ok",
    cancelText: "Cancelar",
    //fieldHintText: "Seleccionar fecha",
    //locale: Locale('fr','CH')
    //locale : const Locale("fr","FR").
  ); 
  pickedDate=date!;
  return pickedDate;
}
Future<TimeOfDay> pickTime(context,TimeOfDay? time) async{
    TimeOfDay? date=await showTimePicker(
      context: context,
      initialTime: time!,
      cancelText: "Cancelar"
      confirmText: "Ok",
    );
    return date!;
    /*if(date!=null){ 
      time=date;
      _horaController!.text="${time!.hour.toString().padLeft(2,'0')}:${time!.minute.toString().padLeft(2,'0')}";
    }*/
  }