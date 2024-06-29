DIR_WORK 	= ../work
DIR_SRC_UVC = ../sv
DIR_SRC_TB	= ../example

SRC_UVC_PKG = $(shell find ${DIR_SRC_UVC} -name "*_pkg.sv" 	  -printf "%p ")
SRC_TB_PKG	= $(shell find ${DIR_SRC_TB}  -name "*_pkg.sv" 	  -printf "%p ")
SRC_TB		= $(shell find ${DIR_SRC_TB}  -name "*_tb_top.sv" -printf "%p ")

SRC_SV		= $(shell find ${DIR_SRC_UVC} -name "*.sv"        -printf "%p ")
SRC_TEST	= $(shell find ${DIR_SRC_TB}  -name "*.sv"		  -printf "%p ")

UVC_NAME  = ahb_lite_uvc

TB_TOP	  = ${UVC_NAME}_tb_top
TEST      = test_${UVC_NAME}_base

XSIMK_DIR = ${DIR_WORK}/xsim.dir/work.${TB_TOP}
XSIMK	  = ${XSIMK_DIR}/xsimk

ifndef SEED
SEED = 0
endif

ifndef UVM_VERBOSITY
UVM_VERBOSITY = UVM_LOW
endif

ifndef UVM_TESTNAME
UVM_TESTNAME = ${TEST}
endif

XVLOG_ARGS	 = -incr -sv -L uvm
XVLOG_ARGS	+= --sourcelibdir ${DIR_SRC_RTL}
XVLOG_ARGS	+= --sourcelibdir ${DIR_SRC_UVC}
XVLOG_ARGS	+= --sourcelibdir ${DIR_SRC_TB}
XVLOG_ARGS  += -i ${DIR_SRC_UVC}
XVLOG_ARGS  += -i ${DIR_SRC_TB}

XELAB_ARGS   = --incr -L uvm
XELAB_ARGS	+= --stats --O3
XELAB_ARGS	+= --debug all

${XSIMK}: ${SRC_UVC_PKG} ${SRC_TB_PKG} ${SRC_TB} ${SRC_SV} ${SRC_TEST} | ${DIR_WORK}
	@cd ${DIR_WORK} && \
	xvlog ${XVLOG_ARGS} ${SRC_UVC_PKG} ${SRC_TB_PKG} ${SRC_TB} && \
	xelab ${XELAB_ARGS} ${TB_TOP}

XSIM_ARGS  	 = --stats --sv_seed ${SEED}
XSIM_ARGS	+= --testplusarg "UVM_TESTNAME=${UVM_TESTNAME}"
XSIM_ARGS	+= --testplusarg "UVM_VERBOSITY=${UVM_VERBOSITY}"
XSIM_ARGS   += --testplusarg "UVM_CONFIG_DB_TRACE"
XSIM_ARGS   += --cov_db_name ${UVC_NAME}_cov_db_${SEED}

run_batch: ${XSIMK}
	@cd ${DIR_WORK} && \
	xsim  ${XSIM_ARGS}	${TB_TOP} -R

run_gui: ${XSIMK}
	@cd ${DIR_WORK} && \
	xsim  ${XSIM_ARGS}	${TB_TOP} -g

XSIM_REGR_ARGS 	= --testplusarg "UVM_TESTNAME=${UVM_TESTNAME}"
XSIM_REGR_ARGS += --testplusarg "UVM_VERBOSITY=${UVM_VERBOSITY}"
XSIM_REGR_ARGS += --sv_seed $$REGR_SEED
XSIM_REGR_ARGS += --cov_db_name ${UVC_NAME}_cov_db_$$REGR_SEED
#XSIM_REGR_ARGS += --tclbatch ../scripts/sim.tcl

run_regr: ${XSIMK}
	@cd ${DIR_WORK} && \
	for REGR_SEED in `seq 0 ${REGR_TEST_COUNT}` ; do \
		echo [REGR]: sv_seed $$REGR_SEED ; \
		xsim ${XSIM_REGR_ARGS} ${TB_TOP} > /dev/null ; \
	done

load_wave:
	@cd ${DIR_WORK} && \
	xsim work.${TB_TOP}.wdb -g

load_cov:
	@cd ${DIR_WORK} && \
	xcrg -report_format html && \
	firefox --new-window file://${PWD}/${DIR_WORK}/xcrg_func_cov_report/dashboard.html &

${DIR_WORK}:
	@mkdir -p $@

clean:
	@rm -rf ${DIR_WORK}
