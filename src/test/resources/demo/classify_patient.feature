# Created by nima at 12/2/19
Feature: Classify patient
  Classify or grade a drowning victim based on an algorithm from a journal article "Prevention and Treatment of Drowning"
  (See https://www.ncbi.nlm.nih.gov/pubmed/27035042?dopt=Abstract)

  Scenario Outline: grading
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
#Note: 'x' stands for 'dont care' and saves us significant writing w.r.t. the truth table
  Examples:
    |resp? |pulse?  |submerged?|pulm ascult|rales?|hypo? |cough?       |dead?|grade
    |is not|does    |x         |x          |x     |x     |x            |no   |5
    |is not|does not|less than |x          |x     |x     |x            |no   |6
    |is not|does not|more than |x          |x     |x     |x            |x    |dead
    |is    |does    |x         |normal     |x     |x     |does not have|no   |rescued
    |is    |does    |x         |normal     |x     |x     |has          gitgit |no   |1
    |is    |does    |x         |abnormal   |some  |x     |does not have|no   |2
    |is    |does    |x         |abnormal   |all   |is    |x            |no   |4
    |is    |does    |x         |abnormal   |all   |is not|x            |no   |3
    |x     |x       |x         |x          |x     |x     |x            |yes  |dead




