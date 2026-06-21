import 'package:evently_app/core/utils/app_assets.dart';
import 'package:evently_app/core/utils/app_colors.dart';
import 'package:evently_app/core/utils/app_style.dart';
import 'package:evently_app/core/extensions/context_extensions.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../providers/event_list_provider.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  int selectedIndex = 0;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  var formKey = GlobalKey<FormState>();
  String selectedEventName = '';
  bool isLoading = false;

  ///to store in firestore
  String selectedEventImage = '';

  ///to store in firestore
  String selectedEventDate = '';

  ///to store in firestore
  String selectedEventTime = '';

  ///to store in firestore
  String title = '';

  ///to store in firestore
  String description = '';

  ///to store in firestore

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = context.height;
    final width = context.width;

    final List<String> eventCategories = [
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.sports,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.exhibition,
    ];

    late List<String> categoryImages = [
      AppAssets.getBookClubImage(context),
      AppAssets.getSportImage(context),
      AppAssets.getBirtDayImage(context),
      AppAssets.getMeetingImage(context),
      AppAssets.getExhibitionImage(context),
    ];


    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.add_event,
          style: AppStyles.medium16Main,
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.main, width: 1),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.main,
                size: 18,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  categoryImages[selectedIndex],
                  height: height * 0.22,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                    AppAssets.birthday,
                    height: height * 0.22,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),

               SizedBox(
                 height: 45,
                 child: ListView.separated(
                   scrollDirection: Axis.horizontal,
                   itemBuilder: (context, index) => GestureDetector(
                     onTap: () => setState(() => selectedIndex = index),
                     child: Container(
                       padding: const EdgeInsets.symmetric(horizontal: 16),
                       decoration: BoxDecoration(
                         color: selectedIndex == index
                             ? AppColors.main
                             : Colors.transparent,
                         borderRadius: BorderRadius.circular(24),
                         border: Border.all(color: AppColors.main),
                       ),
                       child: Row(
                         children: [
                           Icon(
                             Icons.category,
                             color: selectedIndex == index
                                 ? AppColors.white
                                 : AppColors.main,
                           ),
                           const SizedBox(width: 8),
                           Text(
                             eventCategories[index],
                             style: selectedIndex == index
                                 ? AppStyles.medium16White
                                 : AppStyles.medium16Main,
                           ),
                         ],
                       ),
                     ),
                   ),
                   separatorBuilder: (context, index) =>
                       const SizedBox(width: 10),
                   itemCount: eventCategories.length,
                 ),
               ),

              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.title,
                style: AppStyles.medium16Black,
              ),
              const SizedBox(height: 8),
              TextFormField(
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please enter a title';
                  } else {
                    return null;
                  }
                },
                controller: titleController,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.event_title,
                  prefixIcon: const Icon(Icons.edit_note),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.description,
                style: AppStyles.medium16Black,
              ),
              const SizedBox(height: 8),
              TextFormField(
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please enter a description';
                  } else {
                    return null;
                  }
                },
                controller: descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(
                    context,
                  )!.event_description_hint,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              buildPickerRow(
                icon: Icons.calendar_month_outlined,
                label: AppLocalizations.of(context)!.event_date,
                value: selectedDate == null
                    ? AppLocalizations.of(context)!.choose_date
                    : DateFormat('dd/MM/yyyy').format(selectedDate!),
                onTap: () async {
                  DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (date != null) setState(() => selectedDate = date);
                },
              ),
              buildPickerRow(
                icon: Icons.access_time,
                label: AppLocalizations.of(context)!.event_time,
                value: selectedTime == null
                    ? "Choose time"
                    : selectedTime!.format(context),
                onTap: () async {
                  TimeOfDay? time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (time != null) setState(() => selectedTime = time);
                },
              ),

               const SizedBox(height: 24),
               ElevatedButton(
                 style: ElevatedButton.styleFrom(
                   backgroundColor: AppColors.main,
                   minimumSize: Size(width, 55),
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(16),
                   ),
                 ),
                 onPressed: isLoading 
                   ? null 
                   : () => _submitEvent(context, eventCategories),
                 child: isLoading
                     ? SizedBox(
                         height: 24,
                         width: 24,
                         child: CircularProgressIndicator(
                           valueColor: AlwaysStoppedAnimation<Color>(
                             AppColors.white,
                           ),
                           strokeWidth: 2,
                         ),
                       )
                     : Text(
                         AppLocalizations.of(context)!.add_event,
                         style: AppStyles.regular18White,
                       ),
               ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPickerRow({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return Row(
      children: [
        Icon(icon, color: AppColors.mainText),
        const SizedBox(width: 8),
        Text(label, style: AppStyles.medium16Black),
        const Spacer(),
        TextButton(
          onPressed: onTap,
          child: Text(value, style: AppStyles.medium16Main),
        ),
      ],
    );
  }

  Future<void> _submitEvent(BuildContext context, List<String> eventCategories) async {
    if (isLoading) return;
    
    if (formKey.currentState!.validate() != true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required fields'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a date'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    if (selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a time'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      // Get the current user from Firebase Auth
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please sign in first'),
              backgroundColor: Colors.red,
            ),
          );
        }
        setState(() => isLoading = false);
        return;
      }

      // Create event object
      final event = Event(
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        category: eventCategories[selectedIndex],
        date: selectedDate!,
        time: selectedTime!,
        userId: currentUser.uid,
      );

      // Get the EventListProvider and add the event
      if (mounted) {
        final eventProvider = Provider.of<EventListProvider>(context, listen: false);
        final success = await eventProvider.addEvent(event);

        setState(() => isLoading = false);

        if (success) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Event added successfully!'),
                backgroundColor: Colors.green,
              ),
            );
            // Clear controllers
            titleController.clear();
            descriptionController.clear();
            selectedDate = null;
            selectedTime = null;
            selectedIndex = 0;
            setState(() {});

            // Navigate back after a short delay
            Future.delayed(const Duration(milliseconds: 800), () {
              if (mounted) Navigator.pop(context);
            });
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  eventProvider.error ?? 'Failed to add event. Please try again.',
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      }
    } catch (e) {
      setState(() => isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
