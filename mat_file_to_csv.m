% CSV로 저장할 데이터 형식 설정
dataTypes = {'movement_left', 'movement_right', 'imagery_left', 'imagery_right', 'rest'};

% 데이터 블록 크기 설정 (한 블록의 컬럼 수)
blockSize = 3584;

% 각 데이터 필드에 대해 반복
for i = 1:length(fieldNames) % 1 ~ 19까지 반복. 여기서는 EEG Data를 의미.
    fieldName = fieldNames{i}; % s01_mat ~ s52_mat를 의미.

    % 각 데이터 타입에 대해 반복
    for typeIdx = 1:length(dataTypes) % 1 ~ 5까지 반복. 위의 dataTypes를 의미.
        dataType = dataTypes{typeIdx};

        data = extractedData.(fieldName).(dataType);

        % 데이터의 컬럼 수를 확인하고 필요한 블록 수 계산
        totalColumns = size(data, 2);
        numBlocks = ceil(totalColumns / blockSize);

        % 데이터 블록 별로 반복
        for blockNum = 1:numBlocks
            % 블록의 시작과 끝 인덱스 계산
            startIndex = (blockNum - 1) * blockSize + 1;
            endIndex = min(blockNum * blockSize, totalColumns);

            % 블록 데이터 추출
            blockData = data(:, startIndex:endIndex);

            % CSV 파일 이름 설정
            csvFileName = sprintf('%s_%s_block%d.csv', dataType, fieldName, blockNum);

            % CSV 파일로 저장
            csvwrite(csvFileName, blockData);
        end
    end
end
