load("saved-data.mat");
close all;

ddt_y_I = zeros(3e6,1);
ddt_y_Q = zeros(3e6,1);

for i=1:length(y_I)-1
    ddt_y_I(i) = y_I(i+1) - y_I(i);
    ddt_y_Q(i) = y_Q(i+1) - y_Q(i);
end

ddt_y_I(length(y_I)) = 0;
ddt_y_Q(length(y_Q)) = 0;

m_t = ddt_y_Q.*y_I - ddt_y_I.*y_Q;

m_t = decimate(m_t, 4);

m_t = m_t .* 0.1 ./ max(m_t);

sound(m_t, fs/4);