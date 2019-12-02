# Created by nima at 12/2/19
Feature: Classify patient
  Classify or grade a drowning victim based on an algorithm from a journal article "Prevention and Treatment of Drowning"
  (See https://www.ncbi.nlm.nih.gov/pubmed/27035042?dopt=Abstract)

  Scenario: Unresponsive patient (verbal)
    Given a patient
    When the patient is unresponsive to verbal stimuli
    Then proceed to airway check

  Scenario: Unresponsive patient (tactile)
    Given a patient
    When the patient is unresponsive to tactile stimuli
    Then proceed to airway check

  Scenario: Airway Check (is breathing)
    Given a patient
    And that patient is unresponsive
    When that patient is breathing
    Then perform pulmonary ascultation

  Scenario: Airway Check (not breathing)
    Given a patient
    And that patient is unresponsive
    When that patient is not breathing
    Then give five initial breaths
    And check carotid pulse

  Scenario: Check carotid pulse (absent)
    Given a patient
    And that patient is unresponsive
    And that patient is not breathing
    When that patient does not have a carotid pulse
    Then check time submerged
    And check for physical signs of death

  Scenario: Check carotid pulse (present)
    Given a patient who is unresponsive
    And not breathing
    When the patient has a carotid pulse
    Then assign patient a grade of 5

  Scenario: Check time submerged (up to and including an hour)
    Given a patient
    And that patient is unresponsive
    And that patient is not breathing
    And that patient has no carotid pulse
    When that patient was submerged for less than one hour
    And there is no obvious physical evidence of death
    Then assign that patient a grade of 6

  Scenario: Check time submerged (more than an hour)
    Given a patient
    And that patient is unresponsive
    And that patient is not breathing
    And that patient has no carotid pulse
    When that patient was submerged for more than one hour
    Then assume that patient is dead

  Scenario: Pulmonary ascultation (normal)
    Given a patient
    And that patient is breathing
    When the results of pulmonary ascultation are normal
    Then check for cough

  Scenario: Check for cough (present)
    Given a patient
    And the patient is breathing
    And the results of pulmonary ascultation are normal
    When the patient has a cough
    Then assign the patient a grade of 1

  Scenario: Check for cough (absent)
    Given a patient
    And the patient is breathing
    And the results of pulmonary ascultation are normal
    When the patient does not have a cough
    Then the patient is considered to have been rescued before drowning

  Scenario: Pulmonary ascultation (abnormal)
    Given a patient
    And that patient is breathing
    When the results of pulmonary ascultation are abnormal
    Then check for rales in pulmonary fields

  Scenario: Check for rales (in some pulmonary fields)
    Given a patient
    And that patient is breathing
    And pulmonary ascultation of that patient is abnormal
    When rales are present in some pulmonary fields
    But not all pulmonary fields
    Then assign that patient a grade of 2

  Scenario: Check for rales (in all pulmonary fields)
    Given a patient
    And that patient is breathing
    And pulmonary ascultation of that patient is abnormal
    When rales are present in all pulmonary fields
    Then check for hyoptension
    And check for shock

  Scenario: Check for shock or hypotension (either present)
    Given a patient
    And that patient is breathing
    And pulmonary ascultation of that patient is abnormal
    And rales are present in all pulmonary fields of that patient
    When the patient is in shock
    Then assign the patient a grade of 4
    When the patient is hypotensive
    Then assign the patient a grade of 4

  Scenario: Check for shock or hypotension (neither)
    Given a patient
    And the patient is breathing
    And pulmonary ascultation of the patient is normal
    And rales are present in all pulmonary fields
    When the patient is not in shock
    And the blood pressure is normal
    Then assign the patient a grade of 3

  Scenario: All patients receive a single valid grade
    Given a patient
    When the algorithm is followed for the patient
    Then the patient will receive a single grade
    And that grade will be one of the following: 1,2,3,4,5,6, dead, or rescued


  Scenario Outline: grading
    Given a patient
    When the patient <responsive> responsive
    And the patient <pulse> a pulse
    And the patient was submerged for <time_submerged>
    And pulmonary ascultation comes out <pulmonary_ascultation>
    And rales are present in <rales> pulmonary fields
    And patient <hypotensive> hypotensive
    And patient <in_shock> in shock
    And patient <cough> cough
    And there <dead> obvious physical evidence of death
    Then assign a grade of <grade>

  Examples:
    |responsive|pulse    |time_submerged   |pulmonary_ascultation|rales|hypotensive|in_shock|cough|dead|grade
    |is not    |has      |any              |any                  |any  |any        |any     |any  |no  |5
    |is not    |has no   |less than an hour|any                  |any  |any        |any     |any  |no  |6
    |is not    |has no   |more than an hour|any                  |any  |any        |any     |any  |any |dead
    |is        |any      |any              |normal               |any  |any        |any     |no   |no  |rescued
    |is        |any      |any              |normal               |any  |any        |any     |yes  |no  |1
    |is        |any      |any              |abnormal             |some |any        |any     |no   |no  |2
    |is        |any      |any              |abnormal             |all  |yes        |any     |any  |no  |4
    |is        |any      |any              |abnormal             |all  |any        |yes     |any  |no  |4
    |is        |any      |any              |abnormal             |all  |no         |no      |any  |no  |3
    |any       |any      |any              |any                  |any  |any        |any     |any  |yes |dead




