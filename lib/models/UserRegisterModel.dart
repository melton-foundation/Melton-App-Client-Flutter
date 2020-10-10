class UserRegisterModel {
  String email;
  String name;
  String campus;
  int batch;
  String work;
  List<int> SDGs;

  UserRegisterModel(String email, String name, String campus, int batch,
      String work, List<int> SDGs) {
    this.email = email;
    this.name = name;
    this.campus = campus;
    this.batch = batch;
    this.work = work;
    this.SDGs = SDGs;
  }

  UserRegisterModel.getDefaultModel() {
    this.campus = "AU / Accra";
    this.batch = 1991;
    this.work = "I'm a Melton Fellow!";
    this.SDGs = [1, 2, 3];
  }


  Map<String, dynamic> toJson(UserRegisterModel model) {
    return {
      "user": {
        "email": model.email
      },
      "name": model.name,
      "campus": model.campus,
      "batch": model.batch,
      "work": model.work,
      "sdgs": model.SDGs,
    };
  }
}
