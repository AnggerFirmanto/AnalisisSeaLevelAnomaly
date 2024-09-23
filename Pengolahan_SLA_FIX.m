% % Memuat data Sea Level Anomaly dari file CSV
% filename = 'SLA_1993_2023_kecil.csv';
% data = readtable(filename, 'Delimiter', ';', 'ReadVariableNames', true);
% 
% % Asumsi kolom pertama adalah tanggal dalam format 'MM-YYYY' dan kolom kedua adalah data SLA
% tanggalStr = data{:, 1}; % Ambil kolom tanggal sebagai string
% SLA_str = data{:, 2}; % Data SLA sebagai string
% 
% % Hapus karakter yang tidak diinginkan dari kolom SLA dan konversi koma ke titik
% SLA_str = strrep(SLA_str, ' ', '');
% SLA_str = strrep(SLA_str, ',', '.');
% SLA = str2double(SLA_str); % Konversi ke double
% 
% % Cetak nilai SLA setelah konversi untuk pemeriksaan
% disp('Nilai SLA setelah konversi ke double:');
% disp(SLA);
% 
% % Konversi string tanggal ke datetime dengan format 'MM-yyyy'
% try
%     tanggal = datetime(tanggalStr, 'InputFormat', 'MM-yyyy');
% catch
%     error('Format tanggal tidak sesuai. Pastikan format tanggal adalah "MM-yyyy".');
% end
% 
% % Menghitung tren SLA
% tanggalNum = datenum(tanggal); % Konversi ke nomor seri tanggal
% p = polyfit(tanggalNum, SLA, 1); % Fit garis linear
% trenSLA = p(1) * 365.25; % Konversi kemiringan tren per tahun
% yfit = polyval(p, tanggalNum);
% 
% % Menghitung nilai R-squared
% SLA_mean = mean(SLA);
% SS_tot = sum((SLA - SLA_mean).^2);
% SS_res = sum((SLA - yfit).^2);
% R_squared = 1 - (SS_res / SS_tot);
% 
% % Tampilkan plot SLA dengan garis tren
% figure;
% plot(tanggal, SLA, 'b');
% hold on;
% plot(tanggal, yfit, 'r--', 'LineWidth', 2);
% title('Tren Sea Level Anomaly (SLA)');
% xlabel('Tanggal');
% ylabel('Sea Level Anomaly (m)');
% legend('SLA', 'Tren', 'Location', 'Best');
% grid on;
% 
% % Format sumbu Y agar hanya menampilkan dua angka di belakang koma
% ax = gca;
% ax.YRuler.Exponent = 0; % Disable scientific notation
% ax.YAxis.TickLabelFormat = '%,.3f';
% 
% % Atur format sumbu X untuk menampilkan bulan dan tahun
% uniqueYears = unique(year(tanggal));
% numYears = numel(uniqueYears);
% 
% % Tetapkan xticks sebagai linspace yang terurut dengan benar
% xticks = linspace(datenum(tanggal(1)), datenum(tanggal(end)), numYears * 2);
% 
% % Cetak xticks untuk pemeriksaan
% disp('xticks sebelum konversi ke datetime:');
% disp(xticks);
% 
% % Konversi xticks ke datetime
% xticks_datetime = datetime(xticks, 'ConvertFrom', 'datenum');
% 
% % Cetak xticks_datetime untuk pemeriksaan
% disp('xticks_datetime sebelum diurutkan:');
% disp(xticks_datetime);
% 
% % Pastikan xticks_datetime terurut dan tidak ada duplikat
% xticks_datetime = unique(xticks_datetime);
% xticks_datetime = sort(xticks_datetime);
% 
% % Cetak xticks_datetime setelah diurutkan
% disp('xticks_datetime setelah diurutkan:');
% disp(xticks_datetime);
% 
% % Periksa apakah xticks_datetime benar-benar terurut
% if any(diff(xticks_datetime) <= 0)
%     error('Nilai xticks_datetime tidak terurut dengan benar.');
% end
% 
% % Tetapkan XTick sebagai datetime
% ax.XTick = xticks_datetime;
% ax.XTickLabel = cellstr(datestr(xticks_datetime, 'mm-yyyy')); % Format label XTick
% ax.XAxis.FontSize = 10;
% ax.XTickLabelRotation = 45;
% 
% % Menampilkan persamaan tren dan nilai R-squared di plot dengan tampilan yang jelas
% text(tanggal(end-30), max(SLA)*0.8, sprintf('y = %.5fx + %.5f', p(1), p(2)), 'FontSize', 10, 'Color', 'k', 'BackgroundColor', 'w', 'EdgeColor', 'k');
% text(tanggal(end-30), max(SLA)*0.7, sprintf('R^2 = %.5f', R_squared), 'FontSize', 10, 'Color', 'k', 'BackgroundColor', 'w', 'EdgeColor', 'k');
% 
% % Mencari tanggal SLA tertinggi dan terendah
% [SLA_tertinggi, idx_tertinggi] = max(SLA);
% [SLA_terendah, idx_terendah] = min(SLA);
% tanggal_tertinggi = tanggal(idx_tertinggi);
% tanggal_terendah = tanggal(idx_terendah);
% 
% % Tampilkan nilai tren di command window
% fprintf('Tren Sea Level Anomaly (SLA): %.4f m/tahun\n', trenSLA);
% 
% % Tampilkan nilai SLA tertinggi dan terendah beserta tanggalnya di command window
% fprintf('Sea Level Anomaly (SLA) Tertinggi: %.3f m pada %s\n', SLA_tertinggi, datestr(tanggal_tertinggi, 'mm-yyyy'));
% fprintf('Sea Level Anomaly (SLA) Terendah: %.3f m pada %s\n', SLA_terendah, datestr(tanggal_terendah, 'mm-yyyy'));
% 
% % Tampilkan persamaan tren dan nilai R-squared di Command Window
% fprintf('Persamaan Tren: y = %.5fx + %.5f\n', p(1), p(2));
% fprintf('Nilai R-squared: %.5f\n', R_squared);

