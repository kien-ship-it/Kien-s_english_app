import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:survey_kit/survey_kit.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SurveyKit(
        task: NavigableTask(
          id: TaskIdentifier(),
          steps: [
            InstructionStep(
              title: 'Welcome to the\nQuickBird Studios\nHealth Survey',
              text: 'Get ready for a bunch of super random questions!',
              buttonText: 'Let\'s go!',
            ),
            QuestionStep(
              title: 'How old are you?',
              answerFormat: const IntegerAnswerFormat(
                defaultValue: 25,
                hint: 'Please enter your age',
              ),
              isOptional: true,
            ),
            QuestionStep(
              title: 'Medication?',
              text: 'Are you using any medication',
              answerFormat: const BooleanAnswerFormat(
                positiveAnswer: 'Yes',
                negativeAnswer: 'No',
                result: BooleanResult.POSITIVE,
              ),
            ),
            QuestionStep(
              title: 'Tell us about you',
              text:
                  'Tell us about yourself and why you want to improve your health.',
              answerFormat: const TextAnswerFormat(
                maxLines: 5,
                validationRegEx: r'^(?!\s*\$).+',
              ),
            ),
            QuestionStep(
              title: 'Select your body type',
              answerFormat: const ScaleAnswerFormat(
                step: 1,
                minimumValue: 1,
                maximumValue: 5,
                defaultValue: 3,
                minimumValueDescription: '1',
                maximumValueDescription: '5',
              ),
            ),
            QuestionStep(
              title: 'Known allergies',
              text: 'Do you have any allergies that we should be aware of?',
              isOptional: false,
              answerFormat: const MultipleChoiceAnswerFormat(
                textChoices: <TextChoice>[
                  TextChoice(text: 'Penicillin', value: 'Penicillin'),
                  TextChoice(text: 'Latex', value: 'Latex'),
                  TextChoice(text: 'Pet', value: 'Pet'),
                  TextChoice(text: 'Pollen', value: 'Pollen'),
                ],
              ),
            ),
            QuestionStep(
              title: 'Done?',
              text: 'We are done, do you mind to tell us more about yourself?',
              isOptional: true,
              answerFormat: const SingleChoiceAnswerFormat(
                textChoices: <TextChoice>[
                  TextChoice(text: 'Yes', value: 'Yes'),
                  TextChoice(text: 'No', value: 'No'),
                ],
                defaultSelection: TextChoice(text: 'No', value: 'No'),
              ),
            ),
            QuestionStep(
              title: 'When did you wake up?',
              answerFormat: const TimeAnswerFormat(
                defaultValue: TimeOfDay(
                  hour: 12,
                  minute: 0,
                ),
              ),
            ),
            QuestionStep(
              title: 'When was your last holiday?',
              answerFormat: DateAnswerFormat(
                minDate: DateTime.utc(1970),
                defaultDate: DateTime.now(),
                maxDate: DateTime.now(),
              ),
            ),
            QuestionStep(
              title: 'Upload a image of you',
              answerFormat: const ImageAnswerFormat(
                buttonText: 'Upload your photo',
                useGallery: true,
              ),
            ),
            CompletionStep(
              stepIdentifier: StepIdentifier(id: '321'),
              text: 'Thanks for taking the survey, we will contact you soon!',
              title: 'Done!',
              buttonText: 'Submit survey',
            ),
          ],
        ),
        onResult: (SurveyResult result) {
          Navigator.pop(context);
        },
      ),
    ));
  }
}
