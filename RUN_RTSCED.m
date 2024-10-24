%Everything here will start from NAME_VAL, converted to GAMS format, per
%unitized, written to gdx, run GAMS, then bring data back to matlab.

CREATE_RTD_GAMS_VARIABLES

PER_UNITIZE;

if Solving_Initial_Models
wgdx(['TEMP', filesep, 'RTSCEDINPUT1'],PTDF,BRANCHDATA,INJECTION_FACTOR,STORAGEPARAM,LODF,PTDF_PAR,...
    RESERVE_COST,GENBUS,BRANCHBUS,QSC,BLOCK_CAP,BLOCK_COST,LOAD_DIST,RESERVEVALUE,COST_CURVE,INITIAL_DISPATCH_SLACK_SET);
    
end;

wgdx(['TEMP', filesep, 'RTSCEDINPUT2'],RESERVELEVEL,VG_FORECAST,UNIT_STATUS,UNIT_STARTINGUP,UNIT_STARTUPMINGENHELP,...
     UNIT_SHUTTINGDOWN,INTERVAL_MINUTES,ACTUAL_GEN_OUTPUT,LAST_GEN_SCHEDULE,RAMP_SLACK_UP,RAMP_SLACK_DOWN,...
     LAST_STATUS,LAST_STATUS_ACTUAL,GEN_FORCED_OUT,INITIAL_DISPATCH_SLACK,LOAD,PUMPING,ACTUAL_PUMP_OUTPUT,STARTUP_PERIOD,...
     LAST_PUMP_SCHEDULE,LAST_PUMPSTATUS,LAST_PUMPSTATUS_ACTUAL,UNIT_PUMPINGUP,UNIT_PUMPINGDOWN,UNIT_PUMPUPMINGENHELP,...
     END_STORAGE_PENALTY_PLUS_PRICE,END_STORAGE_PENALTY_MINUS_PRICE,BUS_DELIVERY_FACTORS,GEN_DELIVERY_FACTORS,...
     LOSS_BIAS,UNIT_SHUTTINGDOWN_ACTUAL,INTERVAL,NRTDINTERVAL,RTD_PROCESS_TIME,RTDINTERVAL_LENGTH,RTDINTERVAL_ADVISORY_LENGTH,...
     RTDINTERVAL_UPDATE,UNIT_PUMPINGDOWN_ACTUAL,UNIT_STARTINGUP_ACTUAL,UNIT_PUMPINGUP_ACTUAL,PUCOST_BLOCK_OFFSET,GENVALUE,STORAGEVALUE);

system(RTSCED_GAMS_CALL);
[RTDPRODCOST,RTDGENSCHEDULE,RTDLMP,RTDUNITSTATUS,RTDUNITSTARTUP,RTDUNITSHUTDOWN,RTDGENRESERVESCHEDULE,...
    RTDRCP,RTDVGCURTAILMENT,RTDLOSSLOAD,RTDINSUFFRESERVE,RTDPUMPSCHEDULE,RTDSTORAGELEVEL,RTDPUMPING] ...
    = getgamsdata('TOTAL_RTSCEDOUTPUT','RTSCED','YES',GEN,INTERVAL,BUS,BRANCH,RESERVETYPE,SYSTEMVALUE_VAL,RESERVEVALUE_VAL,GENPARAM,STORAGEVALUE,BRANCHPARAM);