% % Memuat data Sea Level Anomaly dari file CSV
% filename = 'SLA_1993_2023_kecil.csv';
% data = readtable(filename, 'Delimiter', ';', 'ReadVariableNames', true);
% 
% % Asumsi kolom pertama adalah tanggal dalam format 'MM-YYYY' dan kolom kedua adalah data SLA
% tanggalStr = data{:, 1}; % Ambil kolom tanggal sebagai string
% SLA_str = data{:, 2}; % Data SLA sebagai string
% 
% % Hapus karakter yang tidak diinginkan dari kolom SLA dan konversi koma ke titik
% SLA_str = strrep(SLA_str, ' ', '');
% SLA_str = strrep(SLA_str, ',', '.');
% SLA = str2double(SLA_str); % Konversi ke double
% 
% % Cetak nilai SLA setelah konversi untuk pemeriksaan
% disp('Nilai SLA setelah konversi ke double:');
% disp(SLA);
% 
% % Konversi string tanggal ke datetime dengan format 'MM-yyyy'
% try
%     tanggal = datetime(tanggalStr, 'InputFormat', 'MM-yyyy');
% catch
%     error('Format tanggal tidak sesuai. Pastikan format tanggal adalah "MM-yyyy".');
% end
% 
% % Menghitung tren SLA
% tanggalNum = datenum(tanggal); % Konversi ke nomor seri tanggal
% p = polyfit(tanggalNum, SLA, 1); % Fit garis linear
% trenSLA = p(1) * 365.25; % Konversi kemiringan tren per tahun
% yfit = polyval(p, tanggalNum);
% 
% % Menghitung nilai R-squared
% SLA_mean = mean(SLA);
% SS_tot = sum((SLA - SLA_mean).^2);
% SS_res = sum((SLA - yfit).^2);
% R_squared = 1 - (SS_res / SS_tot);
% 
% % Tampilkan plot SLA dengan garis tren
% figure;
% plot(tanggal, SLA, 'b');
% hold on;
% plot(tanggal, yfit, 'r--', 'LineWidth', 2);
% title('Tren Sea Level Anomaly (SLA)');
% xlabel('Tahun');
% ylabel('Sea Level Anomaly (m)');
% legend('SLA', 'Tren', 'Location', 'Best');
% grid on;
% 
% % Format sumbu Y agar hanya menampilkan dua angka di belakang koma
% ax = gca;
% ax.YRuler.Exponent = 0; % Disable scientific notation
% ax.YAxis.TickLabelFormat = '%,.3f';
% 
% % Atur format sumbu X untuk menampilkan tahun
% xticks = linspace(datenum(tanggal(1)), datenum(tanggal(end)), numel(unique(year(tanggal))));
% xticks_datetime = datetime(xticks, 'ConvertFrom', 'datenum');
% ax.XTick = xticks_datetime;
% ax.XTickLabel = cellstr(datestr(xticks_datetime, 'yyyy')); % Format label XTick
% ax.XAxis.FontSize = 10;
% ax.XTickLabelRotation = 45;
% 
% % Mencari tanggal SLA tertinggi dan terendah
% [SLA_tertinggi, idx_tertinggi] = max(SLA);
% [SLA_terendah, idx_terendah] = min(SLA);
% tanggal_tertinggi = tanggal(idx_tertinggi);
% tanggal_terendah = tanggal(idx_terendah);
% 
% % Tampilkan nilai tren di command window
% fprintf('Tren Sea Level Anomaly (SLA): %.4f m/tahun\n', trenSLA);
% 
% % Tampilkan nilai SLA tertinggi dan terendah beserta tanggalnya di command window
% fprintf('Sea Level Anomaly (SLA) Tertinggi: %.3f m pada %s\n', SLA_tertinggi, datestr(tanggal_tertinggi, 'mm-yyyy'));
% fprintf('Sea Level Anomaly (SLA) Terendah: %.3f m pada %s\n', SLA_terendah, datestr(tanggal_terendah, 'mm-yyyy'));
% 
% % Tampilkan persamaan tren dan nilai R-squared di Command Window
% fprintf('Persamaan Tren: y = %.5fx + %.5f\n', p(1), p(2));
% fprintf('Nilai R-squared: %.5f\n', R_squared);
% 
% % Bagian ini dihapus untuk menghilangkan teks y = dan R² pada plot
% % text(tanggal(end-30), max(SLA)*0.8, sprintf('y = %.5fx + %.5f', p(1), p(2)), 'FontSize', 10, 'Color', 'k', 'BackgroundColor', 'w', 'EdgeColor', 'k');
% % text(tanggal(end-30), max(SLA)*0.7, sprintf('R^2 = %.5f', R_squared), 'FontSize', 10, 'Color', 'k', 'BackgroundColor', 'w', 'EdgeColor', 'k');
% 
%% -------------------------------------------------------------
% % TANPA NILAI TREN
% % Memuat data Sea Level Anomaly dari file CSV
% filename = 'SLA_1993_2023_kecil.csv';
% data = readtable(filename, 'Delimiter', ';', 'ReadVariableNames', true);
% 
% % Asumsi kolom pertama adalah tanggal dalam format 'MM-YYYY' dan kolom kedua adalah data SLA
% tanggalStr = data{:, 1}; % Ambil kolom tanggal sebagai string
% SLA_str = data{:, 2}; % Data SLA sebagai string
% 
% % Hapus karakter yang tidak diinginkan dari kolom SLA dan konversi koma ke titik
% SLA_str = strrep(SLA_str, ' ', '');
% SLA_str = strrep(SLA_str, ',', '.');
% SLA = str2double(SLA_str); % Konversi ke double
% 
% % Cetak nilai SLA setelah konversi untuk pemeriksaan
% disp('Nilai SLA setelah konversi ke double:');
% disp(SLA);
% 
% % Konversi string tanggal ke datetime dengan format 'MM-yyyy'
% try
%     tanggal = datetime(tanggalStr, 'InputFormat', 'MM-yyyy');
% catch
%     error('Format tanggal tidak sesuai. Pastikan format tanggal adalah "MM-yyyy".');
% end
% 
% % Menghitung rata-rata SLA
% rata_rata_SLA = mean(SLA);
% 
% % Tampilkan hasil rata-rata SLA di Command Window
% fprintf('Rata-rata Sea Level Anomaly (SLA): %.4f m\n', rata_rata_SLA);
% 
% % Menghitung tren SLA
% tanggalNum = datenum(tanggal); % Konversi ke nomor seri tanggal
% p = polyfit(tanggalNum, SLA, 1); % Fit garis linear
% trenSLA = p(1) * 365.25; % Konversi kemiringan tren per tahun
% yfit = polyval(p, tanggalNum);
% 
% % Menghitung nilai R-squared
% SLA_mean = mean(SLA);
% SS_tot = sum((SLA - SLA_mean).^2);
% SS_res = sum((SLA - yfit).^2);
% R_squared = 1 - (SS_res / SS_tot);
% 
% % Tampilkan plot SLA tanpa garis tren
% figure;
% plot(tanggal, SLA, 'b');
% title('Sea Level Anomaly (SLA)');
% xlabel('Tahun');
% ylabel('Sea Level Anomaly (m)');
% legend('SLA', 'Location', 'Best');
% grid on;
% 
% % Format sumbu Y agar hanya menampilkan dua angka di belakang koma
% ax = gca;
% ax.YRuler.Exponent = 0; % Disable scientific notation
% ax.YAxis.TickLabelFormat = '%,.3f';
% 
% % Atur format sumbu X untuk menampilkan tahun
% xticks = linspace(datenum(tanggal(1)), datenum(tanggal(end)), numel(unique(year(tanggal))));
% xticks_datetime = datetime(xticks, 'ConvertFrom', 'datenum');
% ax.XTick = xticks_datetime;
% ax.XTickLabel = cellstr(datestr(xticks_datetime, 'yyyy')); % Format label XTick
% ax.XAxis.FontSize = 10;
% ax.XTickLabelRotation = 45;
% 
% 
% % Mencari tanggal SLA tertinggi dan terendah
% [SLA_tertinggi, idx_tertinggi] = max(SLA);
% [SLA_terendah, idx_terendah] = min(SLA);
% tanggal_tertinggi = tanggal(idx_tertinggi);
% tanggal_terendah = tanggal(idx_terendah);
% 
% % Tampilkan nilai tren di command window
% fprintf('Tren Sea Level Anomaly (SLA): %.4f m/tahun\n', trenSLA);
% 
% % Tampilkan nilai SLA tertinggi dan terendah beserta tanggalnya di command window
% fprintf('Sea Level Anomaly (SLA) Tertinggi: %.3f m pada %s\n', SLA_tertinggi, datestr(tanggal_tertinggi, 'mm-yyyy'));
% fprintf('Sea Level Anomaly (SLA) Terendah: %.3f m pada %s\n', SLA_terendah, datestr(tanggal_terendah, 'mm-yyyy'));
% 
% % Tampilkan persamaan tren dan nilai R-squared di Command Window
% fprintf('Persamaan Tren: y = %.5fx + %.5f\n', p(1), p(2));
% fprintf('Nilai R-squared: %.5f\n', R_squared);

