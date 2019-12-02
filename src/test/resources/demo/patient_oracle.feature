# Created by nima at 12/2/19
Feature: Patient Oracle
  Provides answers to the questions used in the drowning classification algorithm - no more, no less.

  Scenario: Responds to verbal stimuli?
    When asked if the patient responds to verbal stimuli
    Then tell me if they do or not

  Scenario: Responds to tactile stimuli?
    When asked if the patient responds to tactile stimuli
    Then tell me if they do or not

  Scenario: Results of pulmonary ascultation
    When asked for the results of pulmonary ascultation
    Then tell me the exam was either normal or abnormal
    And if a cough is present or not
    And if rales are present in some, all, or no pulmonary fields

  Scenario: Is blood pressure low or normal?
    When asked if blood pressure is low or normal
    Then tell me if it's low or normal

  Scenario: Is the patient in shock?
    When asked if the patient is in shock
    Then tell me if they are or not

  Scenario: Does the patient have a pulse?
    When asked if the patient has a pulse
    Then tell me if they have a pulse or not

  Scenario: Was the patient submerged for more than an hour?
    When asked if the patient was submerged for more than an hour
    Then tell me if they were submerged for more than an hour or not

  Scenario: Is there obvious physical evidence of death?
    When asked if there is obvious physical evidence of death
    Then tell me whether there is obvious physical evidence of death or not

  Scenario: Any other question or no question
    When asked any other question or no question at all
    Then do nothing

