class ProjectsData {
  final String title;
  final String description;
  final String url;
  final String thumbnailPath;

  ProjectsData({required this.title, required this.url, required this.thumbnailPath, required this.description});
}

final List<ProjectsData> projectsDataList = [
  ProjectsData(
    title: 'PDF invoice generator',
    description:
        'Flutter-based web application for invoice generation and PDF export. The app leverages the power of Riverpod for state management, along with the pdf and printing packages for creating and exporting invoices seamlessly',
    url: 'https://arjunpshaji.github.io/invoice_builder_pdf/',
    thumbnailPath: 'assets/images/invoice_builder_thumbnail.png',
  ),
  ProjectsData(
    title: 'SimplyDate',
    description:
        'Flutter package designed to simplify date formatting in your Flutter apps! Whether you\'re building a new app or improving an existing one, SimplyDate has you covered with a set of powerful features: Convert dates into human-readable formats Format dates in various styles Add ordinal suffixes Compare dates to check if they are past or future',
    url: 'https://pub.dev/packages/simply_date',
    thumbnailPath: 'assets/images/pub_dev_bg.png',
  ),
];
