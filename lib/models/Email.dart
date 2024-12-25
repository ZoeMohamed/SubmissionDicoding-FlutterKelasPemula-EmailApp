
class Email {
  final String image, name, subject, body;
  final DateTime time;
  final bool isAttachmentAvailable, isChecked;

  Email({
    required this.time,
    required this.isChecked,
    required this.image,
    required this.name,
    required this.subject,
    required this.body,
    required this.isAttachmentAvailable,
  });

  String get formattedDate {
    return '${time.year}-${time.month.toString().padLeft(2, '0')}-${time.day.toString().padLeft(2, '0')}';
  }
}

List<Email> emails = List.generate(
  demo_data.length,
  (index) => Email(
    name: demo_data[index]['name'],
    image: demo_data[index]['image'],
    subject: demo_data[index]['subject'],
    isAttachmentAvailable: demo_data[index]['isAttachmentAvailable'],
    isChecked: demo_data[index]['isChecked'],
    time: demo_data[index]['time'], 
    body: demo_data[index]['body'],
  ),
);

List demo_data = [
  {
    "name": "Budi Santoso",
    "image": "assets/images/user_1.png",
    "subject": "Meeting Reminder: Project Kickoff",
    "isAttachmentAvailable": false,
    "isChecked": true,
    "time": DateTime.now().subtract(Duration(minutes: 5)), // 5 minutes ago
    "body":
        "Hi Team,\n\nThis is a reminder for our project kickoff meeting scheduled for tomorrow at 10 AM. Please be prepared with your updates.\n\nBest,\nBudi"
  },
  {
    "name": "Siti Aminah",
    "image": "assets/images/user_2.png",
    "subject": "New Design Proposal",
    "isAttachmentAvailable": true,
    "isChecked": false,
    "time": DateTime.now()
        .subtract(Duration(hours: 1, minutes: 15)), // 1 hour 15 minutes ago
    "body":
        "Dear Budi,\n\nI have attached the new design proposal for your review. Let me know your thoughts.\n\nThanks,\nSiti"
  },
  {
    "name": "Ahmad Hidayat",
    "image": "assets/images/user_3.png",
    "subject": "Follow-up on Marketing Strategy",
    "isAttachmentAvailable": true,
    "isChecked": false,
    "time": DateTime.now()
        .subtract(Duration(hours: 2, minutes: 30)), // 2 hours 30 minutes ago
    "body":
        "Hi Team,\n\nJust following up on our last discussion regarding the marketing strategy. Please find the attached document for your reference.\n\nBest,\nAhmad"
  },
  {
    "name": "Dewi Ratnasari",
    "image": "assets/images/user_4.png",
    "subject": "Feedback on Your Presentation",
    "isAttachmentAvailable": false,
    "isChecked": true,
    "time": DateTime.now()
        .subtract(Duration(hours: 3, minutes: 45)), // 3 hours 45 minutes ago
    "body":
        "Hello Budi,\n\nI wanted to share my feedback on your presentation. Overall, it was great! I have a few suggestions that I would like to discuss.\n\nRegards,\nDewi"
  },
  {
    "name": "Eko Priyanto",
    "image": "assets/images/user_5.png",
    "subject": "Job Opportunity: Software Developer",
    "isAttachmentAvailable": false,
    "isChecked": false,
    "time": DateTime.now()
        .subtract(Duration(hours: 4, minutes: 20)), // 4 hours 20 minutes ago
    "body":
        "Hi Everyone,\n\nWe have an exciting job opportunity for a Software Developer position. If you know anyone who might be interested, please share this email.\n\nThanks,\nEko"
  }
];

String emailDemoText =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque euismod hendrerit sapien, in dapibus magna. Praesent tincidunt, metus vel fermentum tincidunt, sapien lacus viverra justo, vitae efficitur nulla est sed risus. Lorem ipsum dolor sit amet, consectetur adipiscing elit.";
