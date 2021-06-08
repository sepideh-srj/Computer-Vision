function [dist] = getImageDistance(hist1, hist2, method)

if strcmp(method, 'euclidean')
    euc = (hist1 - hist2).^2;
    dist = sqrt(sum(euc,2));
else
    chi2 = ((hist1 - hist2).^2)./(hist1 + hist2 + 0.00001);
    dist = sum(chi2,2)/2;

end