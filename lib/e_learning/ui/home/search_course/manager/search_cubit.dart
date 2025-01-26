

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instant1/e_learning/ui/home/search_course/manager/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

}
