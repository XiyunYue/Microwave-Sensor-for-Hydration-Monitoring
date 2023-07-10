function [data, fs] = load_files(files)
  %% Load datafiles, assume all the same
  for i = 1:numel(files)
    A{i} = readmatrix(files(i));
  end

  fs = 1e9*A{1}(:, 1);

  data = zeros(numel(fs), numel(files), 'like', j);
  
  for i = 1:numel(files)
    data(:, i) = A{i}(:, 2) + j*A{i}(:, 3);
  end
end
