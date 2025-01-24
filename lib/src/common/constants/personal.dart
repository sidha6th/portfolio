import 'package:sidharth/src/common/model/experience_details.dart';

class KPersonal {
  const KPersonal._();

  static const name = 'Sidharth';
  static const designation = 'Software engineer';
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
}
