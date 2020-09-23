class FilterOptions{
  Map<int, dynamic> campusFilter;
  Map<int, dynamic> batchYear;
  Map<int, dynamic> SDG;

  List<dynamic> selectedCampusFilterValues;
  List<dynamic> selectedBatchYearFilterValues;
  List<dynamic> selectedSDGFilterValues;


  FilterOptions(){
    campusFilter = Map<int, dynamic>();
    batchYear = Map<int, dynamic>();
    SDG = Map<int, dynamic>();

    selectedCampusFilterValues = List<dynamic>();
    selectedBatchYearFilterValues = List<dynamic>();
    selectedSDGFilterValues = List<dynamic>();
  }
  void clearAvailableFilters(){
    this.campusFilter.clear();
    this.batchYear.clear();
    this.SDG.clear();
  }
}
