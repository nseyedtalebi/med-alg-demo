# Created by nima at 12/4/19
Feature: Simulated doctor
  Simulates a doctor in a very limited way. The doctor can examine a patient and follow the drowning algorithm
  described in https://www.ncbi.nlm.nih.gov/pubmed/27035042?dopt=Abstract. The doctor can remember the results
  of a finite number of previous patients, along with the ordering and results of the tests performed. They can
  also make some basic inferences based on their (extremely limited) medical knowledge, encoded as scenarios or
  examples. Currently, the doctor cannot provide any treatments.

  Background:
    Given a doctor
    And a patient

  Scenario: A doctor can examine a patient
    When the doctor examines the patient
    Then an examination result is produced
    But not when the examination is invalid for the patient

  Scenario: A doctor can follow the drowning algorithm
    When the doctor is presented with the patient
    Then they can perform examinations in the order specified by the drowning algorithm

  Scenario: A doctor can perform the examinations in a random order
    When the doctor is presented with the patient
    Then they can perform examinations in a random order

  Scenario: A doctor will continue to perform examinations until a grade is assigned
    Given the patient does not have a grade assigned
    When the doctor is presented with the patient
    Then they will perform each type of exam they know
    And the exams will be done in order
    And the order can be dictated by the drowning algorithm
    And the order can be randomly chosen
    But each examination should be performed at most once

  Scenario: A doctor can remember patients and their examination results in order
    When the doctor examines any patient
    Then they will remember the result of the examination
    And the order they performed the examinations
    And the grade they assigned
    But not if they have seen too many patients to remember

  Scenario: What happens when a doctor has seen too many patients to remember
    When the doctor has seen too many patients to remember
    Then they will forget the earliest patient they remember
    And remember the new patient

  Scenario: Doctor won't try to grade a patient he's already graded
    Given the doctor remembers the patient
    And the doctor assigned a grade to the patient
    When the doctor is asked to examine the patient
    Then the doctor should not examine the patient
    And the doctor should report that the patient has already been graded
    But that shouldn't stop them from examining other patients

  Scenario: Random starting step
    When given a random step from the algorithm
    Then the doctor can start from that step
    And follow the algorithm until it terminates
    But possibly assign an incorrect grade

  #The drowning algorithm
  #See https://www.ncbi.nlm.nih.gov/pubmed/27035042?dopt=Abstract for the paper that contains the algorithm
  Scenario Outline: Assign a grade using the algorithm
    Given a patient
    When the patient <resp?> responsive
    And <pulse?> have a pulse
    And was submerged for <submerged?> an hour
    And has a(n) <pulm ascult> pulmonary ascultation result
    And there are rales in <rales?> pulmonary fields
    And <hypo?> hypotensive/in shock
    And <cough?> a cough
    And <dead?> obvious signs of physical death
    Then assign a grade of <grade>
    #In some cases the value "doesn't matter" because of a choice made earlier in the decision tree
    #The answers to questions we don't care about or can safely assume (responsive patients ain't dead!)
    Examples:
      | resp?            | pulse?           | submerged?       | pulm ascult      | rales?           | hypo?            | cough?           | dead?            | grade
      | is not           | does             | (doesn't matter) | (doesn't matter) | (doesn't matter) | (doesn't matter) | (doesn't matter) | no               | 5
      | is not           | does not         | less than        | (doesn't matter) | (doesn't matter) | (doesn't matter) | (doesn't matter) | no               | 6
      | is not           | does not         | more than        | (doesn't matter) | (doesn't matter) | (doesn't matter) | (doesn't matter) | (doesn't matter) | dead
      | is               | does             | (doesn't matter) | normal           | (doesn't matter) | (doesn't matter) | does not have    | no               | rescued
      | is               | does             | (doesn't matter) | normal           | (doesn't matter) | (doesn't matter) | has              | no               | 1
      | is               | does             | (doesn't matter) | abnormal         | some             | (doesn't matter) | does not have    | no               | 2
      | is               | does             | (doesn't matter) | abnormal         | all              | is               | (doesn't matter) | no               | 4
      | is               | does             | (doesn't matter) | abnormal         | all              | is not           | (doesn't matter) | no               | 3
      | (doesn't matter) | (doesn't matter) | (doesn't matter) | (doesn't matter) | (doesn't matter) | (doesn't matter) | (doesn't matter) | yes              | dead

  #Rules representing things the doctor knows or can infer
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

    Scenario: The outcome of pulmonary ascultation can either be normal or abnormal
      Given the patient is breathing
      When pulmonary ascultation is performed
      Then the result will be normal or abnormal

    Scenario: Patient must be breathing for pulmonary ascultation to be useful
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

