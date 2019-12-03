# Created by nima at 12/3/19
Feature: Simulated patient
  Model of a patient sufficient to answer all the questions in the drowning grading algorithm. Also includes ways of
  randomizing the patient's status and checking whether the randomly-chosen values make sense. Note that we want them
  to *not* make sense at times so we can better test the implementation of the algorithm.

Background:
  Given a patient

  Rule: Dead patients have no pulse
    Scenario: Dead patients have no pulse
    Given the patient is dead
    When the patient is checked for a pulse
    Then the result should be negative

  Rule: A Patient is responsive if and only if they have a pulse
    Scenario: (<-) If a patient has a pulse, then they are responsive
      Given the patient has a pulse
      When checked for responsiveness
      Then the patient should be responsive
    Scenario: (->) If a patient is responsive, then they have a pulse
     Given the patient has a pulse
     When checked for a pulse
     Then the result should be positive

  Scenario: If a Patient is breathing then they have a pulse
    Given the patient is breathing
    When checked for a pulse
    Then the result should be positive

  Rule: Pulmonary ascultation is possible only if the patient is breathing
    Scenario: Pulmonary ascultation is possible only if the patient is breathing
      Given the patient is breathing
      When pulmonary ascultation is attempted
      Then the result is either normal or abnormal

  Rule: The outcome of pulmonary ascultation can either be normal or abnormal
    Scenario: Successful pulmonary ascultation
      Given the patient is breathing
      When pulmonary ascultation is performed
      Then the result will be normal or abnormal

  Scenario: Patient must be breathing for pulmonary ascultation
    Given the patient is not breathing
    When pulmonary ascultation is performed
    Then report an error and ignore the result

  Scenario: A pulmonary ascultation is abnormal if the patient has rales in some or all pulmonary fields
    Given the patient has rales in any pulmonary field(s)
    When pulmonary ascultation is performed
    Then report that the result is abnormal

  Scenario: A patient without a pulse has hypotension
    Given the patient has no pulse
    When the patient's blood pressure is checked
    Then report that the patient has hypotension

  Rule: Patients can only be tested/examined/queried in the ways described herein
  Rule: We don't know anything about new patients/can't assume anything about new patients
  Rule: Our simulated patients do not change state - they represent snapshots of the real world at a particular
  (if hypothetical) point in time
