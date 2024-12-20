dascuc_last_interval_index=(DASCUC_binding_interval_index-1)*HDAC;
for i=1:ngen
    GENVALUE_VAL(i,initial_status)=STATUS((dascuc_last_interval_index-1)*rtscuc_commitment_multiplier+1,1+i);
    GENVALUE_VAL(i,initial_MW) = DASCUCSCHEDULE(dascuc_last_interval_index,i+1);
    h = (dascuc_last_interval_index-1)*rtscuc_commitment_multiplier+1;
    hr_cnt = 0;
    if GENVALUE_VAL(i,initial_status) == 1
        while h>=1
            if STATUS(h,1+i) == 1
                hr_cnt = hr_cnt + 1/rtscuc_I_perhour;
                h = h-1;
            else
                h = -1;
            end;
        end;
    else
         while h>=1
            if STATUS(h,1+i) == 0
                hr_cnt = hr_cnt + 1/rtscuc_I_perhour;
                h = h-1;
            else
                h = -1;
            end;
        end;
    end;
    if h>= 0
        GENVALUE_VAL(i,initial_hour) = GENVALUE_VAL(i,initial_hour) + ceil(hr_cnt);
    else
        GENVALUE_VAL(i,initial_hour) = ceil(hr_cnt);
    end
end
for e=1:nESR
    STORAGEVALUE_VAL(e,initial_pump_status)=PUMPSTATUS((dascuc_last_interval_index-1)*rtscuc_commitment_multiplier+1,1+storage_to_gen_index(e,1));
    STORAGEVALUE_VAL(e,initial_pump_mw) = DASCUCPUMPSCHEDULE(dascuc_last_interval_index,e+1);
    h=(dascuc_last_interval_index-1)*rtscuc_commitment_multiplier+1;
    hr_cnt = 0;
    if STORAGEVALUE_VAL(e,initial_pump_status) == 1
        while h>=1
            if PUMPSTATUS(h,1+storage_to_gen_index(e,1)) == 1
                hr_cnt = hr_cnt + 1/rtscuc_I_perhour;
                h = h-1;
            else
                h = -1;
            end;
        end;
    else
         while h>=1
            if PUMPSTATUS(h,1+storage_to_gen_index(e,1)) == 0
                hr_cnt = hr_cnt + 1/rtscuc_I_perhour;
                h = h-1;
            else
                h = -1;
            end;
        end;
    end;
    if h>= 0
        STORAGEVALUE_VAL(e,initial_pump_hour) = STORAGEVALUE_VAL(e,initial_pump_hour) + ceil(hr_cnt);
    else
        STORAGEVALUE_VAL(e,initial_pump_hour) = ceil(hr_cnt);
    end
    STORAGEVALUE_VAL(e,reservoir_value) = STORAGEVALUE_VAL(e,reservoir_value);
    dascucstorage_now_index = floor(time/IDAC+eps)+1; %starting at 0
    STORAGEVALUE_VAL(e,initial_storage) = DASCUCSTORAGELEVEL(dascuc_last_interval_index,1+e);
    STORAGEVALUE_VAL(e,final_storage) = STORAGEVALUE_VAL(e,final_storage);
end;


