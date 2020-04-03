
.PHONY: rerun rerun_simulations rerun_hospitalization clean_hospitalization clean clean_simulations

NCOREPER=4
RSCRIPT=Rscript
PYTHON=python3
PIPELINE=COVIDScenarioPipeline/
CONFIG=config.yml 
OUTPUTBASE=minimal 
report: .files/15_simulation_None .files/15_hospitalization_None_low .files/15_hospitalization_None_med .files/15_hospitalization_None_high .files/15_simulation_Scenario1 .files/15_hospitalization_Scenario1_low .files/15_hospitalization_Scenario1_med .files/15_hospitalization_Scenario1_high
	Rscript compile_Rmd.R
.files/15_simulation_None: 
	$(PYTHON) $(PIPELINE)/simulate.py -c $(CONFIG) -s None -n 15 -j $(NCOREPER)
	touch .files/15_simulation_None
.files/15_hospitalization_None_low: .files/15_simulation_None
	$(RSCRIPT) $(PIPELINE)/R/scripts/hosp_run.R -s None -d low -j $(NCOREPER) -c $(CONFIG)
	touch .files/15_hospitalization_None_low
.files/15_hospitalization_None_med: .files/15_simulation_None
	$(RSCRIPT) $(PIPELINE)/R/scripts/hosp_run.R -s None -d med -j $(NCOREPER) -c $(CONFIG)
	touch .files/15_hospitalization_None_med
.files/15_hospitalization_None_high: .files/15_simulation_None
	$(RSCRIPT) $(PIPELINE)/R/scripts/hosp_run.R -s None -d high -j $(NCOREPER) -c $(CONFIG)
	touch .files/15_hospitalization_None_high
.files/15_simulation_Scenario1: 
	$(PYTHON) $(PIPELINE)/simulate.py -c $(CONFIG) -s Scenario1 -n 15 -j $(NCOREPER)
	touch .files/15_simulation_Scenario1
.files/15_hospitalization_Scenario1_low: .files/15_simulation_Scenario1
	$(RSCRIPT) $(PIPELINE)/R/scripts/hosp_run.R -s Scenario1 -d low -j $(NCOREPER) -c $(CONFIG)
	touch .files/15_hospitalization_Scenario1_low
.files/15_hospitalization_Scenario1_med: .files/15_simulation_Scenario1
	$(RSCRIPT) $(PIPELINE)/R/scripts/hosp_run.R -s Scenario1 -d med -j $(NCOREPER) -c $(CONFIG)
	touch .files/15_hospitalization_Scenario1_med
.files/15_hospitalization_Scenario1_high: .files/15_simulation_Scenario1
	$(RSCRIPT) $(PIPELINE)/R/scripts/hosp_run.R -s Scenario1 -d high -j $(NCOREPER) -c $(CONFIG)
	touch .files/15_hospitalization_Scenario1_high


rerun: rerun_simulations rerun_hospitalization
rerun_filter:
	rm -f .files/1*_filter
rerun_importation:
	rm -f .files/1*_importation
rerun_simulations: clean_simulations
	rm -f .files/1*_simulation*
rerun_hospitalization:
	rm -f .files/1*_hospitalization*
clean: clean_simulations clean_hospitalization clean_reports
clean_reports:
	rm -f notebooks/*.html
clean_simulations: rerun_simulations
	rm -rf model_output
clean_hospitalization: rerun_hospitalization
	rm -rf hospitalization