%% ----------------------------------------------------------------------------------
% DENGAN NILAI TREN
% Memuat data Sea Level Anomaly dari file CSV
filename = 'SLA_1993_2023_kecil.csv';
data = readtable(filename, 'Delimiter', ';', 'ReadVariableNames', true);

% Asumsi kolom pertama adalah tanggal dalam format 'MM-YYYY' dan kolom kedua adalah data SLA
tanggalStr = data{:, 1}; % Ambil kolom tanggal sebagai string
SLA_str = data{:, 2}; % Data SLA sebagai string

% Hapus karakter yang tidak diinginkan dari kolom SLA dan konversi koma ke titik
SLA_str = strrep(SLA_str, ' ', '');
SLA_str = strrep(SLA_str, ',', '.');
SLA = str2double(SLA_str); % Konversi ke double

% Cetak nilai SLA setelah konversi untuk pemeriksaan
disp('Nilai SLA setelah konversi ke double:');
disp(SLA);

% Konversi string tanggal ke datetime dengan format 'MM-yyyy'
try
    tanggal = datetime(tanggalStr, 'InputFormat', 'MM-yyyy');
catch
    error('Format tanggal tidak sesuai. Pastikan format tanggal adalah "MM-yyyy".');
end

% Menghitung tren SLA
tanggalNum = datenum(tanggal); % Konversi ke nomor seri tanggal
p = polyfit(tanggalNum, SLA, 1); % Fit garis linear
trenSLA = p(1) * 365.25; % Konversi kemiringan tren per tahun
yfit = polyval(p, tanggalNum);

