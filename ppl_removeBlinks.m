function dataClean = ppl_removeBlinks(data, tolerance,missingDataThreshold, artifactSize, doInterpolation)

N = length(data);
dataP = [flipud(data); data; flipud(data)];
pd = fitdist(diff(data),'Normal');
blinkThreshold = abs(pd.sigma*tolerance);

%% detect and clean blink(s)
dataBlink1 = dataP;

blinkBin = dataBlink1 == 0;
blinkDetector = bwconncomp(blinkBin);
nBlink = blinkDetector.NumObjects;

for i_blink = 1:nBlink
    blinkStart = max(blinkDetector.PixelIdxList{i_blink}(1)-artifactSize, 1);
    blinkEnd = min(blinkDetector.PixelIdxList{i_blink}(end)+artifactSize, length(dataBlink1));
    dataBlink1(blinkStart:blinkEnd) = nan;
end

%% clean missed blinks
dataBlink2 = dataBlink1;

mBlinkBin = abs(diff(dataBlink2))>blinkThreshold | dataBlink2(2:end) == 0;
blinkDetector = bwconncomp(mBlinkBin);
nmBlink = blinkDetector.NumObjects; % missed blinks

for i_blink = 1:nmBlink
    blinkStart = max(blinkDetector.PixelIdxList{i_blink}(1)-artifactSize, 1);
    blinkEnd = min(blinkDetector.PixelIdxList{i_blink}(end)+artifactSize, length(dataP));
    dataBlink2(blinkStart:blinkEnd) = nan;
end

% percentage of missing dataP
missingData = sum(isnan(dataBlink2))/length(dataBlink2);

%% exclude bad trials
if missingData<missingDataThreshold    
    dataClean = dataBlink2(N+1:N*2);
    if doInterpolation
        dataClean = InterpolateBlinks(dataClean);
    end
else
    dataClean = nan(size(data));
end
