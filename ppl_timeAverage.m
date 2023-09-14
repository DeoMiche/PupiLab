function data_avg = ppl_timeAverage(data, time_idx, time)

    bs1 = dsearchn(time, time_idx(1));
    bs2 = dsearchn(time, time_idx(2));
    if size(data, 2) > 1 && size(data, 1) > 1
        data_avg = mean(data(bs1:bs2,:), 1, 'omitnan');
    else
        data_avg = mean(data(bs1:bs2), 'omitnan');
    end