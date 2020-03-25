
.PHONY: rerun rerun_simulations rerun_hospitalization clean_hospitalization clean clean_simulations

NCOREPER=4
RSCRIPT=Rscript
PYTHON=python3
PIPELINE=COVIDScenarioPipeline/
CONFIG=config.yml 
OUTPUTBASE=minimal 
report: .files/15_simulation_None .files/15_hospitalization_None_high .files/15_hospitalization_None_med .files/15_hospitalization_None_low
	Rscript compile_Rmd.R
.files/1_simulation_None: 
	$(PYTHON) $(PIPELINE)/simulate.py -c $(CONFIG) -s None -n 1 -j $(NCOREPER)
	touch .files/1_simulation_None
.files/1_hospitalization_None_high: .files/1_simulation_None
	$(RSCRIPT) $(PIPELINE)/R/scripts/hosp_run.R -s None -d high -j $(NCOREPER)
	touch .files/1_hospitalization_None_high
.files/1_hospitalization_None_med: .files/1_simulation_None
	$(RSCRIPT) $(PIPELINE)/R/scripts/hosp_run.R -s None -d med -j $(NCOREPER)
	touch .files/1_hospitalization_None_med
.files/1_hospitalization_None_low: .files/1_simulation_None
	$(RSCRIPT) $(PIPELINE)/R/scripts/hosp_run.R -s None -d low -j $(NCOREPER)
	touch .files/1_hospitalization_None_low
.files/15_simulation_None: .files/1_simulation_None
	$(PYTHON) $(PIPELINE)/simulate.py -c $(CONFIG) -s None -n 14 -j $(NCOREPER)
	touch .files/15_simulation_None
.files/15_hospitalization_None_high: .files/15_simulation_None
	$(RSCRIPT) $(PIPELINE)/R/scripts/hosp_run.R -s None -d high -j $(NCOREPER)
	touch .files/15_hospitalization_None_high
.files/15_hospitalization_None_med: .files/15_simulation_None
	$(RSCRIPT) $(PIPELINE)/R/scripts/hosp_run.R -s None -d med -j $(NCOREPER)
	touch .files/15_hospitalization_None_med
.files/15_hospitalization_None_low: .files/15_simulation_None
	$(RSCRIPT) $(PIPELINE)/R/scripts/hosp_run.R -s None -d low -j $(NCOREPER)
	touch .files/15_hospitalization_None_low
.files/100_simulation_None: .files/15_simulation_None
	$(PYTHON) $(PIPELINE)/simulate.py -c $(CONFIG) -s None -n 85 -j $(NCOREPER)
	touch .files/100_simulation_None
.files/100_hospitalization_None_high: .files/100_simulation_None
	$(RSCRIPT) $(PIPELINE)/R/scripts/hosp_run.R -s None -d high -j $(NCOREPER)
	touch .files/100_hospitalization_None_high
.files/100_hospitalization_None_med: .files/100_simulation_None
	$(RSCRIPT) $(PIPELINE)/R/scripts/hosp_run.R -s None -d med -j $(NCOREPER)
	touch .files/100_hospitalization_None_med
.files/100_hospitalization_None_low: .files/100_simulation_None
	$(RSCRIPT) $(PIPELINE)/R/scripts/hosp_run.R -s None -d low -j $(NCOREPER)
	touch .files/100_hospitalization_None_low


rerun: rerun_simulations rerun_hospitalization
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
production_report: .files/production_100_simulation_None production_ .files/production_100_hospitalization_None_high production_ .files/production_100_hospitalization_None_med production_ .files/production_100_hospitalization_None_low
	Rscript compile_Rmd.R
.files/production_1_simulation_None: 
	$(PYTHON) $(PIPELINE)/simulate.py -c $(CONFIG) -s None -n 1 -j $(NCOREPER)
	touch .files/production_1_simulation_None
.files/production_1_hospitalization_None_high: .files/production_1_simulation_None
	$(RSCRIPT) $(PIPELINE)/R/scripts/hosp_run.R -s None -d high -j $(NCOREPER)
	touch .files/production_1_hospitalization_None_high
.files/production_1_hospitalization_None_med: .files/production_1_simulation_None
	$(RSCRIPT) $(PIPELINE)/R/scripts/hosp_run.R -s None -d med -j $(NCOREPER)
	touch .files/production_1_hospitalization_None_med
.files/production_1_hospitalization_None_low: .files/production_1_simulation_None
	$(RSCRIPT) $(PIPELINE)/R/scripts/hosp_run.R -s None -d low -j $(NCOREPER)
	touch .files/production_1_hospitalization_None_low
.files/production_15_simulation_None: 
	$(PYTHON) $(PIPELINE)/simulate.py -c $(CONFIG) -s None -n 15 -j $(NCOREPER)
	touch .files/production_15_simulation_None
.files/production_15_hospitalization_None_high: .files/production_15_simulation_None
	$(RSCRIPT) $(PIPELINE)/R/scripts/hosp_run.R -s None -d high -j $(NCOREPER)
	touch .files/production_15_hospitalization_None_high
.files/production_15_hospitalization_None_med: .files/production_15_simulation_None
	$(RSCRIPT) $(PIPELINE)/R/scripts/hosp_run.R -s None -d med -j $(NCOREPER)
	touch .files/production_15_hospitalization_None_med
.files/production_15_hospitalization_None_low: .files/production_15_simulation_None
	$(RSCRIPT) $(PIPELINE)/R/scripts/hosp_run.R -s None -d low -j $(NCOREPER)
	touch .files/production_15_hospitalization_None_low
.files/production_100_simulation_None: 
	$(PYTHON) $(PIPELINE)/simulate.py -c $(CONFIG) -s None -n 100 -j $(NCOREPER)
	touch .files/production_100_simulation_None
.files/production_100_hospitalization_None_high: .files/production_100_simulation_None
	$(RSCRIPT) $(PIPELINE)/R/scripts/hosp_run.R -s None -d high -j $(NCOREPER)
	touch .files/production_100_hospitalization_None_high
.files/production_100_hospitalization_None_med: .files/production_100_simulation_None
	$(RSCRIPT) $(PIPELINE)/R/scripts/hosp_run.R -s None -d med -j $(NCOREPER)
	touch .files/production_100_hospitalization_None_med
.files/production_100_hospitalization_None_low: .files/production_100_simulation_None
	$(RSCRIPT) $(PIPELINE)/R/scripts/hosp_run.R -s None -d low -j $(NCOREPER)
	touch .files/production_100_hospitalization_None_low
