# Created by nima at 12/2/19
Feature: Classify patient
  Classify or grade a drowning victim based on an algorithm from a journal article "Prevention and Treatment of Drowning"
  (See https://www.ncbi.nlm.nih.gov/pubmed/27035042?dopt=Abstract)

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




