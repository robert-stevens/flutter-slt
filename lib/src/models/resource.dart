import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

class Resource {
  String id = UniqueKey().toString();
  String username;
  String title;
  String description;
  String category;
  double rate;
  DateTime dateTime = DateTime.now().subtract(Duration(days: Random().nextInt(20)));

  Resource(this.username, this.title, this.description, this.category);

  getDateTime() {
    return DateFormat('MMM dd, yyyy').format(this.dateTime);
  }
}

class ResourcesList {
  List<Resource> _resourcesList;

  List<Resource> get resourcesList => _resourcesList;

  ResourcesList() {
    _resourcesList = [
      Resource(
          '@MrFallickPE',
          'Highlighter AO1 Paper 1 Revision Task',
          'See my tweets on this task @MrFallickPE',
          'Category',
          ),
      Resource(
          'SMN PE',
          'Components of fitness worksheet',
          'A worksheet for students to: recall which CoF each test measures Identify which sport needs each CoF Explain how to administer each test.',
          'Category',
          ),
      Resource(
          'SMN PE',
          'Muscles worksheet',
          'A worksheet for students to identify and recall a muscles: Antagonist Joint allowing movement Type of movement at joint Bones moving sue to movement Exercise that works muscle in question',
          'Category',
          ),
      Resource(
          'Gary Heart',
          'AQA PAPER 1 RAG SELF ASSESSMENT',
          'Excel RAG sheet with all paper 1 content using AQA resource.',
          'Category',
          ),
      Resource(
          'SLT Support - Steven Phyffer',
          'Sports psychology AS LEVEL PE',
          'sports psychology AS LEVEL PE',
          'Category',
          ),
      Resource(
          '@MrFallickPE',
          'Highlighter AO1 Paper 1 Revision Task',
          'See my tweets on this task @MrFallickPE',
          'Category',
          ),
      Resource(
          'SMN PE',
          'Components of fitness worksheet',
          'A worksheet for students to: recall which CoF each test measures Identify which sport needs each CoF Explain how to administer each test.',
          'Category',
          ),
      Resource(
          'SMN PE',
          'Muscles worksheet',
          'A worksheet for students to identify and recall a muscles: Antagonist Joint allowing movement Type of movement at joint Bones moving sue to movement Exercise that works muscle in question',
          'Category',
          ),
      Resource(
          'Gary Heart',
          'AQA PAPER 1 RAG SELF ASSESSMENT',
          'Excel RAG sheet with all paper 1 content using AQA resource.',
          'Category',
          ),
      Resource(
          'SLT Support - Steven Phyffer',
          'Sports psychology AS LEVEL PE',
          'sports psychology AS LEVEL PE',
          'Category',
          ),
    ];
  }
}
