function x = anomalydetection(original, prediction)
    err = abs(original-prediction);
    x = find(err > 0.14);
end