% Open the .m File
# open the .m file

% 저장하고자 하는 데이터 파일의 인덱스 목록
selected_Index = [1, 3, 4, 5, 6, 9, 10, 13, 14, 33, 35, 41, 43, 44, 46, 48, 49, 50, 52];

files = dir('*.mat'); % 현재 폴더 내의 모든 .mat 파일
dataStruct = struct(); % 데이터를 저장할 구조체 초기화

for i = selected_Index
    fileName = files(i).name;
    variableName = matlab.lang.makeValidName(fileName); % 파일 이름을 유효한 MATLAB 변수 이름으로 변환
    dataStruct.(variableName) = load(fileName); % 구조체에 데이터 저장
end

