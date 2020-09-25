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
  void clearUncheckedFilters() {
    this.campusFilter.clear();
    addAlreadySelectedOptions(this.selectedCampusFilterValues, this.campusFilter);

    this.batchYear.clear();
    addAlreadySelectedOptions(this.selectedBatchYearFilterValues, this.batchYear);

    this.SDG.clear();
    addAlreadySelectedOptions(this.selectedSDGFilterValues, this.SDG);

  }

  void addAlreadySelectedOptions(List<dynamic> selectedFilterValues,
      Map<int, dynamic> filter) {
    for (dynamic filterOption in selectedFilterValues) {
      if (!filter.containsValue(filterOption)) {
        filter.addAll({filter.length: filterOption});
      }
    }
  }
}
