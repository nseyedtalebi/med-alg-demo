# Created by nima at 12/4/19
Feature: Simulation environment
  An environment for our simulated doctors and patient that captures their int-
  eractions and calculates some basic statistics. Environments always contain
  at least one patient and at least one doctor, but may contain more than one
  of either. Patients in the environment can be randomly-generated or explicitly
  described. Doctors may start with a list of "previously seen patients", even
  though they have not seen any in the simulation environment. There is no
  notion of time in these environments, and the patients in them do not change
  after being created - they always have the same internal state that they
  started out with. Note that this is not the case for doctors; they can
  form new memories and forget old ones, so they are mutable.

  Scenario: # Enter scenario name here
    # Enter steps here