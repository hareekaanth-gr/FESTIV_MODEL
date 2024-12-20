%%DEBUG_RTSCUC
%Debug RTSCUC to see what infeasibilities occurred. Requires solution of LP
%and integers turned off.

% Create gck file
fid=fopen('RTSCUC.gck','w+');
fprintf(fid,'%s','blockpic');
fprintf(fid,'\r\n');
fclose(fid);

RTSCUC_DEBUG_GAMS_CALL = ['gams ..\RTSCUC.gms Lo=2 Cdir="',DIRECTORY,'TEMP" --DIRECTORY="',DIRECTORY,'" --INPUT_FILE="',inputPath,'" --NETWORK_CHECK="',NETWORK_CHECK,'" --CONTINGENCY_CHECK="',CONTINGENCY_CHECK,'" --USE_INTEGER="NO"',' --USEGAMS="',USEGAMS,'"'];
rtscuc_debug=1;

RUN_RTSCUC

if exist('time','var') == 1
    [time modelSolveStatus numberOfInfes solverStatus relativeGap]
else
    [-1 modelSolveStatus numberOfInfes solverStatus relativeGap]
end
if modelSolveStatus == 1
    debugstr2='feasible.';
    fprintf(['The RTSCUC solution was',' ',debugstr2,'\n']);
else
    debugstr2 = ['infeasible with',' ',num2str(numberOfInfes),' ','infeasible constraints.'];
    fprintf(['The RTSCUC solution was',' ',debugstr2,'\n']);
    disp('Check RTSCUC.lst file for infeasibilities.');
end;

rtscuc_debug=0;