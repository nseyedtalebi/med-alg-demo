# Created by nima at 12/3/19
Feature: Simulated patient
  Model of a patient sufficient to answer all the questions in the drowning grading algorithm. Also includes ways of
  randomizing the patient's status and checking whether the randomly-chosen values make sense. Note that we want them
  to *not* make sense at times so we can better test the implementation of the algorithm.

Background:
  Given a patient



  Scenario: We don't know anything about new patients/can't assume anything about new patients
    When the patient is a new patient
    Then we do not know if they are responsive to verbal stimuli
      And we do not know if they are responsive to tactile stimuli
      And we do not know if they were submerged for more or less than an hour
      And we do not know whether pulmonary ascultation produces normal or abnormal results
      And we do not know if rales are present in some or all pulmonary fields
      And we do not know if the patient is hypotensive or in shock
      And we do not know if the patient is breathing
      And we do not know if the patient has a cough
      And we do not know if the patient is dead
      And we do not know which grade the patient should be assigned

  Scenario: What happens when we examine the patient?
    When we examine the patient for something
    Then report the result of that examination
    But not when the examination violates a rule

  Scenario: What happens when we try to do an invalid examination?
    When we attempt an examination that violates a rule
    Then report an error and discard the result



