import 'package:sidharth/gen/assets.gen.dart';
import 'package:sidharth/src/common/model/experience_details.dart';

class KPersonal {
  const KPersonal._();

  static const name = 'Sidharth';
  static const designation = 'Software engineer';
  static const mailId = 'sidharth.rajendran.r@gmail.com';
  static const introduction =
      'Hi, I’m Sidharth — a Flutter and native Android developer with 3+ years of experience crafting fast, intuitive, and high-performance mobile apps. I thrive on solving tough problems, designing smooth user experiences, and pushing the limits of what apps can do. \nLet’s build something awesome together!';
  static const skillsDescription =
      'Every project, every challenge, and every solution—these are the tools that have shaped my journey as a developer.';
  static final careerStartDate = DateTime(2021, 11);
  static final milestoneStartDates = careerJourney.map((e) => e.begin).toSet();
  static final careerJourney = <ExperienceDetails>[
    ExperienceDetails(
      org: 'Brototype',
      designation: 'Flutter Intern',
      begin: DateTime(2021, 11),
      end: DateTime(2022, 8),
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
    const Social(label: 'Github', urlAsString: 'https://github.com/sidha6th'),
    const Social(
      label: 'LinkedIn',
      urlAsString: 'https://www.linkedin.com/in/sidharth-r-9889a3219/',
    ),
    Social(
      label: 'Email',
      urlAsString: Uri(scheme: 'mailto', path: mailId).toString(),
    ),
  ];

  static final skillsSets = [
    [
      Assets.images.png.flutter,
      Assets.images.png.dart,
      Assets.images.png.js,
      Assets.images.png.ts,
      Assets.images.png.kotlin,
      Assets.images.png.jetpackCompose,
      Assets.images.png.git,
    ],
    [
      Assets.images.png.html,
      Assets.images.png.css,
      Assets.images.png.scss,
      Assets.images.png.react,
      Assets.images.png.nodejs,
      Assets.images.png.unity,
      Assets.images.png.swift,
    ],
  ];
}

class Social {
  const Social({required this.label, required this.urlAsString});

  final String label;
  final String urlAsString;
}
