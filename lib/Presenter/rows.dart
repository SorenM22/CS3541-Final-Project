class JobPosting {
  String _company;
  double _companyScore;
  String _jobTitle;
  String _location;
  Duration _date;
  double _salary;

  String get company => _company;
  double get companyScore => _companyScore;
  String get jobTitle => _jobTitle;
  String get location => _location;
  Duration get date => _date;
  double get salary => _salary;

  JobPosting(
      this._company,
      this._companyScore,
      this._jobTitle,
      this._location,
      this._date,
      this._salary);

  static fromRow(List<dynamic> csvRow) => JobPosting(csvRow[0],csvRow[1],csvRow[2],csvRow[3],csvRow[4],csvRow[5]);
}

class JobTrend {
  DateTime get year => _year;
  String get jobTitle => _jobTitle;
  String get jobCategory => _jobCategory;
  double get salary => _salary;
  String get experienceLevel => _experienceLevel;
  String get employmentType => _employmentType;
  String get workSetting => _workSetting;
  String get location => _location;
  String get companySize => _companySize;

  DateTime _year;
  String _jobTitle;
  String _jobCategory;
  double _salary;
  String _experienceLevel;
  String _employmentType;
  String _workSetting;
  String _location;
  String _companySize;

  JobTrend(
      this._year,
      this._jobTitle,
      this._jobCategory,
      this._salary,
      this._experienceLevel,
      this._employmentType,
      this._workSetting,
      this._location,
      this._companySize);

  static fromRow(List<dynamic> csvRow) => JobPosting(csvRow[0],csvRow[1],csvRow[2],csvRow[4],csvRow[5],csvRow[6],);
}
