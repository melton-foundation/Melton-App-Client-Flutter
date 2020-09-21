class UserFilterAvailableOptions{
  Map<int, dynamic> campusFilter;
  Map<int, dynamic> batchYear;
  Map<int, dynamic> SDG;

  UserFilterAvailableOptions(){
    campusFilter = Map<int, dynamic>();
    batchYear = Map<int, dynamic>();
    SDG = Map<int, dynamic>();
  }
  void clearFilters(){
    this.campusFilter.clear();
    this.batchYear.clear();
    this.SDG.clear();
  }

  Map<int, dynamic> getCampusFilter(){
    return campusFilter;
  }

  Map<int, dynamic> getBatchYear(){
    return batchYear;
  }

  Map<int, dynamic> getSDG(){
    return SDG;
  }

}
