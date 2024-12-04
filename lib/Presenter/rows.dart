class JobPosting {
  String company;
  double companyScore;
  String jobTitle;
  String location;
  Duration date;
  double lowerSalary;
  double upperSalary;



  JobPosting(
      this.company,
      this.companyScore,
      this.jobTitle,
      this.location,
      this.date,
      this.lowerSalary,
      this.upperSalary);
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
}
