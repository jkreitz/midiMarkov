function lengthsMap = trainLengths(notes)
% Outputs a table representing lengths of each note in the training seq. 
% 
% Input: 
%   notes - training sequence; output of midiInfo(readmidi(file),0)
% 
% Output:
%   lengthsMap - map of the following form: 
%       keys: integers representing note values (60 = middle C)
%       values: lists depicting lengths of all notes of the corresponding
%               note values.

% Populate lengthsMap
disp('Training note length')
lengthsMap = containers.Map('KeyType','double','ValueType','any');
for x = 1:1:size(notes,1)
    note = notes(x,3);
    length = notes(x,6) - notes(x,5);
    if ~isKey(lengthsMap,note)
        lengthsMap(note) = [length];
    else
        lengthsMap(note) = [lengthsMap(note) length]; 
    end
end 


end