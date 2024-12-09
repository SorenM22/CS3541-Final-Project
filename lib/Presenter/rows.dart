class JobPosting {
  String company;
  double companyScore;
  String jobTitle;
  String location;
  Duration date;
  double salary;

  JobPosting(
      this.company,
      this.companyScore,
      this.jobTitle,
      this.location,
      this.date,
      this.salary);

  static fromRow(List<dynamic> csvRow) => JobPosting(csvRow[0],csvRow[1],csvRow[2],csvRow[3],csvRow[4],csvRow[5]);
}

class JobTrend {
  DateTime year;
  String jobTitle;
  String jobCategory;
  double salary;
  String experienceLevel;
  String employmentType;
  String workSetting;
  String location;
  String companySize;

  JobTrend(
      this.year,
      this.jobTitle,
      this.jobCategory,
      this.salary,
      this.experienceLevel,
      this.employmentType,
      this.workSetting,
      this.location,
      this.companySize);

  static fromRow(List<dynamic> csvRow) => JobPosting(csvRow[0],csvRow[1],csvRow[2],csvRow[4],csvRow[5],csvRow[6],csvRow[7]);
}
