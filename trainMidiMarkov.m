function markovTable = trainMidiMarkov(notes,modelOrder)
% Outputs a Markov Probability Table representing k-tuples of notes in a
%   training midi sequence. 
%
% Intputs: 
%   notes - training sequence; output of midiInfo(readmidi(file),0)
%   modelOrder - order of the Markov model (i.e. the value of k above)
%
% Output: 
%   markovTable - probability table of the following form: 
%       keys: strings of the form 'note1,note2,...,notek'
%       vals: cell arrays of the form {[count],[subMap]} 
%           -where count is the number of occurrences of the corresponing
%           key in the training data (note1,note2,...,notek)
%           -and subMap is a map containing counts for all k+1-sized tuples
%           with the first k notes equal to the corresponding key 
%           (note1,note2,...,notek,notek+1)
%
% Copyright (c) 2017 Joseph Kreitz (joekreitz@gmail.com)
% Acknowledgement: utilizes Ken Schutte's midi read/write package
% (http://www.kenschutte.com/midi)

% init Markov table 
markovTable = containers.Map();

% Enumerate k-tuples
for i = 1:size(notes,1)-modelOrder
    newKey = generateNewKey(notes,i,modelOrder);
    if ~isKey(markovTable,newKey) 
        markovTable(newKey) = {1};
    else
        currVal = markovTable(newKey);
        currVal(1) = {cell2mat(currVal(1))+1};
        markovTable(newKey) = currVal;
    end
    
    if mod(i,100) == 0
        disp('Enumerating k-tuples');
        disp(i);
        disp(size(notes,1)-modelOrder);
    end
end

% Collect counts of subsequent notes to keys in markovTable
markovKeys = keys(markovTable);
for j = 1:1:numel(keys(markovTable))
    newMap = containers.Map('KeyType','double','ValueType','double');
    for l = 1:size(notes,1)-modelOrder
        snippet = generateNewKey(notes,l,modelOrder);
        if strcmp(snippet,cell2mat(markovKeys(j)))
            if ~isKey(newMap,snippet)
                newMap(notes(l+modelOrder,3)) = 1;
            else
                newMap(notes(l+modelOrder,3)) = newMap(l+modelOrder) + 1;
                
            end
        end
    end
    currVal = markovTable(cell2mat(markovKeys(j)));
    currVal = {cell2mat(currVal),newMap};
    markovTable(cell2mat(markovKeys(j))) = currVal;
    
    if mod(j,100) == 0
        disp('Collecting counts');
        disp(j);
        disp(numel(keys(markovTable)));
    end
end



end