% Menghitung nilai R-squared
SLA_mean = mean(SLA);
SS_tot = sum((SLA - SLA_mean).^2);
SS_res = sum((SLA - yfit).^2);
R_squared = 1 - (SS_res / SS_tot);

% Tampilkan plot SLA dengan garis tren
figure;
plot(tanggal, SLA, 'b');
hold on;
plot(tanggal, yfit, 'r--', 'LineWidth', 2);
title('Tren Sea Level Anomaly (SLA)');
xlabel('Tahun');
ylabel('Sea Level Anomaly (m)');
legend('SLA', 'Tren', 'Location', 'Best');
grid on;

% Format sumbu Y agar hanya menampilkan dua angka di belakang koma
ax = gca;
ax.YRuler.Exponent = 0; % Disable scientific notation
ax.YAxis.TickLabelFormat = '%,.3f';

% Atur format sumbu X untuk menampilkan tahun
xticks = linspace(datenum(tanggal(1)), datenum(tanggal(end)), numel(unique(year(tanggal))));
xticks_datetime = datetime(xticks, 'ConvertFrom', 'datenum');
ax.XTick = xticks_datetime;
ax.XTickLabel = cellstr(datestr(xticks_datetime, 'yyyy')); % Format label XTick
ax.XAxis.FontSize = 10;
ax.XTickLabelRotation = 45;

