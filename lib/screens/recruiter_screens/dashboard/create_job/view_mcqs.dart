import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notech_mobile_app/components/utils/app_size.dart';

import '../../../../components/text/custom_text.dart';
import '../../../../components/utils/app_colors.dart';

class ViewMcqs extends StatefulWidget {
  final String job_id;
  const ViewMcqs({super.key, required this.job_id});

  @override
  State<ViewMcqs> createState() => _ViewMcqsState();
}

class _ViewMcqsState extends State<ViewMcqs> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    AppSize().init(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.blueColor,
          title: CustomText(
            text: 'All Quiz',
            fontColor: AppColors.primaryWhite,
          ),
        ),
        body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(user!.uid)
              .collection('jobs')
              .doc(widget.job_id)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show a loading indicator while fetching data
              return CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              // Handle any errors that occurred
              return Text('Error: ${snapshot.error}');
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              // Handle case when document doesn't exist or there is no data
              return Text('No MCQs found');
            }

            final jobData = snapshot.data!.data() as Map<String, dynamic>?;
            if (jobData != null && jobData['mcqs'] != null) {
              var mcqs = List.from(jobData['mcqs']);

              // Display the MCQs to the user (e.g., using a ListView)
              return ListView.builder(
                itemCount: mcqs.length,
                itemBuilder: (context, index) {
                  final mcq = mcqs[index];
                  final List<String> options =
                      List.from(mcq['options'] as List<dynamic>);

                  return ListTile(
                      title: Text('Question: ${mcq['question']}'),
                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Options:'),
                            Column(
                              children: options.map((option) {
                                return Text(option);
                              }).toList(),
                            ),
                          ]));
                },
              );
            }

            // Return an empty widget if no MCQs are found
            return Text('No MCQs found');
          },
        ),);
  }
}
