function dataInterpolated = InterpolateBlinks(data)

N = length(data);
data_flipped = [flipud(data); data; flipud(data)];

blinkBin = isnan(data_flipped);
blinkDetector = bwconncomp(blinkBin);
nBlink = blinkDetector.NumObjects;
for i_blink = 1:nBlink
    blinkStart = blinkDetector.PixelIdxList{i_blink}(1);
    blinkEnd = blinkDetector.PixelIdxList{i_blink}(end);
    if blinkStart == 1 || blinkEnd == length(data_flipped)
        % don't interpolate the trial start/end
        data_flipped(blinkStart:blinkEnd) = 0;
    else

        xGood = unique(sort([max(blinkStart-500,1):100:min(blinkEnd+500, length(data_flipped)), blinkEnd+1, blinkStart-1]));

        xInterp = max(blinkStart-500,1):min(blinkEnd+500, length(data_flipped));
        interpStart = find(xInterp == blinkStart);
        interpEnd = find(xInterp == blinkEnd);

        warning('OFF') % annoying nan warning from makima
        datatmp = makima(xGood, data_flipped(xGood), xInterp);
        warning('ON')
        
        data_flipped(blinkStart:blinkEnd) = datatmp(interpStart:interpEnd);            
    end
end

dataInterpolated = data_flipped(N+1:N*2);