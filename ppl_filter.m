function dataFiltered = ppl_filter(data, srate, Hz, steepness)
data_tmp = data;

if sum(isnan(data))>0
    data_tmp = InterpolateBlinks(data);
%     data_tmp(isnan(data)) = 0;
end

data_flipped = [flipud(data_tmp); data_tmp; flipud(data_tmp)];
lowpass_data = lowpass(data_flipped, Hz, srate, 'Steepness',steepness);

dataFiltered = lowpass_data(length(data_tmp)+1:length(data_tmp)*2);
dataFiltered(isnan(data)) = nan;
