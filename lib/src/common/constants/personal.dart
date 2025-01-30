import 'package:sidharth/src/common/model/experience_details.dart';

class KPersonal {
  const KPersonal._();

  static const name = 'Sidharth';
  static const designation = 'Software engineer';
  static const mailId = 'sidharth.rajendran.r@gmail.com';
  static const introduction =
      'Hi, I’m Sidharth, a Flutter developer with 3+ years of experience crafting seamless, high-performing cross-platform apps. Passionate about solving complex problems, building intuitive UIs, and pushing the limits of app performance. Let’s create something amazing together!';
  static final careerStartDate = DateTime(2021, 11);
  static final careerJourney = <ExperienceDetails>[
    ExperienceDetails(
      org: 'Brototype',
      designation: 'Flutter Intern',
      begin: DateTime(2021, 11),
      end: DateTime(2022, 6),
    ),
    ExperienceDetails(
      org: 'White Rabbit',
      designation: 'Trainee software engineer',
      begin: DateTime(2022, 8),
      end: DateTime(2023, 8),
    ),
    ExperienceDetails(
      org: 'White Rabbit',
      designation: 'Software engineer',
      begin: DateTime(2023, 8),
      end: DateTime(2024, 10),
    ),
    ExperienceDetails.present(
      org: 'Mcabee',
      designation: 'Senior Software engineer',
      begin: DateTime(2024, 10),
    ),
  ];

  static final social = [
    const Social(
      label: 'Instagram',
      urlAsString: 'https://www.instagram.com/sidha6th_r/',
    ),
    const Social(
      label: 'Github',
      urlAsString: 'https://github.com/sidha6th',
    ),
    const Social(
      label: 'LinkedIn',
      urlAsString: 'https://www.linkedin.com/in/sidharth-r-9889a3219/',
    ),
    Social(
      label: 'Email',
      urlAsString: Uri(scheme: 'mailto', path: 'sidharth.rajendran.r@gmail.com')
          .toString(),
    ),
  ];
}

class Social {
  const Social({
    required this.label,
    required this.urlAsString,
  });

  final String label;
  final String urlAsString;
}
