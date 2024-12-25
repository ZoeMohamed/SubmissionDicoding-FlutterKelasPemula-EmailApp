import 'package:flutter/material.dart';
import 'package:submission_dicoding/email/email_screen.dart';
import 'package:submission_dicoding/models/email.dart';
import 'package:submission_dicoding/responsive.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../../../../constants.dart';
import 'email_card.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

class ListOfEmails extends StatefulWidget {
  final Function(Email) onEmailSelected; // Callback for email selection

  const ListOfEmails({super.key, required this.onEmailSelected});

  @override
  _ListOfEmailsState createState() => _ListOfEmailsState();
}

class _ListOfEmailsState extends State<ListOfEmails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  int? activeEmailIndex; // Track the active email index

  List<Email> _filteredEmails = emails;
  bool _filterAttachments = false;
  bool _filterUnread = false;
  String _selectedSortOption = "Ascending";

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterEmails);
  }

  void _filterEmails() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredEmails = emails.where((email) {
        final matchesSearch = email.subject.toLowerCase().contains(query) ||
            email.body.toLowerCase().contains(query) ||
            email.name.toLowerCase().contains(query);
        final matchesAttachment =
            !_filterAttachments || email.isAttachmentAvailable;
        final matchesUnread = !_filterUnread || !email.isChecked;

        return matchesSearch && matchesAttachment && matchesUnread;
      }).toList();
    });
    _sortEmails();
  }

  void _sortEmails() {
    setState(() {
      _filteredEmails.sort((a, b) {
        return _selectedSortOption == "Ascending"
            ? a.time.compareTo(b.time)
            : b.time.compareTo(a.time);
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        padding: const EdgeInsets.only(top: kIsWeb ? kDefaultPadding : 0),
        color: kBgDarkColor,
        child: SafeArea(
          right: false,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding, vertical: kDefaultPadding - 7),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: WebsafeSvg.asset(
                          "assets/Icons/Search.svg",
                          width: 20,
                          colorFilter: const ColorFilter.mode(
                              Colors.grey, BlendMode.srcIn),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: kDefaultPadding),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Filter:",
                          style: TextStyle(fontSize: 14, color: kTextColor),
                        ),
                        const SizedBox(width: 5),
                        DropdownButton<String>(
                          value: _filterAttachments
                              ? "Attachments"
                              : (_filterUnread ? "Unread" : "All"),
                          items: const [
                            DropdownMenuItem(
                              value: "All",
                              child: Text("All",
                                  style: TextStyle(color: kTextColor)),
                            ),
                            DropdownMenuItem(
                              value: "Attachments",
                              child: Text("Attachments",
                                  style: TextStyle(color: kTextColor)),
                            ),
                            DropdownMenuItem(
                              value: "Unread",
                              child: Text("Unread",
                                  style: TextStyle(color: kTextColor)),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              if (value == "Attachments") {
                                _filterAttachments = true;
                                _filterUnread = false;
                              } else if (value == "Unread") {
                                _filterUnread = true;
                                _filterAttachments = false;
                              } else {
                                _filterAttachments = false;
                                _filterUnread = false;
                              }
                              _filterEmails();
                            });
                          },
                          dropdownColor: kBgDarkColor,
                          underline: Container(),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "Sort by Date:",
                          style: TextStyle(fontSize: 14, color: kTextColor),
                        ),
                        const SizedBox(width: 5),
                        DropdownButton<String>(
                          value: _selectedSortOption,
                          items: const [
                            DropdownMenuItem(
                              value: "Ascending",
                              child: Text("Ascending",
                                  style: TextStyle(color: kTextColor)),
                            ),
                            DropdownMenuItem(
                              value: "Descending",
                              child: Text("Descending",
                                  style: TextStyle(color: kTextColor)),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedSortOption = value!;
                              _sortEmails();
                            });
                          },
                          dropdownColor: kBgDarkColor,
                          underline: Container(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: kDefaultPadding),
              Expanded(
                child: _filteredEmails.isEmpty
                    ? const Center(child: Text("No emails found"))
                    : ListView.builder(
                        itemCount: _filteredEmails.length,
                        itemBuilder: (context, index) => EmailCard(
                          isActive: activeEmailIndex == index,
                          email: _filteredEmails[index],
                          press: () {
                            if (Responsive.isMobile(context)) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EmailScreen(
                                      email: _filteredEmails[index]),
                                ),
                              );
                            } else {
                              setState(() {
                                activeEmailIndex = index;
                              });
                              widget.onEmailSelected(_filteredEmails[index]);
                            }
                          },
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