% Mencari tanggal SLA tertinggi dan terendah
[SLA_tertinggi, idx_tertinggi] = max(SLA);
[SLA_terendah, idx_terendah] = min(SLA);
tanggal_tertinggi = tanggal(idx_tertinggi);
tanggal_terendah = tanggal(idx_terendah);

% Tampilkan nilai tren di command window
fprintf('Tren Sea Level Anomaly (SLA): %.4f m/tahun\n', trenSLA);

% Tampilkan nilai SLA tertinggi dan terendah beserta tanggalnya di command window
fprintf('Sea Level Anomaly (SLA) Tertinggi: %.3f m pada %s\n', SLA_tertinggi, datestr(tanggal_tertinggi, 'mm-yyyy'));
fprintf('Sea Level Anomaly (SLA) Terendah: %.3f m pada %s\n', SLA_terendah, datestr(tanggal_terendah, 'mm-yyyy'));

% Tampilkan persamaan tren dan nilai R-squared di Command Window
fprintf('Persamaan Tren: y = %.5fx + %.5f\n', p(1), p(2));
fprintf('Nilai R-squared: %.5f\n', R_squared);

% Bagian ini dihapus untuk menghilangkan teks y = dan R² pada plot
% text(tanggal(end-30), max(SLA)*0.8, sprintf('y = %.5fx + %.5f', p(1), p(2)), 'FontSize', 10, 'Color', 'k', 'BackgroundColor', 'w', 'EdgeColor', 'k');
% text(tanggal(end-30), max(SLA)*0.7, sprintf('R^2 = %.5f', R_squared), 'FontSize', 10, 'Color', 'k', 'BackgroundColor', 'w', 'EdgeColor', 'k');


