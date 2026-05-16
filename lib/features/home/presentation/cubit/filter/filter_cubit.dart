import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(FilterInitial());

  List<Map<String, dynamic>> items = [
    {'name': 'Medicine', 'isChecked': false},
    {'name': 'Pharmacy', 'isChecked': true},
    {'name': 'Nursing', 'isChecked': false},
    {'name': 'Anesthesia', 'isChecked': false},
    {'name': 'Physiotherapy', 'isChecked': false},
    {'name': 'Respiratory Care', 'isChecked': false},
    {'name': 'Other', 'isChecked': false},
  ];

  List<Map<String, dynamic>> ratedItems = [
    {'name': 'Top Rated', 'isChecked': false},
    {'name': 'Lowest rated', 'isChecked': true},
  ];



  Future<void>setSelectedCheckBox({int? ind,bool? val})async{
    for (var element in items!) {
      element['isChecked'] = false;
    }
    items[ind!]['isChecked'] = val;
    emit(FilterUpdateItemState());
  }
  Future<void>setSelectedRatedCheckBox({int? ind,bool? val})async{
    for (var element in ratedItems) {
      element['isChecked'] = false;
    }
    ratedItems[ind!]['isChecked'] = val;
    emit(FilterUpdateItemState());
  }
}
