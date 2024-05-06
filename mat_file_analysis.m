# EEG Data opening

# 해당 Data는 struct 형태인 dataStruct에 존재.
# eegStruct에 19개 struct 저장.

fieldNames = fieldnames(dataStruct); % 구조체의 모든 필드 이름 가져오기
#{
eegStruct = struct();

# 필드의 Data에 순차적으로 접근하기

for i = 1:numel(fieldNames)
    % 현재 필드의 이름을 가져옵니다.
    fieldName = fieldNames{i};

    % 현재 필드(구조체)를 가져옵니다.
    currentStruct = dataStruct.(fieldName);

    % 현재 구조체 내의 'eeg' 필드에 접근합니다.
    if isfield(currentStruct, 'eeg')
        % 'eeg' 데이터를 새로운 구조체에 저장합니다.
        eegStruct.(fieldName) = currentStruct.eeg;
    else
        warning(['Field "eeg" not found in ', fieldName]);
    end
end
#}

# movement_left, movement_right, imagery_left, imagery_right, rest 데이터 추출.

% 추출할 eeg 데이터를 저장할 구조체를 생성합니다.
extractedData = struct();

% 각 필드(각각의 구조체)에 대해 반복합니다.
for i = 1:numel(fieldNames)
    % 현재 필드의 이름을 가져옵니다.
    fieldName = fieldNames{i};

    % 현재 구조체 내의 'eeg' 필드에 접근합니다.
    if isfield(dataStruct.(fieldName), 'eeg')
        % 'eeg' 구조체 내의 필드들을 각각의 새 변수에 저장합니다.
        currentEEGData = dataStruct.(fieldName).eeg;
        extractedData.(fieldName).movement_left = currentEEGData.movement_left;
        extractedData.(fieldName).movement_right = currentEEGData.movement_right;
        extractedData.(fieldName).imagery_left = currentEEGData.imagery_left;
        extractedData.(fieldName).imagery_right = currentEEGData.imagery_right;
        extractedData.(fieldName).rest = currentEEGData.rest;
    else
        warning(['Field "eeg" not found in ', fieldName]);
    end
end

# Data 내 변수 접근.
#{
Noise = eeg.noise
Rest = eeg.rest
Sampling_Rate = eeg.srate
Movement_Left = eeg.movement_left
Movement_Right = eeg.movement_right
Movement_Trials = eeg.n_movement_trials
Imagery_Left = eeg.imagery_left
Imagery_Right = eeg.imagery_right
Imagery_Trials = eeg.n_imagery_trials
Frame = eeg.frame
Imagery_Event = eeg.imagery_event
Comment = eeg.comment
Subject = eeg.subject
Bad_Trial_indices = eeg.bad_trial_indices
Psenloc = eeg.psenloc
Senloc = eeg.senloc

# data labeling
% step 1. Data load
data = load('s01.mat');

% step 2. Data, Label init.
% EEG 데이터 변수 X 초기화
X = data.eeg;  % EEG 데이터가 'eeg' 필드에 저장된다고 가정

% 레이블 변수 Y 초기화
Y = zeros(size(X, 1), 1);  % X의 행 수와 같은 크기의 Y 초기화

% step 3. Label 할당.
% 가정: 각 조건에 대한 인덱스가 미리 주어졌다고 가정
rest_indices = data.rest_indices;
movement_left_indices = data.movement_left_indices;
movement_right_indices = data.movement_right_indices;
imagery_left_indices = data.imagery_left_indices;
imagery_right_indices = data.imagery_right_indices;

% 레이블 할당
Y(rest_indices) = 1;           % 'rest' 조건에 대한 레이블
Y(movement_left_indices) = 2;  % 'movement_left' 조건에 대한 레이블
Y(movement_right_indices) = 3; % 'movement_right' 조건에 대한 레이블
Y(imagery_left_indices) = 4;   % 'imagery_left' 조건에 대한 레이블
Y(imagery_right_indices) = 5;  % 'imagery_right' 조건에 대한 레이블

% step 4. Save Data
save('labeled_data.csv', 'X', 'Y');
#}

