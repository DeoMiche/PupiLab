function data_bsln = ppl_baseline(data, baseline_values, time)

    if size(data, 2) > 1 && size(data, 1) > 1
        for i_data = 1:size(data, 2)
            data_bsln(:, i_data) = ppl_baseline(data(:, i_data), baseline_values, time);
        end
    else
        bs1 = dsearchn(time, baseline_values(1));
        bs2 = dsearchn(time, baseline_values(2));

        data_bsln = data - mean(data(bs1:bs2), 'omitnan');
    end