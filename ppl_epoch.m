function ppl = ppl_epoch(ppl, trgLabel, epochRange)

trig = ppl.event_time(strcmp(trgLabel, ppl.event_info));

for i = 1:length(trig)
    trig_TS = find(ppl.pupil_time == trig(i));
    if isempty(trig_TS)
        trig_TS = dsearchn(ppl.pupil_time,trig(i));
        warning('It appears that the timestamp associated with the triggers does not appear in the pupil timestamp. Fixing the triggers timestamp to the closest data timestamp')
    end
    trial_data = ppl.pupil_data(trig_TS+(epochRange(1)*ppl.srate):trig_TS+(epochRange(2)*ppl.srate));
    tmp_data(:,i) = trial_data;
end

ppl.trial_pupil = tmp_data;
ppl.trial_raw = tmp_data;
ppl.nTrials = length(trig);
ppl.trial_time = repmat(( epochRange(1):1/ppl.srate: epochRange(2))', 1,  ppl.nTrials );

if isempty(ppl.trialGroup)
    ppl.trialGroup = ones(ppl.nTrials,1);
end
